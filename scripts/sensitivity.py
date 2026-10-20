"""Monte Carlo sensitivity of the geometry ranking to weight perturbations.

Each nonzero weight is perturbed by a random integer in [-k, k] (clipped to 0-3,
never dropped to zero) and the filtered total ranking is recomputed.
Usage: python scripts/sensitivity.py --round round-00 --runs 10000 --k 1 [--subset public]
"""
import argparse
import random
from collections import Counter
from common import (GEOMETRIES, SUBSETS, results_dir, load_properties, load_applications, load_weights,
                    score, eliminated)


def totals(apps, props, weights):
    scored = [a for a in apps if score(weights[a], props, GEOMETRIES[0]) is not None]
    t = {}
    for g in GEOMETRIES:
        t[g] = sum(0.0 if eliminated(apps[a], props, g) else score(weights[a], props, g) for a in scored) / len(scored)
    return t


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--round", default="round-00")
    ap.add_argument("--runs", type=int, default=10000)
    ap.add_argument("--k", type=int, default=1)
    ap.add_argument("--seed", type=int, default=42)
    ap.add_argument("--subset", choices=SUBSETS, default="all")
    args = ap.parse_args()
    rnd = random.Random(args.seed)
    props = load_properties(args.round, args.subset)
    apps = load_applications(args.round, args.subset)
    base = load_weights(args.round, args.subset)

    rankings, square_first = Counter(), 0
    for _ in range(args.runs):
        w = {a: {p: (min(3, max(1, v + rnd.randint(-args.k, args.k))) if v else v)
                 for p, v in ws.items()} for a, ws in base.items()}
        t = totals(apps, props, w)
        order = tuple(sorted(GEOMETRIES, key=lambda g: -t[g]))
        rankings[order] += 1
        square_first += order[0] == "square"

    lines = [f"# Sensitivity — {args.round} (runs={args.runs}, k=±{args.k})", "",
             f"Square ranked first in {100 * square_first / args.runs:.1f}% of runs.", "",
             "| Ranking | Share |", "|---|---|"]
    lines += [f"| {' > '.join(o)} | {100 * c / args.runs:.1f}% |" for o, c in rankings.most_common()]
    out = results_dir(args.round, args.subset)
    out.mkdir(parents=True, exist_ok=True)
    (out / "sensitivity.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("\n".join(lines))


if __name__ == "__main__":
    main()
