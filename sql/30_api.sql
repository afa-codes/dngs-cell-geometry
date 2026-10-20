-- DGGS-4N Delphi consultation: views and functions exposed by PostgREST (schema api).
--
-- The round views reproduce the pseudonymous CSV files of delphi/rounds/<round>/
-- (same columns, plus "round"). Anonymous requests (role delphi_anon) see a
-- round only after delphi.round.closed_at is set, and the panel list only after
-- panel_published_at is set; the coordination (role delphi_coord, via JWT) sees
-- everything. Identifying data never leave schema delphi, except names and
-- institutions of panellists who chose the named or public level, in api.panel.

-- ---------------------------------------------------------------- internal views

create or replace view delphi.profile as
with base as (
  select r.round, r.panel, r.respondent_id, r.response_id, r.answers a,
         case r.panel when 'geometry' then 'AREA' else 'UGRP' end as gq,
         case r.panel when 'geometry' then 'area' else 'user_group' end as gkind,
         case r.panel when 'geometry' then 'institution_geometry' else 'institution_applications' end as ikind,
         case r.panel when 'geometry' then 'grids_geometry' else 'grids_applications' end as gridkind
    from delphi.response r
)
select b.round, b.panel, b.respondent_id, b.response_id,
       coalesce(g.value, case when b.a->>b.gq = '-oth-' then 'other' else '' end) as grp,
       coalesce(b.a->>(b.gq || '[other]'), '') as group_other_text,
       coalesce(i.value, '') as institution_type,
       coalesce(x.value, '') as experience,
       (select coalesce(string_agg(c.code, ' ' order by c.ord), '') from delphi.code c
         where c.kind = b.gridkind and b.a->>('GRIDS[' || c.code || ']') = 'Y') as grids,
       coalesce(y.value, '') as coi,
       coalesce(b.a->>'COIdesc', '') as coi_description,
       coalesce(d.value, 'anonymous') as disclosure_answered,
       b.a->>'CONS[ok]' = 'Y' as consent
  from base b
  left join delphi.code g on g.kind = b.gkind and g.code = b.a->>b.gq
  left join delphi.code i on i.kind = b.ikind and i.code = b.a->>'INST'
  left join delphi.code x on x.kind = 'experience' and x.code = b.a->>'EXPER'
  left join delphi.code y on y.kind = 'yes_no' and y.code = b.a->>'COI'
  left join delphi.code d on d.kind = 'disclosure' and d.code = b.a->>'DISC';

-- Effective disclosure (the most restrictive of the person's choices in the round)
-- and the group shown per respondent under the k rule.
create or replace view delphi.respondent as
with eff as (
  select p.*,
         first_value(p.disclosure_answered) over (partition by p.round, p.respondent_id order by d.ord) as disclosure
    from delphi.profile p
    join delphi.code d on d.kind = 'disclosure_order' and d.code = p.disclosure_answered
   where p.consent
)
select e.*,
       case when e.disclosure = 'public'
              or count(*) filter (where e.disclosure <> 'public') over (partition by e.round, e.panel, e.grp)
                 >= (select value::int from delphi.code where kind = 'setting' and code = 'min_anonymous')
            then e.grp else 'undisclosed' end as shown_group
  from eff e;

-- Rounds whose data the current role may see.
create or replace view delphi.visible_round as
select round, seq,
       closed_at is not null or pg_has_role('delphi_coord', 'MEMBER') as data,
       panel_published_at is not null or pg_has_role('delphi_coord', 'MEMBER') as panel
  from delphi.round;

-- ---------------------------------------------------------------- round files

create or replace view api.rounds as
select round, seq, closed_at is not null as closed, panel_published_at is not null as panel_published
  from delphi.round;

create or replace view api.respondents as
select s.round, s.respondent_id, s.panel, s.shown_group as "group",
       case when s.disclosure = 'public' then 'yes' else 'no' end as public
  from delphi.respondent s join delphi.visible_round v on v.round = s.round and v.data;

create or replace view api.responses as
with items as (
  select r.round, r.respondent_id, r.answers, k.app, k.prop
    from delphi.response r
    cross join lateral (select distinct m.arr[1] as app, m.arr[3] as prop from jsonb_object_keys(r.answers) t(key),
                               regexp_match(t.key, '^(A[0-9]{2})(rel|com)\[(.+)\]$') m(arr)
                         where m.arr is not null) k
   where r.panel = 'applications'
)
select i.round, i.respondent_id, s.shown_group as "group", i.app as application_id, i.prop as property,
       coalesce(c.value, '') as relevance,
       btrim(coalesce(i.answers->>(i.app || 'com[' || i.prop || ']'), ''), E' \t\r\n') as comment
  from items i
  join delphi.respondent s on s.round = i.round and s.panel = 'applications' and s.respondent_id = i.respondent_id
  join delphi.visible_round v on v.round = i.round and v.data
  left join delphi.code c on c.kind = 'relevance' and c.code = i.answers->>(i.app || 'rel[' || i.prop || ']')
 where c.value is not null
    or btrim(coalesce(i.answers->>(i.app || 'com[' || i.prop || ']'), ''), E' \t\r\n') <> '';

create or replace view api.familiarity as
select r.round, r.respondent_id, s.shown_group as "group", m.arr[1] as application_id,
       coalesce(c.value, '') as familiarity
  from delphi.response r
  cross join lateral jsonb_object_keys(r.answers) t(key)
  cross join lateral regexp_match(t.key, '^(A[0-9]{2})fam$') m(arr)
  join delphi.respondent s on s.round = r.round and s.panel = r.panel and s.respondent_id = r.respondent_id
  join delphi.visible_round v on v.round = r.round and v.data
  left join delphi.code c on c.kind = 'familiarity' and c.code = r.answers->>t.key
 where r.panel = 'applications' and m.arr is not null;

create or replace view api.filter_votes as
with items as (
  select r.round, r.respondent_id, r.answers, k.app
    from delphi.response r
    cross join lateral (select distinct m.arr[2] as app from jsonb_object_keys(r.answers) t(key),
                               regexp_match(t.key, '^NEST(j?)\[(A[0-9]{2})\]$') m(arr)
                         where m.arr is not null) k
   where r.panel = 'applications'
)
select i.round, i.respondent_id, s.shown_group as "group", i.app as application_id,
       coalesce(c.value, '') as requires_exact_nesting,
       btrim(coalesce(i.answers->>('NESTj[' || i.app || ']'), ''), E' \t\r\n') as justification
  from items i
  join delphi.respondent s on s.round = i.round and s.panel = 'applications' and s.respondent_id = i.respondent_id
  join delphi.visible_round v on v.round = i.round and v.data
  left join delphi.code c on c.kind = 'nesting' and c.code = i.answers->>('NEST[' || i.app || ']')
 where c.value is not null or btrim(coalesce(i.answers->>('NESTj[' || i.app || ']'), ''), E' \t\r\n') <> '';

create or replace view api.grades as
with items as (
  select r.round, r.respondent_id, r.answers, k.prop
    from delphi.response r
    cross join lateral (select distinct coalesce(m.arr[1], n.arr[1]) as prop
                          from jsonb_object_keys(r.answers) t(key)
                          left join lateral regexp_match(t.key, '^GRD\[(.+)_(square|triangle|hexagon)\]$') m(arr) on true
                          left join lateral regexp_match(t.key, '^GRDj\[(.+)\]$') n(arr) on true
                         where m.arr is not null or n.arr is not null) k
   where r.panel = 'geometry'
), graded as (
  select i.*,
         (select trim_scale(replace(nullif(btrim(i.answers->>('GRD[' || i.prop || '_square]')), ''), ',', '.')::numeric)::text) as square,
         (select trim_scale(replace(nullif(btrim(i.answers->>('GRD[' || i.prop || '_triangle]')), ''), ',', '.')::numeric)::text) as triangle,
         (select trim_scale(replace(nullif(btrim(i.answers->>('GRD[' || i.prop || '_hexagon]')), ''), ',', '.')::numeric)::text) as hexagon,
         btrim(coalesce(i.answers->>('GRDj[' || i.prop || ']'), ''), E' \t\r\n') as justification
    from items i
)
select g.round, g.respondent_id, s.shown_group as "group", g.prop as property,
       coalesce(g.square, '') as square, coalesce(g.triangle, '') as triangle, coalesce(g.hexagon, '') as hexagon,
       g.justification
  from graded g
  join delphi.respondent s on s.round = g.round and s.panel = 'geometry' and s.respondent_id = g.respondent_id
  join delphi.visible_round v on v.round = g.round and v.data
 where coalesce(g.square, g.triangle, g.hexagon) is not null or g.justification <> '';

create or replace view api.open_answers as
select r.round, r.respondent_id, r.panel, s.shown_group as "group", c.value as item,
       btrim(r.answers->>c.code, E' \t\r\n') as text
  from delphi.response r
  join delphi.code c on c.kind = 'open_' || r.panel and r.answers ? c.code
  join delphi.respondent s on s.round = r.round and s.panel = r.panel and s.respondent_id = r.respondent_id
  join delphi.visible_round v on v.round = r.round and v.data
 where btrim(r.answers->>c.code, E' \t\r\n') <> '';

create or replace view api.panel_profile as
with f as (
  select s.round, s.panel, x.field, x.value
    from delphi.respondent s
    cross join lateral (values ('respondents', 'total'),
                               ('public', case when s.disclosure = 'public' then 'yes' else 'no' end),
                               ('institution_type', coalesce(nullif(s.institution_type, ''), 'unanswered')),
                               ('experience', coalesce(nullif(s.experience, ''), 'unanswered')),
                               ('coi', coalesce(nullif(s.coi, ''), 'unanswered'))) x(field, value)
  union all
  select s.round, s.panel, 'grids', g
    from delphi.respondent s cross join lateral unnest(string_to_array(nullif(s.grids, ''), ' ')) g
)
select f.round, f.panel, f.field, f.value, count(*) as count
  from f join delphi.visible_round v on v.round = f.round and v.data
 group by f.round, f.panel, f.field, f.value;

-- ---------------------------------------------------------------- panel list

create or replace view api.panel as
with person as (
  select s.round, s.respondent_id, max(s.disclosure) as level,
         string_agg(s.panel, ', ' order by s.panel desc) as panels,
         coalesce(string_agg(distinct c.text, '; ' order by c.text), 'none declared') as conflict_of_interest
    from delphi.respondent s
    left join lateral (select case when s.disclosure = 'public' then s.panel || ': ' else '' end
                              || coalesce(nullif(s.coi_description, ''), 'yes') as text
                        where s.coi = 'yes') c on true
   where s.disclosure in ('named', 'public')
   group by s.round, s.respondent_id
)
select p.round,
       btrim(coalesce(n.firstname, '') || ' ' || coalesce(n.lastname, '')) as name,
       coalesce(n.institution, '') as institution,
       case when p.level = 'public' then p.panels else '' end as panels,
       p.level,
       case when p.level = 'public' then p.respondent_id else '' end as respondent_id,
       p.conflict_of_interest
  from person p
  join delphi.visible_round v on v.round = p.round and v.panel
  left join lateral (select * from delphi.participant x
                      where x.round = p.round and x.respondent_id = p.respondent_id
                      order by x.institution is null, x.panel limit 1) n on true;

create or replace view api.composition as
select s.round, s.panel, s.grp as "group", count(*) as respondents
  from delphi.respondent s join delphi.visible_round v on v.round = s.round and v.panel
 group by s.round, s.panel, s.grp;

create or replace view api.coi_anonymous as
select s.round, s.panel, s.grp as "group", count(*) as respondents,
       count(*) filter (where s.coi = 'yes') as declared
  from delphi.respondent s join delphi.visible_round v on v.round = s.round and v.panel
 where s.disclosure = 'anonymous'
 group by s.round, s.panel, s.grp;

-- ---------------------------------------------------------------- coordination

-- Problems to fix before publishing a round (coordinator only).
create or replace view api.issues as
select round, panel, respondent_id, 'duplicate respondent code in the same survey' as issue
  from delphi.response group by round, panel, respondent_id having count(*) > 1
union all
select round, panel, respondent_id, 'invalid respondent code (participant attribute_1)'
  from delphi.response where respondent_id !~ '^R[0-9]{3,}$'
union all
select round, panel, respondent_id, 'response without consent (excluded)'
  from delphi.profile where not coalesce(consent, false)
union all
select s.round, s.panel, s.respondent_id, 'named or public panellist without a name in the participant table'
  from delphi.respondent s
 where s.disclosure in ('named', 'public')
   and not exists (select from delphi.participant x where x.round = s.round and x.respondent_id = s.respondent_id
                     and btrim(coalesce(x.firstname, '') || coalesce(x.lastname, '')) <> '')
union all
select round, null, respondent_id, 'different disclosure levels in the two panels; the most restrictive applies'
  from delphi.profile where consent group by round, respondent_id having count(distinct disclosure_answered) > 1
union all
select round, panel, respondent_id, 'group shown as undisclosed (k rule)'
  from delphi.respondent where shown_group = 'undisclosed';

-- ---------------------------------------------------------------- round 02 feedback

-- Called from the JavaScript of a later round's survey with the participant's own
-- token (POST /rpc/feedback {"p_token": "..."}): returns that respondent's answers
-- in the previous closed round, next to the panel's n, median and interquartile
-- range for each item. Returns null for an unknown token.
create or replace function api.feedback(p_token text)
returns jsonb language plpgsql stable security definer
set search_path = pg_catalog, public, pg_temp as $$
declare
  cur record;
  t regclass;
  rid text;
  prev text;
begin
  if coalesce(p_token, '') = '' then
    return null;
  end if;
  for cur in select r.round, r.seq, v.panel, v.sid
               from delphi.round r
               cross join lateral (values ('geometry', r.sid_geometry), ('applications', r.sid_applications)) v(panel, sid)
              where v.sid is not null order by r.seq desc loop
    t := to_regclass('lime_tokens_' || cur.sid);
    continue when t is null;
    execute format('select attribute_1 from %s where token = $1', t) into rid using p_token;
    exit when rid is not null;
  end loop;
  if rid is null then
    return null;
  end if;
  select r.round into prev from delphi.round r
   where r.seq < cur.seq and r.closed_at is not null order by r.seq desc limit 1;
  if prev is null then
    return jsonb_build_object('respondent_id', rid, 'panel', cur.panel, 'previous_round', null);
  end if;
  return jsonb_build_object(
    'respondent_id', rid,
    'panel', cur.panel,
    'previous_round', prev,
    'relevance', (
      select coalesce(jsonb_agg(jsonb_build_object(
               'application_id', application_id, 'property', property, 'own', own,
               'n', n, 'median', median, 'iqr', iqr) order by application_id, property), '[]'::jsonb)
        from (select x.application_id, x.property,
                     max(x.v) filter (where x.respondent_id = rid) as own,
                     count(*) as n,
                     percentile_cont(0.5) within group (order by x.v) as median,
                     percentile_cont(0.75) within group (order by x.v)
                       - percentile_cont(0.25) within group (order by x.v) as iqr
                from (select *, nullif(relevance, '')::numeric as v from api.responses where round = prev) x
               where x.v is not null
               group by x.application_id, x.property) z),
    'grades', (
      select coalesce(jsonb_agg(jsonb_build_object(
               'property', property, 'geometry', geometry, 'own', own,
               'n', n, 'median', median, 'iqr', iqr) order by property, geometry), '[]'::jsonb)
        from (select g.property, u.geometry,
                     max(u.grade) filter (where g.respondent_id = rid) as own,
                     count(*) as n,
                     percentile_cont(0.5) within group (order by u.grade) as median,
                     percentile_cont(0.75) within group (order by u.grade)
                       - percentile_cont(0.25) within group (order by u.grade) as iqr
                from api.grades g
                cross join lateral (values ('square', nullif(g.square, '')::numeric),
                                           ('triangle', nullif(g.triangle, '')::numeric),
                                           ('hexagon', nullif(g.hexagon, '')::numeric)) u(geometry, grade)
               where g.round = prev and u.grade is not null
               group by g.property, u.geometry) z),
    'filter', (
      select coalesce(jsonb_agg(jsonb_build_object(
               'application_id', application_id, 'own', own, 'yes', yes, 'no', no, 'unknown', unknown)
               order by application_id), '[]'::jsonb)
        from (select f.application_id,
                     max(f.requires_exact_nesting) filter (where f.respondent_id = rid) as own,
                     count(*) filter (where f.requires_exact_nesting = 'yes') as yes,
                     count(*) filter (where f.requires_exact_nesting = 'no') as no,
                     count(*) filter (where f.requires_exact_nesting = 'unknown') as unknown
                from api.filter_votes f where f.round = prev
               group by f.application_id) z));
end $$;

-- ---------------------------------------------------------------- privileges

revoke all on all tables in schema api from public;
revoke all on function api.feedback(text) from public;
grant usage on schema api to delphi_anon, delphi_coord;
grant select on api.rounds, api.respondents, api.responses, api.familiarity, api.filter_votes, api.grades,
                api.open_answers, api.panel_profile, api.panel, api.composition, api.coi_anonymous
   to delphi_anon, delphi_coord;
grant select on api.issues to delphi_coord;
grant execute on function api.feedback(text) to delphi_anon, delphi_coord;
