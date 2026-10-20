"""Compute per-application scores and group summaries for a given round.

Uses the round's weights.csv and, when the panel has decided them, its
properties.csv (grades) and filter.csv (stage 1 filter); otherwise the
baseline in data/.

Usage: python scripts/compute.py --round round-01 [--subset public]
"""
import argparse
import csv
from common import (GEOMETRIES, SUBSETS, round_dir, results_dir, load_properties, load_applications,
                    load_weights, score, eliminated)


def pct(x):
    return f"{round(100 * x)}%"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--round", default="round-00")
    ap.add_argument("--subset", choices=SUBSETS, default="all")
    args = ap.parse_args()

    props = load_properties(args.round, args.subset)
    apps = load_applications(args.round, args.subset)
    weights = load_weights(args.round, args.subset)
    out = results_dir(args.round, args.subset)
    out.mkdir(parents=True, exist_ok=True)

    rows = []
    for aid, app in apps.items():
        row = {"id": aid, "application": app["application"],
               "requires_exact_nesting": app["requires_exact_nesting"]}
        for g in GEOMETRIES:
            s = score(weights[aid], props, g)
            if s is None:  # no weight at all for this application in this subset
                row[f"{g}_raw"], row[g] = "", "n/a"
                continue
            row[f"{g}_raw"] = round(s, 4)
            row[g] = "eliminated" if eliminated(app, props, g) else round(s, 4)
        rows.append(row)

    with open(out / "scores_by_application.csv", "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)

    groups = {"YES (requires exact nesting)": [r for r in rows if r["requires_exact_nesting"] == "yes"],
              "NO (no such requirement)": [r for r in rows if r["requires_exact_nesting"] == "no"],
              "Total": rows}
    rdir = round_dir(args.round, args.subset)
    title = args.round + (" — public respondents only" if args.subset == "public" else "")
    lines = [f"# Summary — {title}", ""]
    if (rdir / "properties.csv").exists() or (rdir / "filter.csv").exists():
        who = "public panellists" if args.subset == "public" else "panel"
        lines += ["Grades: " + (f"{who} medians (properties.csv)" if (rdir / "properties.csv").exists()
                               else "baseline (data/properties.csv)")
                  + ". Filter: " + (f"{who} decision (filter.csv)" if (rdir / "filter.csv").exists()
                                    else "baseline (data/applications.csv)") + "."]
        if args.subset == "public":
            lines += ["Items no public panellist answered keep the full panel's grades and filter decision,",
                      "and relevance items they did not rate are left out of the scores."]
        lines += [""]
    lines += ["| Group | Applications | Square | Triangle | Hexagon |", "|---|---|---|---|---|"]
    for name, rs in groups.items():
        rs = [r for r in rs if r[GEOMETRIES[0]] != "n/a"]
        if not rs:
            lines.append(f"| {name} | 0 | n/a | n/a | n/a |")
            continue
        cells = []
        for g in GEOMETRIES:
            filtered = [0.0 if r[g] == "eliminated" else r[g] for r in rs]
            raw = [r[f"{g}_raw"] for r in rs]
            m_f, m_raw = sum(filtered) / len(rs), sum(raw) / len(rs)
            if all(r[g] == "eliminated" for r in rs):
                cells.append(f"eliminated ({pct(m_raw)} without filter)")
            elif any(r[g] == "eliminated" for r in rs):
                cells.append(f"{pct(m_f)} ({pct(m_raw)} without filter)")
            else:
                cells.append(pct(m_f))
        lines.append(f"| {name} | {len(rs)} | " + " | ".join(cells) + " |")
    lines += ["", "Each percentage is the mean degree to which a geometry satisfies the properties",
              "relevant to the group. Eliminated geometries count as zero in the filtered totals."]
    unscored = [r["id"] for r in rows if r[GEOMETRIES[0]] == "n/a"]
    if unscored:
        lines += ["", f"Not scored (no weight in this subset): {', '.join(unscored)}."]
    (out / "summary.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("\n".join(lines))


if __name__ == "__main__":
    main()
