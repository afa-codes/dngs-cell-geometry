"""Build the LimeSurvey survey structures of a Delphi round.

Generates two bilingual (pt-BR + en) survey files in LimeSurvey's
tab-separated survey format (.txt), importable through
"Create survey > Import" in LimeSurvey 6 or later:

  delphi/rounds/<round>/survey_q1_geometry.txt      geometry panel
  delphi/rounds/<round>/survey_q2_applications.txt  applications panel

Applications and properties come from data/ (with translations in data/i18n/);
all other wording comes from delphi/limesurvey/texts.json. It also writes
sql/20_codes.sql, the answer codes used by the database views. Do not edit the
generated files by hand: change the sources and rebuild.

Usage:
  python scripts/limesurvey_build.py --round round-01 \
      --admin-name "Coordenação DGGS-4N" --admin-email delphi@example.org \
      --expires 2026-12-15
"""
import argparse
import csv
import html
import io
import json

from common import ROOT, GEOMETRIES, MIN_ANONYMOUS, load_properties_table, load_applications
import survey_schema as S

ATTRIBUTES = ("hidden", "equation", "multiflexible_min", "multiflexible_max",
              "multiflexible_step", "input_boxes", "exclude_all_others",
              "display_rows", "answer_width")
COLUMNS = ("class", "type/scale", "name", "relevance", "text", "help", "language",
           "validation", "mandatory", "other", "default", "same_default") + ATTRIBUTES


def load_i18n(name, key):
    out = {}
    with open(ROOT / "data" / "i18n" / name, newline="", encoding="utf-8") as f:
        for r in csv.DictReader(f):
            out[(r[key], r["lang"])] = r
    return out


def paragraphs(items, **fmt):
    return "".join(f"<p>{p.format(**fmt)}</p>" for p in items)


def table(header, rows):
    th = "".join(f"<th>{h}</th>" for h in header)
    body = "".join("<tr>" + "".join(f"<td>{c}</td>" for c in row) + "</tr>" for row in rows)
    return (f'<table class="table table-bordered table-condensed"><thead><tr>{th}</tr></thead>'
            f"<tbody>{body}</tbody></table>")


def num(value, lang):
    s = f"{float(value):g}"
    return s.replace(".", ",") if lang.startswith("pt") else s


class Survey:
    """Collects rows language by language, in the order LimeSurvey exports them."""

    def __init__(self):
        self.head = []
        self.body = {lang: [] for lang in S.LANGUAGES}
        self.group_seq = 0

    def setting(self, name, value):
        self.head.append({"class": "S", "name": name, "text": value})

    def lang_setting(self, lang, name, value):
        self.head.append({"class": "SL", "name": name, "text": value, "language": lang})

    def group(self, names, descriptions=None, relevance="1"):
        self.group_seq += 1
        for lang in S.LANGUAGES:
            self.body[lang].append({"class": "G", "type/scale": self.group_seq, "name": names[lang],
                                    "text": (descriptions or {}).get(lang, ""), "relevance": relevance,
                                    "language": lang})

    def question(self, qtype, code, texts, *, mandatory="N", relevance="1", helps=None,
                 other="N", subquestions=(), columns=(), answers=(), **attributes):
        """texts/helps: {lang: str}; subquestions/columns: [(code, {lang: text}, relevance)];
        answers: [(code, {lang: text})]."""
        for lang in S.LANGUAGES:
            row = {"class": "Q", "type/scale": qtype, "name": code, "text": texts[lang],
                   "help": (helps or {}).get(lang, ""), "relevance": relevance, "language": lang,
                   "mandatory": mandatory, "other": other}
            row.update({k: v for k, v in attributes.items() if v is not None})
            self.body[lang].append(row)
            for scale, items in ((0, subquestions), (1, columns)):
                for sq in items:
                    sq_code, sq_text = sq[0], sq[1]
                    sq_rel = sq[2] if len(sq) > 2 else "1"
                    self.body[lang].append({"class": "SQ", "type/scale": scale or "", "name": sq_code,
                                            "text": sq_text[lang], "relevance": sq_rel, "language": lang})
            for a_code, a_text in answers:
                self.body[lang].append({"class": "A", "type/scale": 0, "name": a_code,
                                        "text": a_text[lang], "language": lang})

    def write(self, path):
        buf = io.StringIO()
        w = csv.DictWriter(buf, fieldnames=COLUMNS, delimiter="\t", quotechar='"',
                           lineterminator="\n", extrasaction="raise")
        w.writeheader()
        for row in self.head + [r for lang in S.LANGUAGES for r in self.body[lang]]:
            for k, v in row.items():
                if isinstance(v, str) and ("\n" in v or "\\" in v):
                    raise ValueError(f"newline or backslash not allowed in TSV field {k}: {v[:60]}")
            w.writerow({k: ("" if v is None else v) for k, v in row.items()})
        path.write_text(buf.getvalue(), encoding="utf-8")


def per_lang(texts, *keys, **fmt):
    out = {}
    for lang in S.LANGUAGES:
        node = texts[lang]
        for k in keys:
            node = node[k]
        out[lang] = node.format(**fmt) if fmt else node
    return out


def options(texts, *keys):
    """[(code, {lang: label})] for an options dict, in the base-language order."""
    by_lang = per_lang(texts, *keys)
    return [(code, {lang: by_lang[lang][code] for lang in S.LANGUAGES}) for code in by_lang[S.LANGUAGES[0]]]


def survey_id(round_name, panel):
    """Deterministic survey ID: 1RRRPP (round number, panel 1 or 2). LimeSurvey
    assigns a new ID on import if this one is already taken."""
    digits = "".join(ch for ch in round_name if ch.isdigit()) or "0"
    return str(100000 + 100 * int(digits) + int(panel[1]))


def common_setup(sv, texts, panel, args):
    sv.setting("sid", survey_id(args.round, panel))
    sv.setting("language", S.LANGUAGES[0])
    sv.setting("additional_languages", " ".join(S.LANGUAGES[1:]))
    settings = {
        "admin": args.admin_name, "adminemail": args.admin_email, "bounce_email": args.admin_email,
        "anonymized": "N", "format": "G", "datestamp": "N", "ipaddr": "N", "refurl": "N",
        "savetimings": "N", "usecookie": "N", "allowregister": "N", "allowsave": "N",
        "allowprev": "Y", "showprogress": "Y", "questionindex": "1", "showwelcome": "Y",
        "showxquestions": "N", "showgroupinfo": "B", "showqnumcode": "X", "shownoanswer": "Y",
        "tokenanswerspersistence": "Y", "alloweditaftercompletion": "Y", "htmlemail": "Y",
        "listpublic": "N", "publicstatistics": "N", "publicgraphs": "N", "printanswers": "Y",
        "attributedescriptions": json.dumps({
            "attribute_1": {"description": "respondent_id", "mandatory": "Y", "encrypted": "N",
                            "show_register": "N", "cpdbmap": ""},
            "attribute_2": {"description": "institution", "mandatory": "N", "encrypted": "N",
                            "show_register": "N", "cpdbmap": ""}}),
    }
    if args.expires:
        settings["expires"] = f"{args.expires} 23:59:00"
    for k, v in settings.items():
        if v:
            sv.setting(k, v)
    for lang in S.LANGUAGES:
        t, c = texts[lang][panel], texts[lang]["common"]
        intro = paragraphs(t["intro"], anonymity=c["anonymity"])
        if args.expires:
            intro += f"<p><strong>{c['deadline']}:</strong> {args.expires}</p>"
        intro += f"<p><strong>{c['contact']}:</strong> {html.escape(args.admin_name)} ({args.admin_email})</p>"
        for name, value in (("surveyls_language", lang), ("surveyls_title", t["title"]),
                            ("surveyls_description", f"<p>{t['subtitle']}</p>"),
                            ("surveyls_welcometext", intro), ("surveyls_endtext", f"<p>{c['end']}</p>"),
                            ("surveyls_numberformat", "1" if lang.startswith("pt") else "0"),
                            ("surveyls_email_invite_subj", c["email"]["invite_subj"]),
                            ("surveyls_email_invite", c["email"]["invite"]),
                            ("surveyls_email_remind_subj", c["email"]["remind_subj"]),
                            ("surveyls_email_remind", c["email"]["remind"])):
            sv.lang_setting(lang, name, value)


def profile_group(sv, texts, panel, prefix, group_code, group_key):
    common = {lang: texts[lang]["common"] for lang in S.LANGUAGES}
    sv.group(per_lang(texts, panel, "groups", "profile"),
             {lang: f"<p>{common[lang]['pseudonym'].format(disc=prefix + '6')}</p>" for lang in S.LANGUAGES})
    sv.question("*", S.RID, {lang: common[lang]["rid"] for lang in S.LANGUAGES},
                hidden="1", equation="{TOKEN:ATTRIBUTE_1}")
    sv.question("L", group_code, per_lang(texts, panel, group_key, "text"), mandatory="Y", other="Y",
                answers=options(texts, panel, group_key, "options"))
    sv.question("L", "INST", per_lang(texts, panel, "inst", "text"), mandatory="Y",
                answers=options(texts, panel, "inst", "options"))
    sv.question("L", "EXPER", {lang: common[lang]["exp"]["text"].format(n=prefix + "3") for lang in S.LANGUAGES},
                mandatory="Y", answers=options(texts, "common", "exp", "options"))
    sv.question("M", "GRIDS", per_lang(texts, panel, "grids", "text"), mandatory="Y",
                exclude_all_others="NONE",
                subquestions=[(code, labels) for code, labels in options(texts, panel, "grids", "options")])
    sv.question("L", "COI", {lang: common[lang]["coi"]["text"].format(n=prefix + "5") for lang in S.LANGUAGES},
                mandatory="Y", helps=per_lang(texts, panel, "coi_help"),
                answers=options(texts, "common", "coi", "options"))
    sv.question("T", "COIdesc", {lang: common[lang]["coi"]["desc"] for lang in S.LANGUAGES},
                mandatory="Y", relevance="COI.NAOK == 'Y'", display_rows="3")
    sv.question("L", "DISC", per_lang(texts, panel, "disc", "text"), mandatory="Y",
                helps={lang: f"{common[lang]['disc_note']} {texts[lang][panel]['disc']['rule']}"
                       for lang in S.LANGUAGES},
                answers=options(texts, panel, "disc", "options"))
    sv.question("M", "CONS", {lang: common[lang]["cons"]["text"].format(n=prefix + "7") for lang in S.LANGUAGES},
                mandatory="Y", subquestions=[("ok", {lang: common[lang]["cons"]["option"] for lang in S.LANGUAGES})])


def build_q1(texts, props, prop_i18n, args):
    sv = Survey()
    common_setup(sv, texts, "q1", args)
    profile_group(sv, texts, "q1", "1A", S.Q1_GROUP, "area")
    geo = {lang: texts[lang]["common"]["geometries"] for lang in S.LANGUAGES}

    # 1B shapes
    shapes = {lang: table(texts[lang]["q1"]["shapes"]["header"],
                          [[f"<strong>{geo[lang][g]}</strong>", texts[lang]["q1"]["shapes"]["rows"][g]]
                           for g in GEOMETRIES]) + f"<p>{texts[lang]['q1']['shapes']['note']}</p>"
              for lang in S.LANGUAGES}
    sv.group(per_lang(texts, "q1", "groups", "shapes"))
    sv.question("X", "SHAPES", shapes)

    # 1C judgment grades
    judgment = [p for p in props if p["type"] == "judgment"]
    defs = {lang: f"<p>{texts[lang]['q1']['grades']['intro']}</p>" + table(
        texts[lang]["q1"]["grades"]["defs_header"],
        [[p["code"], prop_i18n[(p["code"], lang)]["name"], prop_i18n[(p["code"], lang)]["geometry_definition"]]
         for p in judgment]) for lang in S.LANGUAGES}
    sv.group(per_lang(texts, "q1", "groups", "grades"))
    sv.question("X", "GRDdefs", defs)
    rows = [(p["code"], {lang: f'{p["code"]} {prop_i18n[(p["code"], lang)]["name"]}' for lang in S.LANGUAGES})
            for p in judgment]
    sv.question(":", S.GRADES, per_lang(texts, "q1", "grades", "matrix"),
                subquestions=rows, columns=[(g, {lang: geo[lang][g] for lang in S.LANGUAGES}) for g in GEOMETRIES],
                multiflexible_min="0", multiflexible_max="1", multiflexible_step="0.1", input_boxes="0",
                answer_width="40")
    sv.question("Q", S.GRADES_JUST, per_lang(texts, "q1", "grades", "just"), subquestions=rows)

    # 1D objective properties
    objective = [p for p in props if p["type"] == "objective"]
    obj = {lang: f"<p>{texts[lang]['q1']['objective']['intro']}</p>" + table(
        texts[lang]["q1"]["objective"]["header"],
        [[p["code"], prop_i18n[(p["code"], lang)]["name"]] + [num(p[g], lang) for g in GEOMETRIES]
         + [prop_i18n[(p["code"], lang)]["basis"]] for p in objective]) for lang in S.LANGUAGES}
    sv.group(per_lang(texts, "q1", "groups", "objective"))
    sv.question("X", "OBJtab", obj)
    sv.question("T", "OBJ", per_lang(texts, "q1", "objective", "question"), display_rows="6")

    # 1E definitions and new properties
    sv.group(per_lang(texts, "q1", "groups", "defs"))
    for code, key in (("DEFS", "e1"), ("NEWP", "e2"), ("COMM", "e3")):
        sv.question("T", code, per_lang(texts, "q1", "defs", key), display_rows="6")
    return sv


def build_q2(texts, props, prop_i18n, apps, app_i18n, args):
    sv = Survey()
    common_setup(sv, texts, "q2", args)
    profile_group(sv, texts, "q2", "2A", S.Q2_GROUP, "group")

    # 2B definitions
    defs = {}
    for lang in S.LANGUAGES:
        d = texts[lang]["q2"]["defs"]
        defs[lang] = (f"<h4>{d['scale_title']}</h4>"
                      + table(d["scale_header"], [[f"<strong>{c[1:]}</strong>", d["scale"][c]] for c in S.RELEVANCE])
                      + f"<h4>{d['props_title']}</h4>"
                      + table(d["props_header"], [[p["code"], prop_i18n[(p["code"], lang)]["name"],
                                                   prop_i18n[(p["code"], lang)]["use_definition"]] for p in props])
                      + f"<p>{d['next']}</p>")
    sv.group(per_lang(texts, "q2", "groups", "defs"))
    sv.question("X", "DEFStab", defs)

    # 2C one page per application
    prop_rows = [(p["code"], {lang: prop_i18n[(p["code"], lang)]["label"] for lang in S.LANGUAGES}) for p in props]
    for aid in apps:
        names = {lang: texts[lang]["q2"]["groups"]["app"].format(id=aid, name=app_i18n[(aid, lang)]["name"])
                 for lang in S.LANGUAGES}
        sv.group(names, {lang: f"<p>{app_i18n[(aid, lang)]['description']}</p>" for lang in S.LANGUAGES})
        fam = S.fam_code(aid)
        familiar = f"({fam}.NAOK == 'H' or {fam}.NAOK == 'M')"
        sv.question("L", fam, per_lang(texts, "q2", "app", "fam"), mandatory="Y",
                    answers=options(texts, "q2", "app", "fam_options"))
        sv.question("F", S.rel_code(aid), per_lang(texts, "q2", "app", "rel"), relevance=familiar,
                    subquestions=prop_rows, answers=options(texts, "q2", "app", "rel_options"), answer_width="30")
        sv.question("Q", S.com_code(aid), per_lang(texts, "q2", "app", "com"), relevance=familiar,
                    subquestions=prop_rows)

    # 2D exact nesting
    app_rows = [(aid, {lang: f"{aid} {app_i18n[(aid, lang)]['name']}" for lang in S.LANGUAGES},
                 f"({S.fam_code(aid)}.NAOK == 'H' or {S.fam_code(aid)}.NAOK == 'M')") for aid in apps]
    sv.group(per_lang(texts, "q2", "groups", "nest"),
             {lang: paragraphs(texts[lang]["q2"]["nest"]["intro"]) for lang in S.LANGUAGES})
    sv.question("F", S.NEST, per_lang(texts, "q2", "nest", "question"), subquestions=app_rows,
                answers=options(texts, "q2", "nest", "options"), answer_width="50")
    sv.question("Q", S.NEST_JUST, per_lang(texts, "q2", "nest", "just"), subquestions=app_rows)

    # 2E proposals
    sv.group(per_lang(texts, "q2", "groups", "proposals"),
             {lang: f"<p>{texts[lang]['q2']['proposals']['intro']}</p>" for lang in S.LANGUAGES})
    for code, key in (("NEWA", "e1"), ("NEED", "e2"), ("DEFA", "e3"), ("COMM", "e4")):
        sv.question("T", code, per_lang(texts, "q2", "proposals", key), display_rows="6")
    return sv


def codes_sql():
    """sql/20_codes.sql: the answer-code table used by the SQL views (schema delphi)."""
    kinds = {
        "area": S.AREA, "user_group": S.USER_GROUP,
        "institution_geometry": S.INSTITUTION_Q1, "institution_applications": S.INSTITUTION_Q2,
        "experience": S.EXPERIENCE, "yes_no": S.YES_NO, "disclosure": S.DISCLOSURE,
        "disclosure_order": {level: level for level in S.DISCLOSURE_ORDER},
        "familiarity": S.FAMILIARITY, "relevance": {k: str(v) for k, v in S.RELEVANCE.items()},
        "nesting": S.NESTING,
        "grids_geometry": {g: g for g in S.GRIDS_Q1}, "grids_applications": {g: g for g in S.GRIDS_Q2},
        "open_geometry": S.OPEN_Q1, "open_applications": S.OPEN_Q2,
        "setting": {"min_anonymous": str(MIN_ANONYMOUS)},
    }

    def q(v):
        return "'" + str(v).replace("'", "''") + "'"

    rows = [f"  ({q(kind)}, {q(code)}, {q(value)}, {i})"
            for kind, mapping in kinds.items() for i, (code, value) in enumerate(mapping.items())]
    return ("-- Generated by scripts/limesurvey_build.py from scripts/survey_schema.py. Do not edit.\n"
            "truncate delphi.code;\n"
            "insert into delphi.code (kind, code, value, ord) values\n" + ",\n".join(rows) + ";\n")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--round", required=True)
    ap.add_argument("--admin-name", required=True, help="coordination name shown to panellists")
    ap.add_argument("--admin-email", required=True, help="coordination e-mail shown to panellists")
    ap.add_argument("--expires", help="closing date, YYYY-MM-DD (optional)")
    args = ap.parse_args()

    texts = json.loads((ROOT / "delphi" / "limesurvey" / "texts.json").read_text(encoding="utf-8"))
    props = load_properties_table()
    apps = load_applications()
    prop_i18n = load_i18n("properties.csv", "code")
    app_i18n = load_i18n("applications.csv", "id")

    out = ROOT / "delphi" / "rounds" / args.round
    out.mkdir(parents=True, exist_ok=True)
    build_q1(texts, props, prop_i18n, args).write(out / "survey_q1_geometry.txt")
    build_q2(texts, props, prop_i18n, apps, app_i18n, args).write(out / "survey_q2_applications.txt")
    (ROOT / "sql" / "20_codes.sql").write_text(codes_sql(), encoding="utf-8")
    print(f"Wrote survey_q1_geometry.txt and survey_q2_applications.txt in {out}, and sql/20_codes.sql")


if __name__ == "__main__":
    main()
