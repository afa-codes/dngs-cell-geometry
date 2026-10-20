-- DGGS-4N Delphi consultation: core objects, installed in the LimeSurvey database.
--
-- LimeSurvey's own tables are never modified: everything here only reads them.
-- Schema delphi is private (never exposed by PostgREST); schema api holds the
-- views and functions PostgREST exposes (30_api.sql).
--
-- LimeSurvey stores responses with version-specific physical names
-- (LimeSurvey 7: lime_responses_<sid>, columns Q40, Q43_S97, Q12_S29_S31;
--  LimeSurvey 6: lime_survey_<sid>, columns <sid>X6X40, <sid>X6X43STAT, ...).
-- delphi.answer_keys() maps both conventions to question codes, the same keys as
-- LimeSurvey's CSV export ("GRIDS[HEX]", "GRD[P2_square]"), and delphi.sync()
-- stores each response as JSONB under those keys. Nothing else depends on the
-- LimeSurvey version. The table prefix is assumed to be the default "lime_".
--
-- Install:  psql -d <limesurvey db> -f sql/10_core.sql -f sql/20_codes.sql -f sql/30_api.sql

create schema if not exists delphi;
create schema if not exists api;

do $$ begin
  if not exists (select from pg_roles where rolname = 'delphi_anon') then
    create role delphi_anon nologin;   -- anonymous web requests through PostgREST
  end if;
  if not exists (select from pg_roles where rolname = 'delphi_coord') then
    create role delphi_coord nologin;  -- coordination, through a signed JWT
  end if;
end $$;

-- Rounds and their LimeSurvey surveys. Round data become public when closed_at
-- is set; the panel list when panel_published_at is set.
create table if not exists delphi.round (
  round              text primary key check (round ~ '^round-[a-z0-9-]+$'),
  seq                int  not null unique,
  sid_geometry       int,
  sid_applications   int,
  closed_at          timestamptz,
  panel_published_at timestamptz
);

-- Snapshot of submitted responses, answers keyed by question code.
create table if not exists delphi.response (
  round         text references delphi.round on update cascade on delete cascade,
  panel         text check (panel in ('geometry', 'applications')),
  response_id   int,
  respondent_id text not null,
  answers       jsonb not null,
  primary key (round, panel, response_id)
);

-- Names and institutions, used only for the panel list (named and public levels).
create table if not exists delphi.participant (
  round         text references delphi.round on update cascade on delete cascade,
  panel         text,
  respondent_id text,
  firstname     text,
  lastname      text,
  institution   text,
  primary key (round, panel, respondent_id)
);

-- Answer codes -> repository slugs (generated from scripts/survey_schema.py into 20_codes.sql).
create table if not exists delphi.code (
  kind  text,
  code  text,
  value text,
  ord   int,
  primary key (kind, code)
);

-- Physical column name -> question code, for both LimeSurvey naming conventions.
create or replace function delphi.answer_keys(p_sid int)
returns table (col text, code text) language sql stable as $$
  with q as (select * from lime_questions where sid = p_sid and parent_qid = 0),
       sq as (select s.qid, s.parent_qid, s.title, s.scale_id, q.title as ptitle, q.type as ptype, q.gid as pgid
                from lime_questions s join q on q.qid = s.parent_qid)
  select 'Q' || q.qid, q.title from q
  union all select p_sid || 'X' || q.gid || 'X' || q.qid, q.title from q
  union all select 'Q' || q.qid || '_Cother', q.title || '[other]' from q
  union all select p_sid || 'X' || q.gid || 'X' || q.qid || 'other', q.title || '[other]' from q
  union all select 'Q' || sq.parent_qid || '_S' || sq.qid, sq.ptitle || '[' || sq.title || ']'
              from sq where sq.ptype <> ':'
  union all select p_sid || 'X' || sq.pgid || 'X' || sq.parent_qid || sq.title, sq.ptitle || '[' || sq.title || ']'
              from sq where sq.ptype <> ':'
  union all select 'Q' || r.parent_qid || '_S' || r.qid || '_S' || c.qid, r.ptitle || '[' || r.title || '_' || c.title || ']'
              from sq r join sq c on c.parent_qid = r.parent_qid and r.scale_id = 0 and c.scale_id = 1
             where r.ptype = ':'
  union all select p_sid || 'X' || r.pgid || 'X' || r.parent_qid || r.title || '_' || c.title,
                   r.ptitle || '[' || r.title || '_' || c.title || ']'
              from sq r join sq c on c.parent_qid = r.parent_qid and r.scale_id = 0 and c.scale_id = 1
             where r.ptype = ':'
$$;

-- Response or participant table of a survey, resolved through search_path.
create or replace function delphi.table_of(p_kind text, p_sid int)
returns regclass language sql stable as $$
  select case p_kind
           when 'responses' then coalesce(to_regclass('lime_responses_' || p_sid), to_regclass('lime_survey_' || p_sid))
           else to_regclass('lime_tokens_' || p_sid)
         end
$$;

-- Copy the submitted responses and participant names of a round into the snapshot.
-- Run by the coordination (psql) when the round closes, or at any time to refresh.
create or replace function delphi.sync(p_round text)
returns table (panel text, responses bigint, participants bigint) language plpgsql as $$
declare
  r delphi.round;
  p record;
  t regclass;
begin
  select * into r from delphi.round where round = p_round;
  if not found then
    raise exception 'round % is not registered in delphi.round', p_round;
  end if;
  for p in select * from (values ('geometry', r.sid_geometry), ('applications', r.sid_applications)) v(panel, sid)
           where v.sid is not null loop
    t := delphi.table_of('responses', p.sid);
    if t is null then
      raise exception 'no response table for survey % (is it active?)', p.sid;
    end if;
    delete from delphi.response x where x.round = p_round and x.panel = p.panel;
    execute format($f$
      insert into delphi.response (round, panel, response_id, respondent_id, answers)
      select $1, $2, (j->>'id')::int, coalesce(a->>'RID', ''), a
        from (select to_jsonb(x) j from %s x where x.submitdate is not null) s,
             lateral (select coalesce(jsonb_object_agg(k.code, e.value), '{}'::jsonb) a
                        from jsonb_each(s.j) e join delphi.answer_keys($3) k on k.col = e.key
                       where e.value <> 'null'::jsonb) z$f$, t)
      using p_round, p.panel, p.sid;
    delete from delphi.participant x where x.round = p_round and x.panel = p.panel;
    t := delphi.table_of('tokens', p.sid);
    if t is not null then
      execute format($f$
        insert into delphi.participant (round, panel, respondent_id, firstname, lastname, institution)
        select distinct on (attribute_1) $1, $2, attribute_1, firstname, lastname, %s
          from %s where coalesce(attribute_1, '') <> '' order by attribute_1, tid$f$,
        case when exists (select from pg_attribute where attrelid = t and attname = 'attribute_2' and not attisdropped)
             then 'attribute_2' else 'null::text' end, t)
        using p_round, p.panel;
    end if;
    return query select p.panel::text,
      (select count(*) from delphi.response x where x.round = p_round and x.panel = p.panel),
      (select count(*) from delphi.participant x where x.round = p_round and x.panel = p.panel);
  end loop;
end $$;

-- Retention: remove the identifying data of a round from the snapshot once the
-- results are published (names, conflict-of-interest descriptions, "Other" texts).
-- LimeSurvey's own participant and response tables are deleted in LimeSurvey.
create or replace function delphi.purge(p_round text)
returns void language sql as $$
  delete from delphi.participant where round = p_round;
  update delphi.response set answers = answers - 'COIdesc' - 'AREA[other]' - 'UGRP[other]'
   where round = p_round;
$$;

revoke all on schema delphi from public;
revoke all on all functions in schema delphi from public;
