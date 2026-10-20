"""Fetch a round's pseudonymous files from PostgREST into the repository.

The views in schema api (sql/30_api.sql) are read as CSV and written with the
same layout as the other files of delphi/rounds/<round>/. Anonymous access
sees a round only after it is closed (delphi.round.closed_at); with the
coordination's JWT (scripts/postgrest_jwt.py) it can be fetched at any time,
and the problems listed in api.issues are printed.

  python scripts/postgrest_fetch.py --round round-01 --url https://delphi.example.org/api
  python scripts/postgrest_fetch.py --round round-01 --url ... --panel   # panel list too
  DELPHI_JWT=... python scripts/postgrest_fetch.py --round round-01 --url ...

--panel writes results/<round>/panel.csv and panel.md (names only for the
named and public levels), available once delphi.round.panel_published_at is set.
"""
import argparse
import csv
import io
import os
import sys
import urllib.error
import urllib.parse
import urllib.request

from common import results_dir, round_dir, write_csv

ROUND_FILES = {  # file -> (view, columns, order)
    "respondents.csv": ("respondents", ["respondent_id", "panel", "group", "public"], "panel.desc,respondent_id"),
    "responses.csv": ("responses", ["respondent_id", "group", "application_id", "property", "relevance", "comment"],
                      "respondent_id,application_id,property"),
    "familiarity.csv": ("familiarity", ["respondent_id", "group", "application_id", "familiarity"],
                        "respondent_id,application_id"),
    "filter_votes.csv": ("filter_votes", ["respondent_id", "group", "application_id", "requires_exact_nesting",
                                          "justification"], "respondent_id,application_id"),
    "grades.csv": ("grades", ["respondent_id", "group", "property", "square", "triangle", "hexagon", "justification"],
                   "respondent_id,property"),
    "open_answers.csv": ("open_answers", ["respondent_id", "panel", "group", "item", "text"],
                         "panel.desc,respondent_id,item"),
    "panel_profile.csv": ("panel_profile", ["panel", "field", "value", "count"], "panel,field,value"),
}
PANEL = ("panel", ["name", "institution", "panels", "level", "respondent_id", "conflict_of_interest"], "name")


def true(value):
    """PostgREST writes booleans in CSV as t/f."""
    return value in ("t", "true")


class Api:
    def __init__(self, url, jwt):
        self.url, self.jwt = url.rstrip("/"), jwt

    def get(self, view, columns=None, order=None, **filters):
        params = {k: f"eq.{v}" for k, v in filters.items()}
        if columns:
            params["select"] = ",".join(columns)
        if order:
            params["order"] = order
        req = urllib.request.Request(f"{self.url}/{view}?{urllib.parse.urlencode(params)}",
                                     headers={"Accept": "text/csv"})
        if self.jwt:
            req.add_header("Authorization", f"Bearer {self.jwt}")
        try:
            with urllib.request.urlopen(req, timeout=120) as r:
                text = r.read().decode("utf-8")
        except urllib.error.HTTPError as e:
            sys.exit(f"{view}: HTTP {e.code} {e.read().decode('utf-8', 'replace')[:300]}")
        return list(csv.DictReader(io.StringIO(text)))


def panel_markdown(round_name, panel, composition, coi):
    levels = [r["level"] for r in panel]
    lines = [f"# Panel — {round_name}", "",
             f"Named and public panellists: {levels.count('public')} public, {levels.count('named')} named.", "",
             "## Composition", "", "| Panel | Group | Respondents |", "|---|---|---|"]
    lines += [f"| {r['panel']} | {r['group']} | {r['respondents']} |" for r in composition]
    lines += ["", "## Named and public panellists", "",
              "Answers of public panellists can be found under their respondent code in the round files. "
              "Answers of named panellists are not attributed, and their panels are not shown.", "",
              "| Name | Institution | Panels | Level | Code | Conflict of interest |", "|---|---|---|---|---|---|"]
    lines += [f"| {r['name']} | {r['institution']} | {r['panels']} | {r['level']} | {r['respondent_id']} | "
              f"{r['conflict_of_interest']} |" for r in panel]
    lines += ["", "## Conflict of interest of anonymous panellists", "",
              "| Panel | Group | Anonymous respondents | Declared a link |", "|---|---|---|---|"]
    lines += [f"| {r['panel']} | {r['group']} | {r['respondents']} | {r['declared']} |" for r in coi]
    return "\n".join(lines) + "\n"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--round", required=True)
    ap.add_argument("--url", required=True, help="PostgREST base URL")
    ap.add_argument("--panel", action="store_true", help="also fetch the panel list")
    args = ap.parse_args()
    api = Api(args.url, os.environ.get("DELPHI_JWT", ""))

    status = api.get("rounds", round=args.round)
    if not status:
        sys.exit(f"{args.round} is not registered in delphi.round")
    if not true(status[0]["closed"]) and not api.jwt:
        sys.exit(f"{args.round} is still open: its data are visible only with the coordination's JWT (DELPHI_JWT)")

    out = round_dir(args.round)
    for name, (view, columns, order) in ROUND_FILES.items():
        rows = api.get(view, columns, order, round=args.round)
        write_csv(out / name, rows, columns)
        print(f"{name}: {len(rows)} rows")

    if api.jwt:
        issues = api.get("issues", order="panel,respondent_id", round=args.round)
        for i in issues:
            print(f"issue: {i['panel'] or '-'} {i['respondent_id']}: {i['issue']}")

    if args.panel:
        if not true(status[0]["panel_published"]) and not api.jwt:
            sys.exit("the panel list is not published yet (delphi.round.panel_published_at)")
        view, columns, order = PANEL
        panel = api.get(view, columns, order, round=args.round)
        composition = api.get("composition", ["panel", "group", "respondents"], "panel,group", round=args.round)
        coi = api.get("coi_anonymous", ["panel", "group", "respondents", "declared"], "panel,group", round=args.round)
        res = results_dir(args.round)
        write_csv(res / "panel.csv", panel, columns)
        (res / "panel.md").write_text(panel_markdown(args.round, panel, composition, coi), encoding="utf-8")
        print(f"panel.csv and panel.md written to {res}")
    print("Review open_answers.csv and the comment/justification columns for identifying text before committing.")


if __name__ == "__main__":
    main()
