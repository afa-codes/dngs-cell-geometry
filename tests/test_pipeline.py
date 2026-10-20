"""Tests of the Delphi pipeline.

Run from the repository root:  python -m unittest discover tests

Pipeline: aggregation and scores on fixture round files (tests/fixtures/round-test),
no database needed.

Database: the SQL layer (sql/*.sql) on dumps of LimeSurvey 7.6 and 6.17 tables
with fictitious participants R001-R006 (tests/fixtures/limesurvey7.sql and
limesurvey6.sql). R001 and R006 chose the public level, R003 the named level,
the others anonymous; R006 answered only questionnaire 2. Runs only when
DELPHI_TEST_DSN points to a throwaway PostgreSQL database whose name starts
with "delphi_test" (its schemas are dropped), with a user that may create roles:

  createdb delphi_test
  DELPHI_TEST_DSN="postgresql://postgres@localhost/delphi_test" python -m unittest discover tests
"""
import csv
import io
import os
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
FIX = REPO / "tests" / "fixtures"
ROUND_FILES = ("respondents", "responses", "familiarity", "filter_votes", "grades", "open_answers", "panel_profile")


def rows(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


class Pipeline(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp = Path(tempfile.mkdtemp())
        cls.repo = cls.tmp / "repo"
        for d in ("data", "delphi", "scripts", "results", "sql"):
            shutil.copytree(REPO / d, cls.repo / d, ignore=shutil.ignore_patterns("__pycache__"))
        cls.rdir = cls.repo / "delphi" / "rounds" / "round-test"
        shutil.copytree(FIX / "round-test", cls.rdir)
        cls.script("delphi_aggregate.py", "--round", "round-test")
        cls.script("delphi_aggregate.py", "--round", "round-test", "--subset", "public")
        cls.script("compute.py", "--round", "round-test")
        cls.script("compute.py", "--round", "round-test", "--subset", "public")

    @classmethod
    def tearDownClass(cls):
        shutil.rmtree(cls.tmp)

    @classmethod
    def script(cls, name, *args):
        res = subprocess.run([sys.executable, str(cls.repo / "scripts" / name), *map(str, args)],
                             capture_output=True, text=True, cwd=cls.tmp)
        if res.returncode:
            raise AssertionError(f"{name} failed:\n{res.stdout}\n{res.stderr}")
        return res.stdout

    def test_small_groups_are_undisclosed(self):
        counts = {}
        for r in rows(self.rdir / "respondents.csv"):
            if r["public"] == "no" and r["group"] != "undisclosed":
                counts[(r["panel"], r["group"])] = counts.get((r["panel"], r["group"]), 0) + 1
        for key, n in counts.items():
            self.assertGreaterEqual(n, 3, f"group {key} shown with {n} non-public respondents")

    def test_aggregates_and_scores(self):
        self.assertEqual(len(rows(self.rdir / "weights.csv")), 14)
        self.assertEqual(len(rows(self.rdir / "consensus.csv")), 14 * 9)
        props = {r["code"]: r for r in rows(self.rdir / "properties.csv")}
        base = {r["code"]: r for r in rows(self.repo / "data" / "properties.csv")}
        for code in ("P1a", "P5", "P6", "P7"):
            self.assertEqual(props[code], base[code], "objective grades must never change")
        public = (self.repo / "results" / "round-test" / "public" / "summary.md").read_text(encoding="utf-8")
        self.assertIn("public respondents only", public)

    def test_round_00_unchanged(self):
        before = (REPO / "results" / "round-00" / "summary.md").read_text(encoding="utf-8")
        self.script("compute.py", "--round", "round-00")
        self.assertEqual(before, (self.repo / "results" / "round-00" / "summary.md").read_text(encoding="utf-8"))

    def test_survey_build_and_codes(self):
        committed = (REPO / "sql" / "20_codes.sql").read_text(encoding="utf-8")
        self.script("limesurvey_build.py", "--round", "round-test", "--admin-name", "Test",
                    "--admin-email", "test@example.org", "--expires", "2030-01-31")
        self.assertEqual(committed, (self.repo / "sql" / "20_codes.sql").read_text(encoding="utf-8"),
                         "sql/20_codes.sql is out of date: run scripts/limesurvey_build.py")
        for name, n_questions in (("survey_q1_geometry.txt", 18), ("survey_q2_applications.txt", 58)):
            lines = (self.rdir / name).read_text(encoding="utf-8").splitlines()
            self.assertEqual(sum(1 for l in lines if l.startswith("Q\t")), 2 * n_questions)


@unittest.skipUnless(os.environ.get("DELPHI_TEST_DSN"), "set DELPHI_TEST_DSN to run the database tests")
class Database(unittest.TestCase):
    DSN = os.environ.get("DELPHI_TEST_DSN", "")

    @classmethod
    def psql(cls, *args, sql=None, role=None):
        cmd = ["psql", cls.DSN, "-v", "ON_ERROR_STOP=1", "-q", "-X", *args]
        if sql is not None:
            cmd += ["-c", (f"set role {role}; " if role else "") + sql]
        res = subprocess.run(cmd, capture_output=True, text=True)
        if res.returncode:
            raise AssertionError(res.stderr)
        return res.stdout

    @classmethod
    def setup_version(cls, version):
        name = cls.psql("-At", sql="select current_database()").strip()
        if not name.startswith("delphi_test"):
            raise unittest.SkipTest(f"refusing to drop schemas in database {name!r}")
        cls.psql(sql="drop schema if exists delphi, api cascade; drop schema public cascade; create schema public")
        cls.psql("-f", str(FIX / f"limesurvey{version}.sql"))
        for f in ("10_core.sql", "20_codes.sql", "30_api.sql"):
            cls.psql("-f", str(REPO / "sql" / f))
        cls.psql(sql="insert into delphi.round (round, seq, sid_geometry, sid_applications) "
                     "values ('round-test', 1, 100101, 100102); select delphi.sync('round-test')")

    def view(self, name, columns, role=None):
        cols = ", ".join(f'"{c}"' for c in columns)
        out = self.psql(sql=f"copy (select {cols} from api.{name} where round = 'round-test') to stdout with csv header",
                        role=role)
        return list(csv.DictReader(io.StringIO(out.split("\n", 1)[1] if out.startswith("SET") else out)))

    def assert_views_match(self, folder, files):
        for f in files:
            expected = rows(folder / f"{f}.csv")
            columns = list(expected[0].keys())
            got = self.view(f, columns)
            key = lambda r: tuple(r[c] for c in columns)
            self.assertEqual(sorted(map(key, got)), sorted(map(key, expected)), f"api.{f} differs from {f}.csv")

    def test_limesurvey6(self):
        self.setup_version(6)
        self.assert_views_match(FIX / "round-test-ls6", ROUND_FILES)

    def test_limesurvey7_and_roles(self):
        self.setup_version(7)
        self.assert_views_match(FIX / "round-test", ROUND_FILES + ("panel",))
        # open round: nothing for anonymous requests, everything for the coordination
        self.assertEqual(self.view("responses", ["respondent_id"], role="delphi_anon"), [])
        self.assertEqual(len(self.view("responses", ["respondent_id"], role="delphi_coord")), 567)
        with self.assertRaises(AssertionError):
            self.psql(sql="select * from api.issues", role="delphi_anon")
        with self.assertRaises(AssertionError):
            self.psql(sql="select * from delphi.response", role="delphi_anon")
        # closed round: data public, panel list still not
        self.psql(sql="update delphi.round set closed_at = now()")
        self.assertEqual(len(self.view("responses", ["respondent_id"], role="delphi_anon")), 567)
        self.assertEqual(self.view("panel", ["name"], role="delphi_anon"), [])
        # feedback for a later round, called with the participant's token
        token = self.psql("-At", sql="select token from lime_tokens_100102 where attribute_1 = 'R002'").strip()
        self.psql(sql="insert into delphi.round (round, seq, sid_geometry, sid_applications) "
                      "values ('round-test2', 2, 100101, 100102)")
        out = self.psql("-At", sql=f"select f->>'respondent_id', f->>'previous_round', jsonb_array_length(f->'relevance') "
                                   f"from (select api.feedback('{token}') f) x", role="delphi_anon")
        self.assertEqual(out.strip().splitlines()[-1], "R002|round-test|126")
        # retention
        self.psql(sql="select delphi.purge('round-test')")
        left = self.psql("-At", sql="select (select count(*) from delphi.participant) || ' ' || "
                                    "(select count(*) from delphi.response where answers ? 'COIdesc')")
        self.assertEqual(left.strip(), "0 0")


if __name__ == "__main__":
    unittest.main()
