"""Compute per-application scores and group summaries for a given round.

Usage: python scripts/compute.py --round round-00
"""
import argparse
import csv
from common import ROOT, GEOMETRIES, load_properties, load_applications, load_weights, score, eliminated


def pct(x):
    return f"{round(100 * x)}%"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--round", default="round-00")
    args = ap.parse_args()

    props = load_properties()
    apps = load_applications()
    weights = load_weights(args.round)
    out = ROOT / "results" / args.round
    out.mkdir(parents=True, exist_ok=True)

    rows = []
    for aid, app in apps.items():
        row = {"id": aid, "application": app["application"],
               "requires_exact_nesting": app["requires_exact_nesting"]}
        for g in GEOMETRIES:
            s = score(weights[aid], props, g)
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
    lines = [f"# Summary — {args.round}", "",
             "| Group | Applications | Square | Triangle | Hexagon |", "|---|---|---|---|---|"]
    for name, rs in groups.items():
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
    (out / "summary.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("\n".join(lines))


if __name__ == "__main__":
    main()
