# Delphi protocol

## Panel

At least three experts per user group, drawn from:

- official statistics
- cadastre and land registry
- remote sensing and environmental monitoring
- addressing, postal services and logistics
- health surveillance and emergency services
- academia (geodesy, cartography, spatial data infrastructure)

Panel composition is published by group only. Individual responses are stored
under pseudonymous identifiers (`R001`, `R002`, ...), in line with the
Brazilian General Data Protection Law (LGPD). The mapping between identifiers
and people is kept outside this repository.

## What is voted and what is not

| Item | Decided by |
|---|---|
| Relevance of each property to each application (0–3) | Panel vote |
| Which applications require exact nesting (stage 1 filter) | Panel vote, from round 01 |
| New applications and new properties | Panel proposal, then vote in the next round |
| Grades of **objective** properties (`data/properties.csv`) | Evidence only, via issue; never by vote |
| Grades of **judgment** properties | Panel vote, from round 01 |

Proposals of properties or applications that favour hexagonal or triangular
cells are explicitly encouraged: the assessment is only credible if it gives
competing geometries every chance to score.

## Rounds

1. **Round 01.** Each panellist rates the relevance of every property for every
   application on a 0–3 scale, may challenge the stage 1 filter, and may propose
   new applications or properties.
2. **Round 02.** Each panellist receives, per item, the group median and
   interquartile range, together with anonymised justifications, and may revise
   their answers.
3. **Round 03.** Only items still without consensus are re-submitted.
4. **Weighting round.** Applications are weighted by the institutional relevance
   of their users (e.g. budget, data volume, population served).

## Consensus criterion

An item reaches consensus when its interquartile range is at most 1 on the 0–3
scale. Items without consensus after round 03 are reported as dissent, with the
distribution of answers, and kept at their median.

## Workflow in this repository

1. Create `delphi/rounds/round-NN/` and collect answers in `responses.csv`,
   using the format of `delphi/questionnaire_template.csv`.
2. Run `python scripts/delphi_aggregate.py --round round-NN` to produce
   `weights.csv` (medians) and `consensus.csv`.
3. Run `python scripts/compute.py --round round-NN` and
   `python scripts/sensitivity.py --round round-NN`.
4. Commit, then tag the closed round (`git tag round-NN`). Data of closed
   rounds are never edited; corrections go into a new round.
