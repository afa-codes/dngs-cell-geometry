"""Shared loaders and scoring for the DNGS cell-geometry assessment."""
import csv
import statistics
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
GEOMETRIES = ("square", "triangle", "hexagon")
MIN_ANONYMOUS = 3   # k: a group is shown per respondent only with 0 or >= k non-public members
MIN_RESPONSES = 3   # fewer panel answers than this keep the previous (baseline) value


SUBSETS = ("all", "public")  # all respondents, or only those who chose the public disclosure level


def round_dir(round_name, subset="all"):
    """Folder of a round's panel data; the public-only subset lives in a subfolder."""
    base = ROOT / "delphi" / "rounds" / round_name
    return base if subset == "all" else base / subset


def results_dir(round_name, subset="all"):
    base = ROOT / "results" / round_name
    return base if subset == "all" else base / subset


def read_csv(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def write_csv(path, rows, fieldnames):
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        w.writeheader()
        w.writerows(rows)


def load_properties_table(round_name=None, subset="all"):
    """Rows of properties.csv: the round's own file if the panel has graded, else data/."""
    path = ROOT / "data" / "properties.csv"
    if round_name and (round_dir(round_name, subset) / "properties.csv").exists():
        path = round_dir(round_name, subset) / "properties.csv"
    return read_csv(path)


def load_properties(round_name=None, subset="all"):
    return {r["code"]: {g: float(r[g]) for g in GEOMETRIES} for r in load_properties_table(round_name, subset)}


def load_applications(round_name=None, subset="all"):
    """Applications, with the stage 1 filter decided by the panel if the round has filter.csv."""
    apps = {r["id"]: r for r in read_csv(ROOT / "data" / "applications.csv")}
    if round_name and (round_dir(round_name, subset) / "filter.csv").exists():
        for r in read_csv(round_dir(round_name, subset) / "filter.csv"):
            if r["id"] in apps:
                apps[r["id"]]["requires_exact_nesting"] = r["requires_exact_nesting"]
    return apps


def load_weights(round_name, subset="all"):
    """Weights per application; blank cells are returned as None and skipped in scores."""
    path = round_dir(round_name, subset) / "weights.csv"
    with open(path, newline="", encoding="utf-8") as f:
        return {r.pop("id"): {k: (float(v) if v != "" else None) for k, v in r.items()}
                for r in csv.DictReader(f)}


def score(weights, props, geometry):
    """Weighted mean of property grades: sum(w*g) / sum(w). Missing weights are skipped;
    returns None when no weight is left (e.g. no public panellist rated the application)."""
    present = {p: w for p, w in weights.items() if w is not None}
    if not present:
        return None
    total = sum(present.values())
    if total == 0:
        raise ValueError("application with all-zero weights")
    return sum(w * props[p][geometry] for p, w in present.items()) / total


def eliminated(app, props, geometry):
    """Stage 1 filter: geometries failing exact nesting are inadmissible."""
    return app["requires_exact_nesting"] == "yes" and props["P1a"][geometry] < 1


def iqr(values):
    if len(values) < 2:
        return 0.0
    q = statistics.quantiles(values, n=4, method="inclusive")
    return q[2] - q[0]


