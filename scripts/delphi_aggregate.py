"""Aggregate a Delphi round into weights, the stage 1 filter and geometry grades.

Inputs in delphi/rounds/<round>/ (fetched from the API by postgrest_fetch.py):
  responses.csv      relevance 0-3 per application x property  (applications panel)
  filter_votes.csv   does the application require exact nesting? (applications panel)
  grades.csv         grade 0-1 per judgment property x geometry  (geometry panel)
  respondents.csv    needed only for --subset public

Outputs, in the same folder (or in its public/ subfolder with --subset public):
  weights.csv           median relevance per application x property
  consensus.csv         n, median, IQR, distribution and consensus per item
  filter.csv            votes and decision per application
  properties.csv        grades used by compute.py (objective grades never change)
  grades_consensus.csv  n, median, IQR and consensus per property x geometry

Rules (see delphi/protocol.md):
  relevance  consensus when IQR <= 1 on the 0-3 scale
  grades     consensus when IQR <= 1/3 on the 0-1 scale (same share of the scale)
  filter     majority of yes/no votes ("don't know" abstains); a tie keeps the
             previous value; consensus when the majority holds >= 75% of the votes
  any item with fewer than MIN_RESPONSES answers keeps its baseline value
             (weights of --baseline, data/properties.csv, data/applications.csv)

Public subset (--subset public): only the answers of panellists who chose the
public disclosure level count, and a single answer is enough. A relevance item
no public panellist answered is left blank, so it drops out of the score; a
grade or filter decision no public panellist voted on keeps the full panel's
result. Run the full aggregation first.

Usage: python scripts/delphi_aggregate.py --round round-01 [--subset public] [--baseline round-00]
"""
import argparse
import statistics
from collections import Counter

from common import (GEOMETRIES, MIN_RESPONSES, SUBSETS, ROOT, iqr, read_csv, round_dir, write_csv,
                    load_applications, load_properties_table)

IQR_MAX_RELEVANCE = 1.0
IQR_MAX_GRADE = 1 / 3
FILTER_CONSENSUS = 0.75


def keep(rows, ids):
    return [r for r in rows if ids is None or r["respondent_id"] in ids]


def fmt(x):
    return f"{x:g}" if isinstance(x, float) else x


def aggregate_relevance(rows, apps, props, baseline, min_n=MIN_RESPONSES):
    answers = {}
    for r in rows:
        if r["relevance"] != "":
            v = float(r["relevance"])
            if not 0 <= v <= 3:
                raise ValueError(f"relevance out of range: {r}")
            answers.setdefault((r["application_id"], r["property"]), []).append(v)
    weights, cons = {a: {} for a in apps}, []
    for a in apps:
        for p in props:
            vs = answers.get((a, p), [])
            dist = Counter(int(v) for v in vs)
            row = {"application_id": a, "property": p, "n": len(vs),
                   **{f"n{k}": dist.get(k, 0) for k in range(4)}}
            if len(vs) >= min_n:
                med, q = statistics.median(vs), iqr(vs)
                weights[a][p] = med
                row.update(median=fmt(med), iqr=fmt(q), source="panel",
                           consensus=("yes" if q <= IQR_MAX_RELEVANCE else "no") if len(vs) >= MIN_RESPONSES else "")
            else:
                weights[a][p] = baseline[a][p] if baseline else ""
                row.update(median=fmt(statistics.median(vs)) if vs else "", iqr=fmt(iqr(vs)) if vs else "",
                           consensus="", source="baseline" if baseline else "omitted")
            cons.append(row)
    return weights, cons


def aggregate_filter(rows, apps, min_n=MIN_RESPONSES, fallback="baseline"):
    votes = {a: Counter() for a in apps}
    for r in rows:
        if r["requires_exact_nesting"]:
            votes[r["application_id"]][r["requires_exact_nesting"]] += 1
    out = []
    for a, app in apps.items():
        c = votes[a]
        yes, no, unk = c["yes"], c["no"], c["unknown"]
        decided = yes + no
        row = {"id": a, "application": app["application"], "yes": yes, "no": no, "unknown": unk,
               "baseline": app["requires_exact_nesting"]}
        if decided >= min_n and yes != no:
            row["requires_exact_nesting"] = "yes" if yes > no else "no"
            share = max(yes, no) / decided
            row.update(majority_share=f"{share:.2f}", source="panel",
                       consensus=("yes" if share >= FILTER_CONSENSUS else "no") if decided >= MIN_RESPONSES else "")
        else:
            row.update(requires_exact_nesting=app["requires_exact_nesting"], majority_share="", consensus="",
                       source=fallback if decided < min_n else f"{fallback} (tie)")
        out.append(row)
    return out


def aggregate_grades(rows, table, min_n=MIN_RESPONSES, fallback="baseline"):
    answers = {}
    for r in rows:
        for g in GEOMETRIES:
            if r.get(g, "") != "":
                answers.setdefault((r["property"], g), []).append(float(r[g]))
    props_out, cons = [], []
    for p in table:
        new = dict(p)
        for g in GEOMETRIES:
            vs = answers.get((p["code"], g), [])
            row = {"property": p["code"], "type": p["type"], "geometry": g, "baseline": p[g], "n": len(vs)}
            if p["type"] == "judgment" and len(vs) >= min_n:
                med, q = statistics.median(vs), iqr(vs)
                new[g] = fmt(round(med, 4))
                row.update(median=fmt(round(med, 4)), iqr=fmt(round(q, 4)), source="panel",
                           consensus=("yes" if q <= IQR_MAX_GRADE + 1e-9 else "no") if len(vs) >= MIN_RESPONSES else "")
            else:
                row.update(median=fmt(round(statistics.median(vs), 4)) if vs else "",
                           iqr=fmt(round(iqr(vs), 4)) if vs else "", consensus="",
                           source="objective" if p["type"] == "objective" else fallback)
            cons.append(row)
        props_out.append(new)
    return props_out, cons


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--round", required=True)
    ap.add_argument("--subset", choices=SUBSETS, default="all")
    ap.add_argument("--baseline", default="round-00", help="round whose weights fill items with too few answers")
    args = ap.parse_args()
    src, dst = round_dir(args.round), round_dir(args.round, args.subset)

    apps = load_applications()
    table = load_properties_table()
    props = [p["code"] for p in table]
    baseline = {r["id"]: {p: float(r[p]) for p in props} for r in read_csv(round_dir(args.baseline) / "weights.csv")}
    ids, min_n, fallback = None, MIN_RESPONSES, "baseline"
    if args.subset == "public":
        ids = {r["respondent_id"] for r in read_csv(src / "respondents.csv") if r["public"] == "yes"}
        print(f"Public subset: {len(ids)} respondent(s)")
        pairs = (("responses.csv", "weights.csv"), ("filter_votes.csv", "filter.csv"), ("grades.csv", "properties.csv"))
        missing = [out for inp, out in pairs if (src / inp).exists() and not (src / out).exists()]
        if missing:
            raise SystemExit(f"run the full aggregation first (missing {missing} in {src})")
        apps = load_applications(args.round)      # full panel's filter decision
        table = load_properties_table(args.round)  # full panel's grades
        baseline, min_n, fallback = None, 1, "full panel"

    written = []
    if (src / "responses.csv").exists():
        weights, cons = aggregate_relevance(keep(read_csv(src / "responses.csv"), ids), apps, props, baseline, min_n)
        write_csv(dst / "weights.csv", [{"id": a, **{p: fmt(weights[a][p]) for p in props}} for a in apps],
                  ["id"] + props)
        write_csv(dst / "consensus.csv", cons, ["application_id", "property", "n", "median", "iqr", "consensus",
                                                 "source", "n0", "n1", "n2", "n3"])
        written += ["weights.csv", "consensus.csv"]
        n_panel = sum(1 for c in cons if c["source"] == "panel")
        n_cons = sum(1 for c in cons if c["consensus"] == "yes")
        print(f"Relevance: {n_panel}/{len(cons)} items decided by the panel, {n_cons} with consensus")
    if (src / "filter_votes.csv").exists():
        flt = aggregate_filter(keep(read_csv(src / "filter_votes.csv"), ids), apps, min_n, fallback)
        write_csv(dst / "filter.csv", flt, ["id", "application", "yes", "no", "unknown", "majority_share",
                                            "requires_exact_nesting", "consensus", "source", "baseline"])
        written.append("filter.csv")
        changed = [f["id"] for f in flt if f["requires_exact_nesting"] != f["baseline"]]
        print(f"Filter: {sum(f['source'] == 'panel' for f in flt)}/{len(flt)} decided by the panel; "
              f"changed from {'baseline' if fallback == 'baseline' else 'full panel'}: {changed or 'none'}")
    if (src / "grades.csv").exists():
        new_table, gcons = aggregate_grades(keep(read_csv(src / "grades.csv"), ids), table, min_n, fallback)
        write_csv(dst / "properties.csv", new_table, list(table[0].keys()))
        write_csv(dst / "grades_consensus.csv", gcons, ["property", "type", "geometry", "n", "median", "iqr",
                                                        "consensus", "source", "baseline"])
        written += ["properties.csv", "grades_consensus.csv"]
        print(f"Grades: {sum(g['source'] == 'panel' for g in gcons)} judgment grades decided by the panel")
    if not written:
        raise SystemExit(f"no response files in {src}")
    print(f"Wrote {', '.join(written)} in {dst.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
