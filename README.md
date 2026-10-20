# Cell geometry for discrete national grid systems (DNGS)

Assessments and Delphi consultations comparing square (quadtree), triangular
and hexagonal cells against the applications of a discrete national grid
system (DNGS) or "[DGGS for Nations](https://git.addressforall.org/DGGS-4N) (DGGS-4N)".

## Context

A DNGS is a discrete grid defined over a national extent, as opposed to
discrete global grid systems (DGGS; ISO 19170-1 and OGC API – DGGS). The
proposal under assessment imposes square cells with a quadtree hierarchy on an
equal-area projection; in Brazil, SIRGAS 2000 / Brazil Albers (EPSG:10857).

This repository records the grounds for that choice and lets third parties
challenge, in a traceable way, the grades and weights that support it.
Cartographic measurements of the projections themselves are kept in a
separate repository.

## Method

The assessment has two stages.

1. **Elimination filter.** Applications whose results have legal or accounting
   effect, or that depend on a unique key, require exact nesting between
   hierarchy levels (P1a). A geometry that fails it is inadmissible for those
   applications.
2. **Multi-criteria weighting.** For admissible geometries, the score of an
   application is the mean of the property grades weighted by the relevance of
   each property to that application: Σ(w·g) / Σw.

### Properties

| Code | Property | Type | Square | Triangle | Hexagon |
|---|---|---|---|---|---|
| P1a | Exact nesting between levels | objective | 1 | 1 | 0 |
| P1b | Usable approximate hierarchy | judgment | 1 | 1 | 0.7 |
| P2 | Raster alignment | judgment | 1 | 0.2 | 0.2 |
| P3 | Prefix geocode / space-filling curve | judgment | 1 | 0.7 | 0.5 |
| P4 | Uniform neighbourhood | judgment | 0.5 | 0.3 | 1 |
| P5 | Congruent cell orientation | objective | 1 | 0.5 | 1 |
| P6 | Compactness (normalised IPQ) | objective | 0.87 | 0.67 | 1 |
| P7 | Interval subpaving | objective | 1 | 0.4 | 0.2 |
| P8 | Cartographic legacy compatibility | judgment | 1 | 0.2 | 0.3 |

Objective grades are not put to a vote; they can only be revised on evidence
recorded in an issue. Rationales are in `data/properties.csv`.

## Results of round 00 (baseline)

Weights assigned by the author, without panel consultation. They are a
hypothesis to be tested by the Delphi method.

| Group | Square | Triangle | Hexagon |
|---|---|---|---|
| YES, requires exact nesting (7 applications) | 100% | 73% | eliminated (26% without filter) |
| NO, no such requirement (7 applications) | 87% | 50% | 62% |
| Total (14 applications) | 93% | 62% | 31% (44% without filter) |

Each percentage is the mean degree to which a geometry satisfies the
properties relevant to the group. Eliminated geometries count as zero in the
filtered totals. Per-application scores are in
`results/round-00/scores_by_application.csv`.

Hexagons score highest in three applications (epidemiological surveillance,
logistics and mobility, emergency services), where neighbourhood uniformity
dominates.

**Sensitivity.** Perturbing every nonzero weight by a random integer in ±1 or
±2 (10,000 runs each) leaves the ranking square > triangle > hexagon unchanged
in all runs. This perturbation does not alter the filter, the grades, or which
properties are relevant to which application; those are tested by the Delphi
rounds.

## Delphi protocol

Summary (full text in `delphi/protocol.md`):

- **Two panels.** A *geometry panel* (mathematics, computational geometry,
  geodesy, interval analysis, computer science) grades how far each cell shape
  satisfies each judgment property (questionnaire 1). An *applications panel*
  (official statistics, cadastre and registry, remote sensing, addressing and
  logistics, health and emergency, academia) rates how much each property
  matters to each application and whether it requires exact nesting
  (questionnaire 2). Some experts answer both; at least three per group.
- **Round 01:** grades (0–1) and relevance (0–3), challenges to the filter and
  to the objective grades, and free proposals of new applications and
  properties, including those favourable to hexagons.
- **Round 02:** panellists see the group median and interquartile range and
  may revise their answers.
- **Round 03:** only items still without consensus.
- **Consensus:** interquartile range ≤ 1 on the 0–3 scale (≤ 1/3 on the 0–1
  grade scale); for the filter, a majority of at least 75%.
- **Weighting round:** applications weighted by the institutional relevance of
  their users.
- **Disclosure:** answers are pseudonymous (`R001`, `R002`, …) while a round is
  open. After closure each panellist's chosen level applies: anonymous, named
  (name listed, answers not attributed) or public (name and answers). Results
  are computed for the whole panel and, separately, for public panellists only.
  A conflict-of-interest declaration is mandatory. Confidential data stay only
  in the LimeSurvey PostgreSQL database, for as long as necessary, in line
  with the LGPD; the repository holds pseudonymous data only.
- **Survey platform:** LimeSurvey (self-hostable, open source); the surveys
  are generated from this repository and the data are read from its
  PostgreSQL database through SQL views exposed by PostgREST. Coordinator
  guide: `delphi/limesurvey/README.md`; database and API: `sql/README.md`.

## Repository layout

    data/
      properties.csv              grades per geometry, type and rationale
      applications.csv            applications and elimination filter
      i18n/                       names and descriptions in pt-BR and en
    delphi/
      protocol.md
      questionnaire_template.csv  format of responses.csv
      limesurvey/                 survey texts, participant template, guide
      rounds/round-00/            author's baseline weights
      rounds/round-01/            LimeSurvey surveys; panel data after closure
    sql/
      10_core.sql                 schemas, roles, JSONB snapshot of LimeSurvey data
      20_codes.sql                answer codes (generated)
      30_api.sql                  views and functions exposed by PostgREST
      postgrest.conf.example
    scripts/
      common.py                   loaders and scoring
      survey_schema.py            survey codes shared by the build and the SQL
      limesurvey_build.py         generates the two surveys and sql/20_codes.sql
      postgrest_fetch.py          round files and panel list from the API
      postgrest_jwt.py            signs the coordination's JWT
      delphi_aggregate.py         medians, IQR, consensus, filter and grades
      compute.py                  per-application scores and summary
      sensitivity.py              Monte Carlo sensitivity of the ranking
    tests/                        pipeline and database tests on synthetic data
    results/                      generated outputs (do not edit by hand)

Scripts use only the Python standard library (Python 3.8+).

## Reproducing

    cd scripts
    python compute.py --round round-00
    python sensitivity.py --round round-00 --runs 10000 --k 1

For a Delphi round, after its data are committed (no database needed):

    python delphi_aggregate.py --round round-01
    python delphi_aggregate.py --round round-01 --subset public
    python compute.py --round round-01
    python compute.py --round round-01 --subset public
    python sensitivity.py --round round-01 --runs 10000 --k 1

Tests: `python -m unittest discover tests` from the repository root; the
database tests also need `DELPHI_TEST_DSN` (see `tests/test_pipeline.py`).

## Versioning

Each closed round is tagged in git (`round-00`, `round-01`, ...). Data of
closed rounds are never edited; corrections enter as a new round.

## References

- Jaulin, L.; Kieffer, M.; Didrit, O.; Walter, É. (2001). *Applied Interval
  Analysis*. Springer.
- Linstone, H. A.; Turoff, M. (eds.) (1975). *The Delphi Method: Techniques
  and Applications*. Addison-Wesley.
- Sahr, K.; White, D.; Kimerling, A. J. (2003). Geodesic discrete global grid
  systems. *Cartography and Geographic Information Science*, 30(2), 121–134.
- ISO 19170-1:2021. Discrete Global Grid Systems — Part 1.
- OGC API – DGGS, Part 1: Core.
- IBGE. Grade Estatística.
- GLanCE Grids: https://measures-glance.github.io/glance-grids/

## License

To be defined.
