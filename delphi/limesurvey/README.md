# Running a Delphi round in LimeSurvey

Coordinator guide. The surveys are generated from this repository, so the
wording stays identical to the questionnaires in the wiki and the codes stay
compatible with the import scripts. Tested with LimeSurvey 6.17 (LTS) and 7.6.

## Files

    texts.json                   all survey wording, pt-BR and en (edit here)
    participants_template.csv    columns for importing participants
    ../rounds/round-NN/survey_q1_geometry.txt      generated, questionnaire 1
    ../rounds/round-NN/survey_q2_applications.txt  generated, questionnaire 2

Application and property names come from `data/i18n/`. Survey codes and their
meaning are in `scripts/survey_schema.py`, from which the build also generates
`sql/20_codes.sql`. Never edit the generated `.txt`
files by hand: change the sources and rebuild.

## 1. Build the surveys

    python scripts/limesurvey_build.py --round round-01 \
        --admin-name "Coordenação DGGS-4N" --admin-email delphi@your-domain \
        --expires 2026-12-15

The name, e-mail and deadline appear on the welcome page and in the
invitations. The committed files were built with a placeholder e-mail and no
deadline, so rebuild them with the real values before importing.

Each survey is bilingual (base language pt-BR, additional language en); the
panellist chooses the language, and the invitation follows the language set
for each participant.

## 2. Import

In LimeSurvey: **Create survey → Import**, select the `.txt` file and import.
Do it once per questionnaire. LimeSurvey keeps the survey IDs 100101 and
100102 (round 01) if they are free, otherwise it assigns new ones.

Check, before activating:

- **Settings → Presentation:** the welcome text shows the contact and deadline.
- **Survey logic file** (Tools menu): it reports one error, in the hidden
  question `RID`, until the participant table exists. After step 3 it must
  report no errors.
- Preview both languages.

Settings already applied by the import: responses not anonymised (needed to
link rounds), no IP address, no referrer URL, no date stamps, answers editable
after completion until the survey expires, saving and resuming through the
personal link, one page per group, progress bar.

## 3. Participants

Create the participant table (**Survey participants → Initialise**). It
creates two attributes taken from the survey: `attribute_1` (respondent_id)
and `attribute_2` (institution). If LimeSurvey offers to switch the survey to
closed-access mode, accept: only invited participants may answer.

Import participants from a CSV with the columns of
`participants_template.csv`:

| Column | Content |
|---|---|
| firstname, lastname, email | the expert's details |
| language | `pt-BR` or `en`, the language of the invitation and survey |
| attribute_1 | pseudonymous code, `R001`, `R002`, … |
| attribute_2 | institution, published only for named and public panellists |

An expert who answers both questionnaires must have **the same code** in both
participant tables. After the import, delete the CSV: from then on these data
exist only in the LimeSurvey database.

## 4. Register the round in the database

Install the database layer once (`sql/README.md`) and register the round with
its two survey IDs:

    insert into delphi.round (round, seq, sid_geometry, sid_applications)
    values ('round-01', 1, 100101, 100102);

## 5. Run the round

Activate each survey, send the invitations (the texts mention the respondent
code and the personal link), and send reminders as needed. While the round is
open, the API shows its data only to the coordination; `GET /issues` (with the
coordination's JWT, after `select delphi.sync('round-01')`) lists duplicate or
invalid codes, missing consents and names, and groups hidden by the k rule.

## 6. Close and fetch

When the deadline passes, in the database:

    select * from delphi.sync('round-01');
    update delphi.round set closed_at = now() where round = 'round-01';

Then, from the repository root:

    python scripts/postgrest_fetch.py --round round-01 --url https://delphi.example.org/api

The script writes the pseudonymous round files to `delphi/rounds/round-01/`.
No export leaves LimeSurvey: names, tokens, conflict-of-interest descriptions
and disclosure choices stay in the database. Before committing, read
`open_answers.csv` and the `comment` and `justification` columns, and remove
anything that identifies the author.

## 7. Aggregate and compute

    python scripts/delphi_aggregate.py --round round-01
    python scripts/delphi_aggregate.py --round round-01 --subset public
    python scripts/compute.py --round round-01
    python scripts/compute.py --round round-01 --subset public
    python scripts/sensitivity.py --round round-01 --runs 10000 --k 1

Commit and tag the round (`git tag round-01`).

## 8. Publish the panel list

At the end of the consultation:

    update delphi.round set panel_published_at = now() where round = 'round-01';

and fetch it with `postgrest_fetch.py --panel`, which writes
`results/round-01/panel.csv` and `panel.md`.

## Retention

The confidential data stay in the PostgreSQL database of the LimeSurvey
instance for as long as necessary to run the consultation and publish its
results. When that period ends, run `select delphi.purge('round-01')`, delete
the participant tables and the responses of each survey in LimeSurvey (or the
whole survey), and any database backups that contain them. The published
round files do not depend on them.

## Changing the questionnaires

- Wording: edit `texts.json` (both languages) and rebuild.
- Applications or properties: edit `data/applications.csv`,
  `data/properties.csv` and `data/i18n/`, then rebuild; the database views
  and the aggregation follow automatically.
- Answer codes: change them in `scripts/survey_schema.py` and `texts.json`
  together, rebuild (which also regenerates `sql/20_codes.sql`) and rerun
  `sql/20_codes.sql` in the database. LimeSurvey answer codes are at most 5
  letters or digits.
- After any change, run `python -m unittest discover tests`.
