"""Aggregate Delphi responses into round weights and consensus flags.

Input : delphi/rounds/<round>/responses.csv (format of delphi/questionnaire_template.csv)
Output: delphi/rounds/<round>/weights.csv   (median relevance per application x property)
        delphi/rounds/<round>/consensus.csv (median, IQR, n, consensus flag)

Consensus criterion: interquartile range <= 1 on the 0-3 scale.
Usage: python scripts/delphi_aggregate.py --round round-01
"""
import argparse
import csv
import statistics
from collections import defaultdict
from common import ROOT, load_properties, load_applications

IQR_MAX = 1.0


def iqr(values):
    if len(values) < 2:
        return 0.0
    q = statistics.quantiles(values, n=4, method="inclusive")
    return q[2] - q[0]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--round", required=True)
    args = ap.parse_args()
    rdir = ROOT / "delphi" / "rounds" / args.round
    props = list(load_properties())
    apps = list(load_applications())

    answers = defaultdict(list)
    with open(rdir / "responses.csv", newline="", encoding="utf-8") as f:
        for r in csv.DictReader(f):
            v = float(r["relevance"])
            if not 0 <= v <= 3:
                raise ValueError(f"relevance out of range: {r}")
            answers[(r["application_id"], r["property"])].append(v)

    with open(rdir / "consensus.csv", "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["application_id", "property", "n", "median", "iqr", "consensus"])
        for (a, p), vs in sorted(answers.items()):
            w.writerow([a, p, len(vs), statistics.median(vs), iqr(vs), "yes" if iqr(vs) <= IQR_MAX else "no"])

    with open(rdir / "weights.csv", "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["id"] + props)
        for a in apps:
            w.writerow([a] + [statistics.median(answers[(a, p)]) if answers.get((a, p)) else 0 for p in props])
    print(f"Wrote weights.csv and consensus.csv in {rdir}")


if __name__ == "__main__":
    main()
