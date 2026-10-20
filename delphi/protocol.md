# Delphi protocol

## Panels

The consultation has two panels, each with its own questionnaire. Some experts
answer both, under the same respondent code.

**Geometry panel** (questionnaire 1): experts in mathematics, computational
geometry and spatial data structures, geodesy and mathematical cartography,
interval analysis and numerical methods, and computer science. They assess
the degree to which each cell shape satisfies each property. This panel is
expected to be smaller.

**Applications panel** (questionnaire 2): at least three experts per user
group, drawn from:

- official statistics
- cadastre and land registry
- remote sensing and environmental monitoring
- addressing, postal services and logistics
- health surveillance and emergency services
- academia (GIS, cartography, spatial data infrastructure)

They assess how much each property matters to each application, without
needing to know which shape satisfies it.

The questionnaire texts are published in the wiki (`Q1R1pt`, `Q2R1pt`,
`Q1R1en`, `Q2R1en`) and kept in `delphi/limesurvey/texts.json`, from which
the LimeSurvey surveys are generated.

## What is voted and what is not

| Item | Decided by |
|---|---|
| Grades of **judgment** properties (P1b, P2, P3, P4, P8), 0–1 per shape | Geometry panel |
| Grades of **objective** properties (P1a, P5, P6, P7) | Evidence only, via issue or questionnaire 1 (item 1D1); never by vote |
| Definitions of properties and new properties | Geometry panel proposes; vote in the next round |
| Relevance of each property to each application, 0–3 | Applications panel |
| Which applications require exact nesting (stage 1 filter) | Applications panel |
| New applications and unmet needs | Applications panel proposes; vote in the next round |

Proposals of properties or applications that favour hexagonal or triangular
cells are explicitly encouraged: the assessment is only credible if it gives
competing geometries every chance to score.

## Rounds

1. **Round 01.** Geometry panel: grades of the judgment properties, objections
   to the objective grades, definitions and new properties. Applications panel:
   familiarity with each application, relevance of every property for the
   applications the panellist knows (high or medium familiarity), the stage 1
   filter, and proposals.
2. **Round 02.** Each panellist receives, per item, the group median and
   interquartile range, together with anonymised justifications, and may revise
   their answers.
3. **Round 03.** Only items still without consensus are re-submitted.
4. **Weighting round.** Applications are weighted by the institutional relevance
   of their users (e.g. budget, data volume, population served).

## Decision rules

| Item | Panel value | Consensus |
|---|---|---|
| Relevance (0–3) | median | interquartile range ≤ 1 |
| Grade of a judgment property (0–1) | median | interquartile range ≤ 1/3, the same share of the scale |
| Stage 1 filter | majority of *yes* and *no* votes; *don't know* abstains | majority of at least 75% |

An item with fewer than three answers keeps its baseline value (round 00
weights, `data/properties.csv`, `data/applications.csv`), and a tied filter
vote keeps the baseline decision; both cases are flagged in the output files.
Items without consensus after round 03 are reported as dissent, with the
distribution of answers, and kept at their median.

## Disclosure and data protection

While a round is open, answers are identified only by a pseudonymous code
(`R001`, `R002`, …) assigned by the coordination and stored as a participant
attribute in LimeSurvey. No name is disclosed, not even to other panellists.

Confidential data — names, e-mails, institutions, the mapping between codes
and people, access tokens, conflict-of-interest descriptions and disclosure
choices — are kept only in the PostgreSQL database of the LimeSurvey instance,
for as long as necessary to run the consultation and publish its results, in
line with the Brazilian General Data Protection Law (LGPD). The panellists are
told so in the questionnaires. No export of these data is made: the database
layer (`sql/`) reads LimeSurvey's tables in place and exposes, through
PostgREST, only pseudonymous views, plus names and institutions of named and
public panellists once the panel list is published. When the period ends,
`delphi.purge()` removes them from the database layer and the coordination
deletes them in LimeSurvey.

Each panellist chooses, in the questionnaire, a disclosure level that applies
after the consultation closes and may be changed until then:

| Level | Published |
|---|---|
| Anonymous | Only the panellist's group |
| Named | Name and institution in the panel list; answers not attributed |
| Public | Name, institution, respondent code, answers and justifications |

A person who answers both questionnaires with different levels is treated at
the more restrictive one. Results are computed for the whole panel and,
separately, for public panellists only (`--subset public`), where only their
answers count.

A conflict-of-interest declaration is mandatory: any current link, or one in
the last three years, with a company or institution supplying solutions based
on geocode systems and/or grid systems. It is published individually for named
and public panellists and as counts per group for anonymous ones.

The round files publish answers per pseudonymous code. To keep codes from
being linked to named panellists through profile data:

- per respondent, only the code, panel, group and whether the person is public
  are published; institution type, experience, conflict of interest and the
  anonymous/named choice are published only as counts;
- a group is shown per respondent only if it has no non-public member or at
  least three of them; otherwise its non-public members appear as
  `undisclosed` (k = 3);
- for named panellists, the panel list shows neither code nor panels.

Free-text answers are published as written, under the respondent code. The
coordination reads them before committing and removes anything that
identifies the author.

## Workflow in this repository

1. Generate the surveys:
   `python scripts/limesurvey_build.py --round round-NN --admin-name … --admin-email … --expires YYYY-MM-DD`,
   import them into LimeSurvey and register the round in `delphi.round`
   (`delphi/limesurvey/README.md`, `sql/README.md`).
2. Run the round in LimeSurvey with closed access (one personal link per
   panellist; attribute 1 = respondent code, attribute 2 = institution).
3. At closure, run `select delphi.sync('round-NN')`, set
   `delphi.round.closed_at`, and fetch the pseudonymous files with
   `python scripts/postgrest_fetch.py --round round-NN --url …`. Round data
   are committed only after the round closes, when disclosure choices are
   final.
4. Run `python scripts/delphi_aggregate.py --round round-NN`, then with
   `--subset public`; then `compute.py` and `sensitivity.py` for both subsets.
5. At the end of the consultation, set `delphi.round.panel_published_at` and
   fetch the panel list with `postgrest_fetch.py --panel`.
6. Commit, then tag the closed round (`git tag round-NN`). Data of closed
   rounds are never edited; corrections go into a new round.
