"""Shared loaders and scoring for the DNGS cell-geometry assessment."""
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
GEOMETRIES = ("square", "triangle", "hexagon")


def load_properties():
    with open(ROOT / "data" / "properties.csv", newline="", encoding="utf-8") as f:
        return {r["code"]: {g: float(r[g]) for g in GEOMETRIES} for r in csv.DictReader(f)}


def load_applications():
    with open(ROOT / "data" / "applications.csv", newline="", encoding="utf-8") as f:
        return {r["id"]: r for r in csv.DictReader(f)}


def load_weights(round_name):
    path = ROOT / "delphi" / "rounds" / round_name / "weights.csv"
    with open(path, newline="", encoding="utf-8") as f:
        return {r.pop("id"): {k: float(v) for k, v in r.items()} for r in csv.DictReader(f)}


def score(weights, props, geometry):
    """Weighted mean of property grades: sum(w*g) / sum(w)."""
    total = sum(weights.values())
    if total == 0:
        raise ValueError("application with all-zero weights")
    return sum(w * props[p][geometry] for p, w in weights.items()) / total


def eliminated(app, props, geometry):
    """Stage 1 filter: geometries failing exact nesting are inadmissible."""
    return app["requires_exact_nesting"] == "yes" and props["P1a"][geometry] < 1
