--
-- PostgreSQL database dump
--

\restrict IgsrOtXCUG3naagMhKaVwAcRNOVFc06oWRHRmgZrzzdsv5VkhNqvx0dnKbw9643


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: lime_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lime_questions (
    qid integer NOT NULL,
    parent_qid integer DEFAULT 0 NOT NULL,
    sid integer DEFAULT 0 NOT NULL,
    gid integer DEFAULT 0 NOT NULL,
    type character varying(30) DEFAULT 'T'::character varying NOT NULL,
    title character varying(20) DEFAULT ''::character varying NOT NULL,
    preg text,
    other character varying(1) DEFAULT 'N'::character varying NOT NULL,
    mandatory character varying(1),
    encrypted character varying(1) DEFAULT 'N'::character varying,
    question_order integer NOT NULL,
    scale_id integer DEFAULT 0 NOT NULL,
    same_default integer DEFAULT 0 NOT NULL,
    relevance text,
    question_theme_name character varying(150),
    modulename character varying(255),
    same_script integer DEFAULT 0 NOT NULL
);


--
-- Name: lime_questions_qid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lime_questions_qid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lime_questions_qid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lime_questions_qid_seq OWNED BY public.lime_questions.qid;


--
-- Name: lime_responses_100101; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lime_responses_100101 (
    id integer NOT NULL,
    token character varying(36),
    submitdate timestamp without time zone,
    lastpage integer,
    startlanguage character varying(20) NOT NULL,
    seed character varying(31),
    quota_exit integer,
    "Q1" text,
    "Q2" character varying(5),
    "Q2_Cother" text,
    "Q3" character varying(5),
    "Q4" character varying(5),
    "Q5_S19" character varying(5),
    "Q5_S20" character varying(5),
    "Q5_S21" character varying(5),
    "Q5_S22" character varying(5),
    "Q5_S23" character varying(5),
    "Q5_S24" character varying(5),
    "Q6" character varying(5),
    "Q7" text,
    "Q8" character varying(5),
    "Q9_S25" character varying(5),
    "Q10" character varying(1),
    "Q11" character varying(1),
    "Q12_S26_S31" text,
    "Q12_S26_S32" text,
    "Q12_S26_S33" text,
    "Q12_S27_S31" text,
    "Q12_S27_S32" text,
    "Q12_S27_S33" text,
    "Q12_S28_S31" text,
    "Q12_S28_S32" text,
    "Q12_S28_S33" text,
    "Q12_S29_S31" text,
    "Q12_S29_S32" text,
    "Q12_S29_S33" text,
    "Q12_S30_S31" text,
    "Q12_S30_S32" text,
    "Q12_S30_S33" text,
    "Q13_S34" text,
    "Q13_S35" text,
    "Q13_S36" text,
    "Q13_S37" text,
    "Q13_S38" text,
    "Q14" character varying(1),
    "Q15" text,
    "Q16" text,
    "Q17" text,
    "Q18" text
);


--
-- Name: lime_responses_100101_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lime_responses_100101_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lime_responses_100101_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lime_responses_100101_id_seq OWNED BY public.lime_responses_100101.id;


--
-- Name: lime_responses_100102; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lime_responses_100102 (
    id integer NOT NULL,
    token character varying(36),
    submitdate timestamp without time zone,
    lastpage integer,
    startlanguage character varying(20) NOT NULL,
    seed character varying(31),
    quota_exit integer,
    "Q39" text,
    "Q40" character varying(5),
    "Q40_Cother" text,
    "Q41" character varying(5),
    "Q42" character varying(5),
    "Q43_S97" character varying(5),
    "Q43_S98" character varying(5),
    "Q43_S99" character varying(5),
    "Q43_S100" character varying(5),
    "Q43_S101" character varying(5),
    "Q44" character varying(5),
    "Q45" text,
    "Q46" character varying(5),
    "Q47_S102" character varying(5),
    "Q48" character varying(1),
    "Q49" character varying(5),
    "Q50_S103" character varying(5),
    "Q50_S104" character varying(5),
    "Q50_S105" character varying(5),
    "Q50_S106" character varying(5),
    "Q50_S107" character varying(5),
    "Q50_S108" character varying(5),
    "Q50_S109" character varying(5),
    "Q50_S110" character varying(5),
    "Q50_S111" character varying(5),
    "Q51_S112" text,
    "Q51_S113" text,
    "Q51_S114" text,
    "Q51_S115" text,
    "Q51_S116" text,
    "Q51_S117" text,
    "Q51_S118" text,
    "Q51_S119" text,
    "Q51_S120" text,
    "Q52" character varying(5),
    "Q53_S121" character varying(5),
    "Q53_S122" character varying(5),
    "Q53_S123" character varying(5),
    "Q53_S124" character varying(5),
    "Q53_S125" character varying(5),
    "Q53_S126" character varying(5),
    "Q53_S127" character varying(5),
    "Q53_S128" character varying(5),
    "Q53_S129" character varying(5),
    "Q54_S130" text,
    "Q54_S131" text,
    "Q54_S132" text,
    "Q54_S133" text,
    "Q54_S134" text,
    "Q54_S135" text,
    "Q54_S136" text,
    "Q54_S137" text,
    "Q54_S138" text,
    "Q55" character varying(5),
    "Q56_S139" character varying(5),
    "Q56_S140" character varying(5),
    "Q56_S141" character varying(5),
    "Q56_S142" character varying(5),
    "Q56_S143" character varying(5),
    "Q56_S144" character varying(5),
    "Q56_S145" character varying(5),
    "Q56_S146" character varying(5),
    "Q56_S147" character varying(5),
    "Q57_S148" text,
    "Q57_S149" text,
    "Q57_S150" text,
    "Q57_S151" text,
    "Q57_S152" text,
    "Q57_S153" text,
    "Q57_S154" text,
    "Q57_S155" text,
    "Q57_S156" text,
    "Q58" character varying(5),
    "Q59_S157" character varying(5),
    "Q59_S158" character varying(5),
    "Q59_S159" character varying(5),
    "Q59_S160" character varying(5),
    "Q59_S161" character varying(5),
    "Q59_S162" character varying(5),
    "Q59_S163" character varying(5),
    "Q59_S164" character varying(5),
    "Q59_S165" character varying(5),
    "Q60_S166" text,
    "Q60_S167" text,
    "Q60_S168" text,
    "Q60_S169" text,
    "Q60_S170" text,
    "Q60_S171" text,
    "Q60_S172" text,
    "Q60_S173" text,
    "Q60_S174" text,
    "Q61" character varying(5),
    "Q62_S175" character varying(5),
    "Q62_S176" character varying(5),
    "Q62_S177" character varying(5),
    "Q62_S178" character varying(5),
    "Q62_S179" character varying(5),
    "Q62_S180" character varying(5),
    "Q62_S181" character varying(5),
    "Q62_S182" character varying(5),
    "Q62_S183" character varying(5),
    "Q63_S184" text,
    "Q63_S185" text,
    "Q63_S186" text,
    "Q63_S187" text,
    "Q63_S188" text,
    "Q63_S189" text,
    "Q63_S190" text,
    "Q63_S191" text,
    "Q63_S192" text,
    "Q64" character varying(5),
    "Q65_S193" character varying(5),
    "Q65_S194" character varying(5),
    "Q65_S195" character varying(5),
    "Q65_S196" character varying(5),
    "Q65_S197" character varying(5),
    "Q65_S198" character varying(5),
    "Q65_S199" character varying(5),
    "Q65_S200" character varying(5),
    "Q65_S201" character varying(5),
    "Q66_S202" text,
    "Q66_S203" text,
    "Q66_S204" text,
    "Q66_S205" text,
    "Q66_S206" text,
    "Q66_S207" text,
    "Q66_S208" text,
    "Q66_S209" text,
    "Q66_S210" text,
    "Q67" character varying(5),
    "Q68_S211" character varying(5),
    "Q68_S212" character varying(5),
    "Q68_S213" character varying(5),
    "Q68_S214" character varying(5),
    "Q68_S215" character varying(5),
    "Q68_S216" character varying(5),
    "Q68_S217" character varying(5),
    "Q68_S218" character varying(5),
    "Q68_S219" character varying(5),
    "Q69_S220" text,
    "Q69_S221" text,
    "Q69_S222" text,
    "Q69_S223" text,
    "Q69_S224" text,
    "Q69_S225" text,
    "Q69_S226" text,
    "Q69_S227" text,
    "Q69_S228" text,
    "Q70" character varying(5),
    "Q71_S229" character varying(5),
    "Q71_S230" character varying(5),
    "Q71_S231" character varying(5),
    "Q71_S232" character varying(5),
    "Q71_S233" character varying(5),
    "Q71_S234" character varying(5),
    "Q71_S235" character varying(5),
    "Q71_S236" character varying(5),
    "Q71_S237" character varying(5),
    "Q72_S238" text,
    "Q72_S239" text,
    "Q72_S240" text,
    "Q72_S241" text,
    "Q72_S242" text,
    "Q72_S243" text,
    "Q72_S244" text,
    "Q72_S245" text,
    "Q72_S246" text,
    "Q73" character varying(5),
    "Q74_S247" character varying(5),
    "Q74_S248" character varying(5),
    "Q74_S249" character varying(5),
    "Q74_S250" character varying(5),
    "Q74_S251" character varying(5),
    "Q74_S252" character varying(5),
    "Q74_S253" character varying(5),
    "Q74_S254" character varying(5),
    "Q74_S255" character varying(5),
    "Q75_S256" text,
    "Q75_S257" text,
    "Q75_S258" text,
    "Q75_S259" text,
    "Q75_S260" text,
    "Q75_S261" text,
    "Q75_S262" text,
    "Q75_S263" text,
    "Q75_S264" text,
    "Q76" character varying(5),
    "Q77_S265" character varying(5),
    "Q77_S266" character varying(5),
    "Q77_S267" character varying(5),
    "Q77_S268" character varying(5),
    "Q77_S269" character varying(5),
    "Q77_S270" character varying(5),
    "Q77_S271" character varying(5),
    "Q77_S272" character varying(5),
    "Q77_S273" character varying(5),
    "Q78_S274" text,
    "Q78_S275" text,
    "Q78_S276" text,
    "Q78_S277" text,
    "Q78_S278" text,
    "Q78_S279" text,
    "Q78_S280" text,
    "Q78_S281" text,
    "Q78_S282" text,
    "Q79" character varying(5),
    "Q80_S283" character varying(5),
    "Q80_S284" character varying(5),
    "Q80_S285" character varying(5),
    "Q80_S286" character varying(5),
    "Q80_S287" character varying(5),
    "Q80_S288" character varying(5),
    "Q80_S289" character varying(5),
    "Q80_S290" character varying(5),
    "Q80_S291" character varying(5),
    "Q81_S292" text,
    "Q81_S293" text,
    "Q81_S294" text,
    "Q81_S295" text,
    "Q81_S296" text,
    "Q81_S297" text,
    "Q81_S298" text,
    "Q81_S299" text,
    "Q81_S300" text,
    "Q82" character varying(5),
    "Q83_S301" character varying(5),
    "Q83_S302" character varying(5),
    "Q83_S303" character varying(5),
    "Q83_S304" character varying(5),
    "Q83_S305" character varying(5),
    "Q83_S306" character varying(5),
    "Q83_S307" character varying(5),
    "Q83_S308" character varying(5),
    "Q83_S309" character varying(5),
    "Q84_S310" text,
    "Q84_S311" text,
    "Q84_S312" text,
    "Q84_S313" text,
    "Q84_S314" text,
    "Q84_S315" text,
    "Q84_S316" text,
    "Q84_S317" text,
    "Q84_S318" text,
    "Q85" character varying(5),
    "Q86_S319" character varying(5),
    "Q86_S320" character varying(5),
    "Q86_S321" character varying(5),
    "Q86_S322" character varying(5),
    "Q86_S323" character varying(5),
    "Q86_S324" character varying(5),
    "Q86_S325" character varying(5),
    "Q86_S326" character varying(5),
    "Q86_S327" character varying(5),
    "Q87_S328" text,
    "Q87_S329" text,
    "Q87_S330" text,
    "Q87_S331" text,
    "Q87_S332" text,
    "Q87_S333" text,
    "Q87_S334" text,
    "Q87_S335" text,
    "Q87_S336" text,
    "Q88" character varying(5),
    "Q89_S337" character varying(5),
    "Q89_S338" character varying(5),
    "Q89_S339" character varying(5),
    "Q89_S340" character varying(5),
    "Q89_S341" character varying(5),
    "Q89_S342" character varying(5),
    "Q89_S343" character varying(5),
    "Q89_S344" character varying(5),
    "Q89_S345" character varying(5),
    "Q90_S346" text,
    "Q90_S347" text,
    "Q90_S348" text,
    "Q90_S349" text,
    "Q90_S350" text,
    "Q90_S351" text,
    "Q90_S352" text,
    "Q90_S353" text,
    "Q90_S354" text,
    "Q91_S355" character varying(5),
    "Q91_S356" character varying(5),
    "Q91_S357" character varying(5),
    "Q91_S358" character varying(5),
    "Q91_S359" character varying(5),
    "Q91_S360" character varying(5),
    "Q91_S361" character varying(5),
    "Q91_S362" character varying(5),
    "Q91_S363" character varying(5),
    "Q91_S364" character varying(5),
    "Q91_S365" character varying(5),
    "Q91_S366" character varying(5),
    "Q91_S367" character varying(5),
    "Q91_S368" character varying(5),
    "Q92_S369" text,
    "Q92_S370" text,
    "Q92_S371" text,
    "Q92_S372" text,
    "Q92_S373" text,
    "Q92_S374" text,
    "Q92_S375" text,
    "Q92_S376" text,
    "Q92_S377" text,
    "Q92_S378" text,
    "Q92_S379" text,
    "Q92_S380" text,
    "Q92_S381" text,
    "Q92_S382" text,
    "Q93" text,
    "Q94" text,
    "Q95" text,
    "Q96" text
);


--
-- Name: lime_responses_100102_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lime_responses_100102_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lime_responses_100102_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lime_responses_100102_id_seq OWNED BY public.lime_responses_100102.id;


--
-- Name: lime_tokens_100101; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lime_tokens_100101 (
    tid integer NOT NULL,
    participant_id character varying(50),
    firstname text,
    lastname text,
    email text,
    emailstatus text,
    token character varying(36),
    language character varying(25),
    blacklisted character varying(17),
    sent character varying(17) DEFAULT 'N'::character varying,
    remindersent character varying(17) DEFAULT 'N'::character varying,
    remindercount integer DEFAULT 0,
    completed character varying(17) DEFAULT 'N'::character varying,
    usesleft integer DEFAULT 1,
    validfrom timestamp without time zone,
    validuntil timestamp without time zone,
    mpid integer,
    attribute_1 text,
    attribute_2 text
);


--
-- Name: lime_tokens_100101_tid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lime_tokens_100101_tid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lime_tokens_100101_tid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lime_tokens_100101_tid_seq OWNED BY public.lime_tokens_100101.tid;


--
-- Name: lime_tokens_100102; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lime_tokens_100102 (
    tid integer NOT NULL,
    participant_id character varying(50),
    firstname text,
    lastname text,
    email text,
    emailstatus text,
    token character varying(36),
    language character varying(25),
    blacklisted character varying(17),
    sent character varying(17) DEFAULT 'N'::character varying,
    remindersent character varying(17) DEFAULT 'N'::character varying,
    remindercount integer DEFAULT 0,
    completed character varying(17) DEFAULT 'N'::character varying,
    usesleft integer DEFAULT 1,
    validfrom timestamp without time zone,
    validuntil timestamp without time zone,
    mpid integer,
    attribute_1 text,
    attribute_2 text
);


--
-- Name: lime_tokens_100102_tid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lime_tokens_100102_tid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lime_tokens_100102_tid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lime_tokens_100102_tid_seq OWNED BY public.lime_tokens_100102.tid;


--
-- Name: lime_questions qid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_questions ALTER COLUMN qid SET DEFAULT nextval('public.lime_questions_qid_seq'::regclass);


--
-- Name: lime_responses_100101 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_responses_100101 ALTER COLUMN id SET DEFAULT nextval('public.lime_responses_100101_id_seq'::regclass);


--
-- Name: lime_responses_100102 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_responses_100102 ALTER COLUMN id SET DEFAULT nextval('public.lime_responses_100102_id_seq'::regclass);


--
-- Name: lime_tokens_100101 tid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_tokens_100101 ALTER COLUMN tid SET DEFAULT nextval('public.lime_tokens_100101_tid_seq'::regclass);


--
-- Name: lime_tokens_100102 tid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_tokens_100102 ALTER COLUMN tid SET DEFAULT nextval('public.lime_tokens_100102_tid_seq'::regclass);


--
-- Data for Name: lime_questions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lime_questions (qid, parent_qid, sid, gid, type, title, preg, other, mandatory, encrypted, question_order, scale_id, same_default, relevance, question_theme_name, modulename, same_script) FROM stdin;
1	0	100101	1	*	RID		N	N	N	0	0	0	1	equation	\N	0
2	0	100101	1	L	AREA		Y	Y	N	1	0	0	1	listradio	\N	0
3	0	100101	1	L	INST		N	Y	N	2	0	0	1	listradio	\N	0
4	0	100101	1	L	EXPER		N	Y	N	3	0	0	1	listradio	\N	0
5	0	100101	1	M	GRIDS		N	Y	N	4	0	0	1	multiplechoice	\N	0
6	0	100101	1	L	COI		N	Y	N	11	0	0	1	listradio	\N	0
7	0	100101	1	T	COIdesc		N	Y	N	12	0	0	COI.NAOK == 'Y'	longfreetext	\N	0
8	0	100101	1	L	DISC		N	Y	N	13	0	0	1	listradio	\N	0
9	0	100101	1	M	CONS		N	Y	N	14	0	0	1	multiplechoice	\N	0
10	0	100101	2	X	SHAPES		N	N	N	0	0	0	1	boilerplate	\N	0
11	0	100101	3	X	GRDdefs		N	N	N	0	0	0	1	boilerplate	\N	0
12	0	100101	3	:	GRD		N	N	N	1	0	0	1	arrays/multiflexi	\N	0
13	0	100101	3	Q	GRDj		N	N	N	10	0	0	1	multipleshorttext	\N	0
14	0	100101	4	X	OBJtab		N	N	N	0	0	0	1	boilerplate	\N	0
15	0	100101	4	T	OBJ		N	N	N	1	0	0	1	longfreetext	\N	0
16	0	100101	5	T	DEFS		N	N	N	0	0	0	1	longfreetext	\N	0
17	0	100101	5	T	NEWP		N	N	N	1	0	0	1	longfreetext	\N	0
18	0	100101	5	T	COMM		N	N	N	2	0	0	1	longfreetext	\N	0
19	5	100101	1	M	ISO		N	N	N	5	0	0	1	\N	\N	0
20	5	100101	1	M	HEX		N	N	N	6	0	0	1	\N	\N	0
21	5	100101	1	M	QUAD		N	N	N	7	0	0	1	\N	\N	0
22	5	100101	1	M	TRI		N	N	N	8	0	0	1	\N	\N	0
23	5	100101	1	M	SFC		N	N	N	9	0	0	1	\N	\N	0
24	5	100101	1	M	NONE		N	N	N	10	0	0	1	\N	\N	0
25	9	100101	1	M	ok		N	N	N	15	0	0	1	\N	\N	0
26	12	100101	3	:	P1b		N	N	N	2	0	0	1	\N	\N	0
27	12	100101	3	:	P2		N	N	N	3	0	0	1	\N	\N	0
28	12	100101	3	:	P3		N	N	N	4	0	0	1	\N	\N	0
29	12	100101	3	:	P4		N	N	N	5	0	0	1	\N	\N	0
30	12	100101	3	:	P8		N	N	N	6	0	0	1	\N	\N	0
31	12	100101	3	:	square		N	N	N	7	1	0	1	\N	\N	0
32	12	100101	3	:	triangle		N	N	N	8	1	0	1	\N	\N	0
33	12	100101	3	:	hexagon		N	N	N	9	1	0	1	\N	\N	0
34	13	100101	3	Q	P1b		N	N	N	11	0	0	1	\N	\N	0
35	13	100101	3	Q	P2		N	N	N	12	0	0	1	\N	\N	0
36	13	100101	3	Q	P3		N	N	N	13	0	0	1	\N	\N	0
37	13	100101	3	Q	P4		N	N	N	14	0	0	1	\N	\N	0
38	13	100101	3	Q	P8		N	N	N	15	0	0	1	\N	\N	0
39	0	100102	6	*	RID		N	N	N	0	0	0	1	equation	\N	0
40	0	100102	6	L	UGRP		Y	Y	N	1	0	0	1	listradio	\N	0
41	0	100102	6	L	INST		N	Y	N	2	0	0	1	listradio	\N	0
42	0	100102	6	L	EXPER		N	Y	N	3	0	0	1	listradio	\N	0
43	0	100102	6	M	GRIDS		N	Y	N	4	0	0	1	multiplechoice	\N	0
44	0	100102	6	L	COI		N	Y	N	10	0	0	1	listradio	\N	0
45	0	100102	6	T	COIdesc		N	Y	N	11	0	0	COI.NAOK == 'Y'	longfreetext	\N	0
46	0	100102	6	L	DISC		N	Y	N	12	0	0	1	listradio	\N	0
47	0	100102	6	M	CONS		N	Y	N	13	0	0	1	multiplechoice	\N	0
48	0	100102	7	X	DEFStab		N	N	N	0	0	0	1	boilerplate	\N	0
49	0	100102	8	L	A01fam		N	Y	N	0	0	0	1	listradio	\N	0
50	0	100102	8	F	A01rel		N	N	N	1	0	0	(A01fam.NAOK == 'H' or A01fam.NAOK == 'M')	arrays/array	\N	0
51	0	100102	8	Q	A01com		N	N	N	11	0	0	(A01fam.NAOK == 'H' or A01fam.NAOK == 'M')	multipleshorttext	\N	0
52	0	100102	9	L	A02fam		N	Y	N	0	0	0	1	listradio	\N	0
53	0	100102	9	F	A02rel		N	N	N	1	0	0	(A02fam.NAOK == 'H' or A02fam.NAOK == 'M')	arrays/array	\N	0
54	0	100102	9	Q	A02com		N	N	N	11	0	0	(A02fam.NAOK == 'H' or A02fam.NAOK == 'M')	multipleshorttext	\N	0
55	0	100102	10	L	A03fam		N	Y	N	0	0	0	1	listradio	\N	0
56	0	100102	10	F	A03rel		N	N	N	1	0	0	(A03fam.NAOK == 'H' or A03fam.NAOK == 'M')	arrays/array	\N	0
57	0	100102	10	Q	A03com		N	N	N	11	0	0	(A03fam.NAOK == 'H' or A03fam.NAOK == 'M')	multipleshorttext	\N	0
58	0	100102	11	L	A04fam		N	Y	N	0	0	0	1	listradio	\N	0
59	0	100102	11	F	A04rel		N	N	N	1	0	0	(A04fam.NAOK == 'H' or A04fam.NAOK == 'M')	arrays/array	\N	0
60	0	100102	11	Q	A04com		N	N	N	11	0	0	(A04fam.NAOK == 'H' or A04fam.NAOK == 'M')	multipleshorttext	\N	0
61	0	100102	12	L	A05fam		N	Y	N	0	0	0	1	listradio	\N	0
62	0	100102	12	F	A05rel		N	N	N	1	0	0	(A05fam.NAOK == 'H' or A05fam.NAOK == 'M')	arrays/array	\N	0
63	0	100102	12	Q	A05com		N	N	N	11	0	0	(A05fam.NAOK == 'H' or A05fam.NAOK == 'M')	multipleshorttext	\N	0
64	0	100102	13	L	A06fam		N	Y	N	0	0	0	1	listradio	\N	0
65	0	100102	13	F	A06rel		N	N	N	1	0	0	(A06fam.NAOK == 'H' or A06fam.NAOK == 'M')	arrays/array	\N	0
66	0	100102	13	Q	A06com		N	N	N	11	0	0	(A06fam.NAOK == 'H' or A06fam.NAOK == 'M')	multipleshorttext	\N	0
67	0	100102	14	L	A07fam		N	Y	N	0	0	0	1	listradio	\N	0
68	0	100102	14	F	A07rel		N	N	N	1	0	0	(A07fam.NAOK == 'H' or A07fam.NAOK == 'M')	arrays/array	\N	0
69	0	100102	14	Q	A07com		N	N	N	11	0	0	(A07fam.NAOK == 'H' or A07fam.NAOK == 'M')	multipleshorttext	\N	0
70	0	100102	15	L	A08fam		N	Y	N	0	0	0	1	listradio	\N	0
71	0	100102	15	F	A08rel		N	N	N	1	0	0	(A08fam.NAOK == 'H' or A08fam.NAOK == 'M')	arrays/array	\N	0
72	0	100102	15	Q	A08com		N	N	N	11	0	0	(A08fam.NAOK == 'H' or A08fam.NAOK == 'M')	multipleshorttext	\N	0
73	0	100102	16	L	A09fam		N	Y	N	0	0	0	1	listradio	\N	0
74	0	100102	16	F	A09rel		N	N	N	1	0	0	(A09fam.NAOK == 'H' or A09fam.NAOK == 'M')	arrays/array	\N	0
160	59	100102	11	F	P3		N	N	N	5	0	0	1	\N	\N	0
75	0	100102	16	Q	A09com		N	N	N	11	0	0	(A09fam.NAOK == 'H' or A09fam.NAOK == 'M')	multipleshorttext	\N	0
76	0	100102	17	L	A10fam		N	Y	N	0	0	0	1	listradio	\N	0
77	0	100102	17	F	A10rel		N	N	N	1	0	0	(A10fam.NAOK == 'H' or A10fam.NAOK == 'M')	arrays/array	\N	0
78	0	100102	17	Q	A10com		N	N	N	11	0	0	(A10fam.NAOK == 'H' or A10fam.NAOK == 'M')	multipleshorttext	\N	0
79	0	100102	18	L	A11fam		N	Y	N	0	0	0	1	listradio	\N	0
80	0	100102	18	F	A11rel		N	N	N	1	0	0	(A11fam.NAOK == 'H' or A11fam.NAOK == 'M')	arrays/array	\N	0
81	0	100102	18	Q	A11com		N	N	N	11	0	0	(A11fam.NAOK == 'H' or A11fam.NAOK == 'M')	multipleshorttext	\N	0
82	0	100102	19	L	A12fam		N	Y	N	0	0	0	1	listradio	\N	0
83	0	100102	19	F	A12rel		N	N	N	1	0	0	(A12fam.NAOK == 'H' or A12fam.NAOK == 'M')	arrays/array	\N	0
84	0	100102	19	Q	A12com		N	N	N	11	0	0	(A12fam.NAOK == 'H' or A12fam.NAOK == 'M')	multipleshorttext	\N	0
85	0	100102	20	L	A13fam		N	Y	N	0	0	0	1	listradio	\N	0
86	0	100102	20	F	A13rel		N	N	N	1	0	0	(A13fam.NAOK == 'H' or A13fam.NAOK == 'M')	arrays/array	\N	0
87	0	100102	20	Q	A13com		N	N	N	11	0	0	(A13fam.NAOK == 'H' or A13fam.NAOK == 'M')	multipleshorttext	\N	0
88	0	100102	21	L	A14fam		N	Y	N	0	0	0	1	listradio	\N	0
89	0	100102	21	F	A14rel		N	N	N	1	0	0	(A14fam.NAOK == 'H' or A14fam.NAOK == 'M')	arrays/array	\N	0
90	0	100102	21	Q	A14com		N	N	N	11	0	0	(A14fam.NAOK == 'H' or A14fam.NAOK == 'M')	multipleshorttext	\N	0
91	0	100102	22	F	NEST		N	N	N	0	0	0	1	arrays/array	\N	0
92	0	100102	22	Q	NESTj		N	N	N	15	0	0	1	multipleshorttext	\N	0
93	0	100102	23	T	NEWA		N	N	N	0	0	0	1	longfreetext	\N	0
94	0	100102	23	T	NEED		N	N	N	1	0	0	1	longfreetext	\N	0
95	0	100102	23	T	DEFA		N	N	N	2	0	0	1	longfreetext	\N	0
96	0	100102	23	T	COMM		N	N	N	3	0	0	1	longfreetext	\N	0
97	43	100102	6	M	STAT		N	N	N	5	0	0	1	\N	\N	0
98	43	100102	6	M	HEX		N	N	N	6	0	0	1	\N	\N	0
99	43	100102	6	M	QUAD		N	N	N	7	0	0	1	\N	\N	0
100	43	100102	6	M	GEOC		N	N	N	8	0	0	1	\N	\N	0
101	43	100102	6	M	NONE		N	N	N	9	0	0	1	\N	\N	0
102	47	100102	6	M	ok		N	N	N	14	0	0	1	\N	\N	0
103	50	100102	8	F	P1a		N	N	N	2	0	0	1	\N	\N	0
104	50	100102	8	F	P1b		N	N	N	3	0	0	1	\N	\N	0
105	50	100102	8	F	P2		N	N	N	4	0	0	1	\N	\N	0
106	50	100102	8	F	P3		N	N	N	5	0	0	1	\N	\N	0
107	50	100102	8	F	P4		N	N	N	6	0	0	1	\N	\N	0
108	50	100102	8	F	P5		N	N	N	7	0	0	1	\N	\N	0
109	50	100102	8	F	P6		N	N	N	8	0	0	1	\N	\N	0
110	50	100102	8	F	P7		N	N	N	9	0	0	1	\N	\N	0
111	50	100102	8	F	P8		N	N	N	10	0	0	1	\N	\N	0
112	51	100102	8	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
113	51	100102	8	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
114	51	100102	8	Q	P2		N	N	N	14	0	0	1	\N	\N	0
115	51	100102	8	Q	P3		N	N	N	15	0	0	1	\N	\N	0
116	51	100102	8	Q	P4		N	N	N	16	0	0	1	\N	\N	0
117	51	100102	8	Q	P5		N	N	N	17	0	0	1	\N	\N	0
118	51	100102	8	Q	P6		N	N	N	18	0	0	1	\N	\N	0
119	51	100102	8	Q	P7		N	N	N	19	0	0	1	\N	\N	0
120	51	100102	8	Q	P8		N	N	N	20	0	0	1	\N	\N	0
121	53	100102	9	F	P1a		N	N	N	2	0	0	1	\N	\N	0
122	53	100102	9	F	P1b		N	N	N	3	0	0	1	\N	\N	0
123	53	100102	9	F	P2		N	N	N	4	0	0	1	\N	\N	0
124	53	100102	9	F	P3		N	N	N	5	0	0	1	\N	\N	0
125	53	100102	9	F	P4		N	N	N	6	0	0	1	\N	\N	0
126	53	100102	9	F	P5		N	N	N	7	0	0	1	\N	\N	0
127	53	100102	9	F	P6		N	N	N	8	0	0	1	\N	\N	0
128	53	100102	9	F	P7		N	N	N	9	0	0	1	\N	\N	0
129	53	100102	9	F	P8		N	N	N	10	0	0	1	\N	\N	0
130	54	100102	9	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
131	54	100102	9	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
132	54	100102	9	Q	P2		N	N	N	14	0	0	1	\N	\N	0
133	54	100102	9	Q	P3		N	N	N	15	0	0	1	\N	\N	0
134	54	100102	9	Q	P4		N	N	N	16	0	0	1	\N	\N	0
135	54	100102	9	Q	P5		N	N	N	17	0	0	1	\N	\N	0
136	54	100102	9	Q	P6		N	N	N	18	0	0	1	\N	\N	0
137	54	100102	9	Q	P7		N	N	N	19	0	0	1	\N	\N	0
138	54	100102	9	Q	P8		N	N	N	20	0	0	1	\N	\N	0
139	56	100102	10	F	P1a		N	N	N	2	0	0	1	\N	\N	0
140	56	100102	10	F	P1b		N	N	N	3	0	0	1	\N	\N	0
141	56	100102	10	F	P2		N	N	N	4	0	0	1	\N	\N	0
142	56	100102	10	F	P3		N	N	N	5	0	0	1	\N	\N	0
143	56	100102	10	F	P4		N	N	N	6	0	0	1	\N	\N	0
144	56	100102	10	F	P5		N	N	N	7	0	0	1	\N	\N	0
145	56	100102	10	F	P6		N	N	N	8	0	0	1	\N	\N	0
146	56	100102	10	F	P7		N	N	N	9	0	0	1	\N	\N	0
147	56	100102	10	F	P8		N	N	N	10	0	0	1	\N	\N	0
148	57	100102	10	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
149	57	100102	10	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
150	57	100102	10	Q	P2		N	N	N	14	0	0	1	\N	\N	0
151	57	100102	10	Q	P3		N	N	N	15	0	0	1	\N	\N	0
152	57	100102	10	Q	P4		N	N	N	16	0	0	1	\N	\N	0
153	57	100102	10	Q	P5		N	N	N	17	0	0	1	\N	\N	0
154	57	100102	10	Q	P6		N	N	N	18	0	0	1	\N	\N	0
155	57	100102	10	Q	P7		N	N	N	19	0	0	1	\N	\N	0
156	57	100102	10	Q	P8		N	N	N	20	0	0	1	\N	\N	0
157	59	100102	11	F	P1a		N	N	N	2	0	0	1	\N	\N	0
158	59	100102	11	F	P1b		N	N	N	3	0	0	1	\N	\N	0
159	59	100102	11	F	P2		N	N	N	4	0	0	1	\N	\N	0
161	59	100102	11	F	P4		N	N	N	6	0	0	1	\N	\N	0
162	59	100102	11	F	P5		N	N	N	7	0	0	1	\N	\N	0
163	59	100102	11	F	P6		N	N	N	8	0	0	1	\N	\N	0
164	59	100102	11	F	P7		N	N	N	9	0	0	1	\N	\N	0
165	59	100102	11	F	P8		N	N	N	10	0	0	1	\N	\N	0
166	60	100102	11	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
167	60	100102	11	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
168	60	100102	11	Q	P2		N	N	N	14	0	0	1	\N	\N	0
169	60	100102	11	Q	P3		N	N	N	15	0	0	1	\N	\N	0
170	60	100102	11	Q	P4		N	N	N	16	0	0	1	\N	\N	0
171	60	100102	11	Q	P5		N	N	N	17	0	0	1	\N	\N	0
172	60	100102	11	Q	P6		N	N	N	18	0	0	1	\N	\N	0
173	60	100102	11	Q	P7		N	N	N	19	0	0	1	\N	\N	0
174	60	100102	11	Q	P8		N	N	N	20	0	0	1	\N	\N	0
175	62	100102	12	F	P1a		N	N	N	2	0	0	1	\N	\N	0
176	62	100102	12	F	P1b		N	N	N	3	0	0	1	\N	\N	0
177	62	100102	12	F	P2		N	N	N	4	0	0	1	\N	\N	0
178	62	100102	12	F	P3		N	N	N	5	0	0	1	\N	\N	0
179	62	100102	12	F	P4		N	N	N	6	0	0	1	\N	\N	0
180	62	100102	12	F	P5		N	N	N	7	0	0	1	\N	\N	0
181	62	100102	12	F	P6		N	N	N	8	0	0	1	\N	\N	0
182	62	100102	12	F	P7		N	N	N	9	0	0	1	\N	\N	0
183	62	100102	12	F	P8		N	N	N	10	0	0	1	\N	\N	0
184	63	100102	12	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
185	63	100102	12	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
186	63	100102	12	Q	P2		N	N	N	14	0	0	1	\N	\N	0
187	63	100102	12	Q	P3		N	N	N	15	0	0	1	\N	\N	0
188	63	100102	12	Q	P4		N	N	N	16	0	0	1	\N	\N	0
189	63	100102	12	Q	P5		N	N	N	17	0	0	1	\N	\N	0
190	63	100102	12	Q	P6		N	N	N	18	0	0	1	\N	\N	0
191	63	100102	12	Q	P7		N	N	N	19	0	0	1	\N	\N	0
192	63	100102	12	Q	P8		N	N	N	20	0	0	1	\N	\N	0
193	65	100102	13	F	P1a		N	N	N	2	0	0	1	\N	\N	0
194	65	100102	13	F	P1b		N	N	N	3	0	0	1	\N	\N	0
195	65	100102	13	F	P2		N	N	N	4	0	0	1	\N	\N	0
196	65	100102	13	F	P3		N	N	N	5	0	0	1	\N	\N	0
197	65	100102	13	F	P4		N	N	N	6	0	0	1	\N	\N	0
198	65	100102	13	F	P5		N	N	N	7	0	0	1	\N	\N	0
199	65	100102	13	F	P6		N	N	N	8	0	0	1	\N	\N	0
200	65	100102	13	F	P7		N	N	N	9	0	0	1	\N	\N	0
201	65	100102	13	F	P8		N	N	N	10	0	0	1	\N	\N	0
202	66	100102	13	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
203	66	100102	13	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
204	66	100102	13	Q	P2		N	N	N	14	0	0	1	\N	\N	0
205	66	100102	13	Q	P3		N	N	N	15	0	0	1	\N	\N	0
206	66	100102	13	Q	P4		N	N	N	16	0	0	1	\N	\N	0
207	66	100102	13	Q	P5		N	N	N	17	0	0	1	\N	\N	0
208	66	100102	13	Q	P6		N	N	N	18	0	0	1	\N	\N	0
209	66	100102	13	Q	P7		N	N	N	19	0	0	1	\N	\N	0
210	66	100102	13	Q	P8		N	N	N	20	0	0	1	\N	\N	0
211	68	100102	14	F	P1a		N	N	N	2	0	0	1	\N	\N	0
212	68	100102	14	F	P1b		N	N	N	3	0	0	1	\N	\N	0
213	68	100102	14	F	P2		N	N	N	4	0	0	1	\N	\N	0
214	68	100102	14	F	P3		N	N	N	5	0	0	1	\N	\N	0
215	68	100102	14	F	P4		N	N	N	6	0	0	1	\N	\N	0
216	68	100102	14	F	P5		N	N	N	7	0	0	1	\N	\N	0
217	68	100102	14	F	P6		N	N	N	8	0	0	1	\N	\N	0
218	68	100102	14	F	P7		N	N	N	9	0	0	1	\N	\N	0
219	68	100102	14	F	P8		N	N	N	10	0	0	1	\N	\N	0
220	69	100102	14	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
221	69	100102	14	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
222	69	100102	14	Q	P2		N	N	N	14	0	0	1	\N	\N	0
223	69	100102	14	Q	P3		N	N	N	15	0	0	1	\N	\N	0
224	69	100102	14	Q	P4		N	N	N	16	0	0	1	\N	\N	0
225	69	100102	14	Q	P5		N	N	N	17	0	0	1	\N	\N	0
226	69	100102	14	Q	P6		N	N	N	18	0	0	1	\N	\N	0
227	69	100102	14	Q	P7		N	N	N	19	0	0	1	\N	\N	0
228	69	100102	14	Q	P8		N	N	N	20	0	0	1	\N	\N	0
229	71	100102	15	F	P1a		N	N	N	2	0	0	1	\N	\N	0
230	71	100102	15	F	P1b		N	N	N	3	0	0	1	\N	\N	0
231	71	100102	15	F	P2		N	N	N	4	0	0	1	\N	\N	0
232	71	100102	15	F	P3		N	N	N	5	0	0	1	\N	\N	0
233	71	100102	15	F	P4		N	N	N	6	0	0	1	\N	\N	0
234	71	100102	15	F	P5		N	N	N	7	0	0	1	\N	\N	0
235	71	100102	15	F	P6		N	N	N	8	0	0	1	\N	\N	0
236	71	100102	15	F	P7		N	N	N	9	0	0	1	\N	\N	0
237	71	100102	15	F	P8		N	N	N	10	0	0	1	\N	\N	0
238	72	100102	15	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
239	72	100102	15	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
240	72	100102	15	Q	P2		N	N	N	14	0	0	1	\N	\N	0
241	72	100102	15	Q	P3		N	N	N	15	0	0	1	\N	\N	0
242	72	100102	15	Q	P4		N	N	N	16	0	0	1	\N	\N	0
243	72	100102	15	Q	P5		N	N	N	17	0	0	1	\N	\N	0
244	72	100102	15	Q	P6		N	N	N	18	0	0	1	\N	\N	0
245	72	100102	15	Q	P7		N	N	N	19	0	0	1	\N	\N	0
246	72	100102	15	Q	P8		N	N	N	20	0	0	1	\N	\N	0
247	74	100102	16	F	P1a		N	N	N	2	0	0	1	\N	\N	0
248	74	100102	16	F	P1b		N	N	N	3	0	0	1	\N	\N	0
249	74	100102	16	F	P2		N	N	N	4	0	0	1	\N	\N	0
250	74	100102	16	F	P3		N	N	N	5	0	0	1	\N	\N	0
251	74	100102	16	F	P4		N	N	N	6	0	0	1	\N	\N	0
252	74	100102	16	F	P5		N	N	N	7	0	0	1	\N	\N	0
253	74	100102	16	F	P6		N	N	N	8	0	0	1	\N	\N	0
254	74	100102	16	F	P7		N	N	N	9	0	0	1	\N	\N	0
255	74	100102	16	F	P8		N	N	N	10	0	0	1	\N	\N	0
256	75	100102	16	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
257	75	100102	16	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
258	75	100102	16	Q	P2		N	N	N	14	0	0	1	\N	\N	0
259	75	100102	16	Q	P3		N	N	N	15	0	0	1	\N	\N	0
260	75	100102	16	Q	P4		N	N	N	16	0	0	1	\N	\N	0
261	75	100102	16	Q	P5		N	N	N	17	0	0	1	\N	\N	0
262	75	100102	16	Q	P6		N	N	N	18	0	0	1	\N	\N	0
263	75	100102	16	Q	P7		N	N	N	19	0	0	1	\N	\N	0
264	75	100102	16	Q	P8		N	N	N	20	0	0	1	\N	\N	0
265	77	100102	17	F	P1a		N	N	N	2	0	0	1	\N	\N	0
266	77	100102	17	F	P1b		N	N	N	3	0	0	1	\N	\N	0
267	77	100102	17	F	P2		N	N	N	4	0	0	1	\N	\N	0
268	77	100102	17	F	P3		N	N	N	5	0	0	1	\N	\N	0
269	77	100102	17	F	P4		N	N	N	6	0	0	1	\N	\N	0
270	77	100102	17	F	P5		N	N	N	7	0	0	1	\N	\N	0
271	77	100102	17	F	P6		N	N	N	8	0	0	1	\N	\N	0
272	77	100102	17	F	P7		N	N	N	9	0	0	1	\N	\N	0
273	77	100102	17	F	P8		N	N	N	10	0	0	1	\N	\N	0
274	78	100102	17	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
275	78	100102	17	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
276	78	100102	17	Q	P2		N	N	N	14	0	0	1	\N	\N	0
277	78	100102	17	Q	P3		N	N	N	15	0	0	1	\N	\N	0
278	78	100102	17	Q	P4		N	N	N	16	0	0	1	\N	\N	0
279	78	100102	17	Q	P5		N	N	N	17	0	0	1	\N	\N	0
280	78	100102	17	Q	P6		N	N	N	18	0	0	1	\N	\N	0
281	78	100102	17	Q	P7		N	N	N	19	0	0	1	\N	\N	0
282	78	100102	17	Q	P8		N	N	N	20	0	0	1	\N	\N	0
283	80	100102	18	F	P1a		N	N	N	2	0	0	1	\N	\N	0
284	80	100102	18	F	P1b		N	N	N	3	0	0	1	\N	\N	0
285	80	100102	18	F	P2		N	N	N	4	0	0	1	\N	\N	0
286	80	100102	18	F	P3		N	N	N	5	0	0	1	\N	\N	0
287	80	100102	18	F	P4		N	N	N	6	0	0	1	\N	\N	0
288	80	100102	18	F	P5		N	N	N	7	0	0	1	\N	\N	0
289	80	100102	18	F	P6		N	N	N	8	0	0	1	\N	\N	0
290	80	100102	18	F	P7		N	N	N	9	0	0	1	\N	\N	0
291	80	100102	18	F	P8		N	N	N	10	0	0	1	\N	\N	0
292	81	100102	18	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
293	81	100102	18	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
294	81	100102	18	Q	P2		N	N	N	14	0	0	1	\N	\N	0
295	81	100102	18	Q	P3		N	N	N	15	0	0	1	\N	\N	0
296	81	100102	18	Q	P4		N	N	N	16	0	0	1	\N	\N	0
297	81	100102	18	Q	P5		N	N	N	17	0	0	1	\N	\N	0
298	81	100102	18	Q	P6		N	N	N	18	0	0	1	\N	\N	0
299	81	100102	18	Q	P7		N	N	N	19	0	0	1	\N	\N	0
300	81	100102	18	Q	P8		N	N	N	20	0	0	1	\N	\N	0
301	83	100102	19	F	P1a		N	N	N	2	0	0	1	\N	\N	0
302	83	100102	19	F	P1b		N	N	N	3	0	0	1	\N	\N	0
303	83	100102	19	F	P2		N	N	N	4	0	0	1	\N	\N	0
304	83	100102	19	F	P3		N	N	N	5	0	0	1	\N	\N	0
305	83	100102	19	F	P4		N	N	N	6	0	0	1	\N	\N	0
306	83	100102	19	F	P5		N	N	N	7	0	0	1	\N	\N	0
307	83	100102	19	F	P6		N	N	N	8	0	0	1	\N	\N	0
308	83	100102	19	F	P7		N	N	N	9	0	0	1	\N	\N	0
309	83	100102	19	F	P8		N	N	N	10	0	0	1	\N	\N	0
310	84	100102	19	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
311	84	100102	19	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
312	84	100102	19	Q	P2		N	N	N	14	0	0	1	\N	\N	0
313	84	100102	19	Q	P3		N	N	N	15	0	0	1	\N	\N	0
314	84	100102	19	Q	P4		N	N	N	16	0	0	1	\N	\N	0
315	84	100102	19	Q	P5		N	N	N	17	0	0	1	\N	\N	0
316	84	100102	19	Q	P6		N	N	N	18	0	0	1	\N	\N	0
317	84	100102	19	Q	P7		N	N	N	19	0	0	1	\N	\N	0
318	84	100102	19	Q	P8		N	N	N	20	0	0	1	\N	\N	0
319	86	100102	20	F	P1a		N	N	N	2	0	0	1	\N	\N	0
320	86	100102	20	F	P1b		N	N	N	3	0	0	1	\N	\N	0
321	86	100102	20	F	P2		N	N	N	4	0	0	1	\N	\N	0
322	86	100102	20	F	P3		N	N	N	5	0	0	1	\N	\N	0
323	86	100102	20	F	P4		N	N	N	6	0	0	1	\N	\N	0
324	86	100102	20	F	P5		N	N	N	7	0	0	1	\N	\N	0
325	86	100102	20	F	P6		N	N	N	8	0	0	1	\N	\N	0
326	86	100102	20	F	P7		N	N	N	9	0	0	1	\N	\N	0
327	86	100102	20	F	P8		N	N	N	10	0	0	1	\N	\N	0
328	87	100102	20	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
329	87	100102	20	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
330	87	100102	20	Q	P2		N	N	N	14	0	0	1	\N	\N	0
331	87	100102	20	Q	P3		N	N	N	15	0	0	1	\N	\N	0
332	87	100102	20	Q	P4		N	N	N	16	0	0	1	\N	\N	0
333	87	100102	20	Q	P5		N	N	N	17	0	0	1	\N	\N	0
334	87	100102	20	Q	P6		N	N	N	18	0	0	1	\N	\N	0
335	87	100102	20	Q	P7		N	N	N	19	0	0	1	\N	\N	0
336	87	100102	20	Q	P8		N	N	N	20	0	0	1	\N	\N	0
337	89	100102	21	F	P1a		N	N	N	2	0	0	1	\N	\N	0
338	89	100102	21	F	P1b		N	N	N	3	0	0	1	\N	\N	0
339	89	100102	21	F	P2		N	N	N	4	0	0	1	\N	\N	0
340	89	100102	21	F	P3		N	N	N	5	0	0	1	\N	\N	0
341	89	100102	21	F	P4		N	N	N	6	0	0	1	\N	\N	0
342	89	100102	21	F	P5		N	N	N	7	0	0	1	\N	\N	0
343	89	100102	21	F	P6		N	N	N	8	0	0	1	\N	\N	0
344	89	100102	21	F	P7		N	N	N	9	0	0	1	\N	\N	0
345	89	100102	21	F	P8		N	N	N	10	0	0	1	\N	\N	0
346	90	100102	21	Q	P1a		N	N	N	12	0	0	1	\N	\N	0
347	90	100102	21	Q	P1b		N	N	N	13	0	0	1	\N	\N	0
348	90	100102	21	Q	P2		N	N	N	14	0	0	1	\N	\N	0
349	90	100102	21	Q	P3		N	N	N	15	0	0	1	\N	\N	0
350	90	100102	21	Q	P4		N	N	N	16	0	0	1	\N	\N	0
351	90	100102	21	Q	P5		N	N	N	17	0	0	1	\N	\N	0
352	90	100102	21	Q	P6		N	N	N	18	0	0	1	\N	\N	0
353	90	100102	21	Q	P7		N	N	N	19	0	0	1	\N	\N	0
354	90	100102	21	Q	P8		N	N	N	20	0	0	1	\N	\N	0
355	91	100102	22	F	A01		N	N	N	1	0	0	(A01fam.NAOK == 'H' or A01fam.NAOK == 'M')	\N	\N	0
356	91	100102	22	F	A02		N	N	N	2	0	0	(A02fam.NAOK == 'H' or A02fam.NAOK == 'M')	\N	\N	0
357	91	100102	22	F	A03		N	N	N	3	0	0	(A03fam.NAOK == 'H' or A03fam.NAOK == 'M')	\N	\N	0
358	91	100102	22	F	A04		N	N	N	4	0	0	(A04fam.NAOK == 'H' or A04fam.NAOK == 'M')	\N	\N	0
359	91	100102	22	F	A05		N	N	N	5	0	0	(A05fam.NAOK == 'H' or A05fam.NAOK == 'M')	\N	\N	0
360	91	100102	22	F	A06		N	N	N	6	0	0	(A06fam.NAOK == 'H' or A06fam.NAOK == 'M')	\N	\N	0
361	91	100102	22	F	A07		N	N	N	7	0	0	(A07fam.NAOK == 'H' or A07fam.NAOK == 'M')	\N	\N	0
362	91	100102	22	F	A08		N	N	N	8	0	0	(A08fam.NAOK == 'H' or A08fam.NAOK == 'M')	\N	\N	0
363	91	100102	22	F	A09		N	N	N	9	0	0	(A09fam.NAOK == 'H' or A09fam.NAOK == 'M')	\N	\N	0
364	91	100102	22	F	A10		N	N	N	10	0	0	(A10fam.NAOK == 'H' or A10fam.NAOK == 'M')	\N	\N	0
365	91	100102	22	F	A11		N	N	N	11	0	0	(A11fam.NAOK == 'H' or A11fam.NAOK == 'M')	\N	\N	0
366	91	100102	22	F	A12		N	N	N	12	0	0	(A12fam.NAOK == 'H' or A12fam.NAOK == 'M')	\N	\N	0
367	91	100102	22	F	A13		N	N	N	13	0	0	(A13fam.NAOK == 'H' or A13fam.NAOK == 'M')	\N	\N	0
368	91	100102	22	F	A14		N	N	N	14	0	0	(A14fam.NAOK == 'H' or A14fam.NAOK == 'M')	\N	\N	0
369	92	100102	22	Q	A01		N	N	N	16	0	0	(A01fam.NAOK == 'H' or A01fam.NAOK == 'M')	\N	\N	0
370	92	100102	22	Q	A02		N	N	N	17	0	0	(A02fam.NAOK == 'H' or A02fam.NAOK == 'M')	\N	\N	0
371	92	100102	22	Q	A03		N	N	N	18	0	0	(A03fam.NAOK == 'H' or A03fam.NAOK == 'M')	\N	\N	0
372	92	100102	22	Q	A04		N	N	N	19	0	0	(A04fam.NAOK == 'H' or A04fam.NAOK == 'M')	\N	\N	0
373	92	100102	22	Q	A05		N	N	N	20	0	0	(A05fam.NAOK == 'H' or A05fam.NAOK == 'M')	\N	\N	0
374	92	100102	22	Q	A06		N	N	N	21	0	0	(A06fam.NAOK == 'H' or A06fam.NAOK == 'M')	\N	\N	0
375	92	100102	22	Q	A07		N	N	N	22	0	0	(A07fam.NAOK == 'H' or A07fam.NAOK == 'M')	\N	\N	0
376	92	100102	22	Q	A08		N	N	N	23	0	0	(A08fam.NAOK == 'H' or A08fam.NAOK == 'M')	\N	\N	0
377	92	100102	22	Q	A09		N	N	N	24	0	0	(A09fam.NAOK == 'H' or A09fam.NAOK == 'M')	\N	\N	0
378	92	100102	22	Q	A10		N	N	N	25	0	0	(A10fam.NAOK == 'H' or A10fam.NAOK == 'M')	\N	\N	0
379	92	100102	22	Q	A11		N	N	N	26	0	0	(A11fam.NAOK == 'H' or A11fam.NAOK == 'M')	\N	\N	0
380	92	100102	22	Q	A12		N	N	N	27	0	0	(A12fam.NAOK == 'H' or A12fam.NAOK == 'M')	\N	\N	0
381	92	100102	22	Q	A13		N	N	N	28	0	0	(A13fam.NAOK == 'H' or A13fam.NAOK == 'M')	\N	\N	0
382	92	100102	22	Q	A14		N	N	N	29	0	0	(A14fam.NAOK == 'H' or A14fam.NAOK == 'M')	\N	\N	0
\.


--
-- Data for Name: lime_responses_100101; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lime_responses_100101 (id, token, submitdate, lastpage, startlanguage, seed, quota_exit, "Q1", "Q2", "Q2_Cother", "Q3", "Q4", "Q5_S19", "Q5_S20", "Q5_S21", "Q5_S22", "Q5_S23", "Q5_S24", "Q6", "Q7", "Q8", "Q9_S25", "Q10", "Q11", "Q12_S26_S31", "Q12_S26_S32", "Q12_S26_S33", "Q12_S27_S31", "Q12_S27_S32", "Q12_S27_S33", "Q12_S28_S31", "Q12_S28_S32", "Q12_S28_S33", "Q12_S29_S31", "Q12_S29_S32", "Q12_S29_S33", "Q12_S30_S31", "Q12_S30_S32", "Q12_S30_S33", "Q13_S34", "Q13_S35", "Q13_S36", "Q13_S37", "Q13_S38", "Q14", "Q15", "Q16", "Q17", "Q18") FROM stdin;
3	6kWLfgkERRmjMnP	1980-01-01 00:00:00	5	pt-BR	912119172	\N	R003	CS		UNI	E3		Y	Y				N	\N	NAMED	Y				0.7	0.5	0.7	0	1	0.5	0.5	1	0	0.5	0	0.5	0.7	0.7				Justificativa de teste para P4.			Objeção de teste à nota P7 do triângulo.		Propriedade proposta: isotropia de distâncias (teste).	
1	ED3ZIubiLCxB4yB	1980-01-01 00:00:00	5	pt-BR	1641448066	\N	R001	GEO		UNI	E3		Y	Y				Y	Consultoria para empresa de geocodificação (teste).	PUBL	Y				0	1	1	1	0	0	1	1	0.2	1		0.7	0.2	0.2				Justificativa de teste para P4.			Objeção de teste à nota P7 do triângulo.		Propriedade proposta: isotropia de distâncias (teste).	
4	XuGsjN4cjTe5gDa	1980-01-01 00:00:00	5	en	334013194	\N	R004	GEO		UNI	E3		Y	Y				N	\N	ANON	Y			0.7	1	0	0.5	0.2	0.7	0.7	0.5		1	0.7		0.7		0.2				Justificativa de teste para P4.			Objeção de teste à nota P7 do triângulo.		Propriedade proposta: isotropia de distâncias (teste).	
2	HN46hazmpQIlagb	1980-01-01 00:00:00	5	en	765579091	\N	R002	-oth-	Topologia algébrica	UNI	E3		Y	Y				N	\N	ANON	Y			1	0.5	0.2	1	0.5	0	1	1	0.5	0.7	0.2	0.2	0.5	0.5	0.5				Justificativa de teste para P4.			Objeção de teste à nota P7 do triângulo.		Propriedade proposta: isotropia de distâncias (teste).	
5	sUDocIcwulnrNzt	1980-01-01 00:00:00	5	pt-BR	1809363184	\N	R005	CGE		UNI	E3		Y	Y				N	\N	ANON	Y			0.2	1	0.5	0.7	1	0.2	1		0	1	0.7	0.7	0	0.2	0				Justificativa de teste para P4.			Objeção de teste à nota P7 do triângulo.		Propriedade proposta: isotropia de distâncias (teste).	
\.


--
-- Data for Name: lime_responses_100102; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lime_responses_100102 (id, token, submitdate, lastpage, startlanguage, seed, quota_exit, "Q39", "Q40", "Q40_Cother", "Q41", "Q42", "Q43_S97", "Q43_S98", "Q43_S99", "Q43_S100", "Q43_S101", "Q44", "Q45", "Q46", "Q47_S102", "Q48", "Q49", "Q50_S103", "Q50_S104", "Q50_S105", "Q50_S106", "Q50_S107", "Q50_S108", "Q50_S109", "Q50_S110", "Q50_S111", "Q51_S112", "Q51_S113", "Q51_S114", "Q51_S115", "Q51_S116", "Q51_S117", "Q51_S118", "Q51_S119", "Q51_S120", "Q52", "Q53_S121", "Q53_S122", "Q53_S123", "Q53_S124", "Q53_S125", "Q53_S126", "Q53_S127", "Q53_S128", "Q53_S129", "Q54_S130", "Q54_S131", "Q54_S132", "Q54_S133", "Q54_S134", "Q54_S135", "Q54_S136", "Q54_S137", "Q54_S138", "Q55", "Q56_S139", "Q56_S140", "Q56_S141", "Q56_S142", "Q56_S143", "Q56_S144", "Q56_S145", "Q56_S146", "Q56_S147", "Q57_S148", "Q57_S149", "Q57_S150", "Q57_S151", "Q57_S152", "Q57_S153", "Q57_S154", "Q57_S155", "Q57_S156", "Q58", "Q59_S157", "Q59_S158", "Q59_S159", "Q59_S160", "Q59_S161", "Q59_S162", "Q59_S163", "Q59_S164", "Q59_S165", "Q60_S166", "Q60_S167", "Q60_S168", "Q60_S169", "Q60_S170", "Q60_S171", "Q60_S172", "Q60_S173", "Q60_S174", "Q61", "Q62_S175", "Q62_S176", "Q62_S177", "Q62_S178", "Q62_S179", "Q62_S180", "Q62_S181", "Q62_S182", "Q62_S183", "Q63_S184", "Q63_S185", "Q63_S186", "Q63_S187", "Q63_S188", "Q63_S189", "Q63_S190", "Q63_S191", "Q63_S192", "Q64", "Q65_S193", "Q65_S194", "Q65_S195", "Q65_S196", "Q65_S197", "Q65_S198", "Q65_S199", "Q65_S200", "Q65_S201", "Q66_S202", "Q66_S203", "Q66_S204", "Q66_S205", "Q66_S206", "Q66_S207", "Q66_S208", "Q66_S209", "Q66_S210", "Q67", "Q68_S211", "Q68_S212", "Q68_S213", "Q68_S214", "Q68_S215", "Q68_S216", "Q68_S217", "Q68_S218", "Q68_S219", "Q69_S220", "Q69_S221", "Q69_S222", "Q69_S223", "Q69_S224", "Q69_S225", "Q69_S226", "Q69_S227", "Q69_S228", "Q70", "Q71_S229", "Q71_S230", "Q71_S231", "Q71_S232", "Q71_S233", "Q71_S234", "Q71_S235", "Q71_S236", "Q71_S237", "Q72_S238", "Q72_S239", "Q72_S240", "Q72_S241", "Q72_S242", "Q72_S243", "Q72_S244", "Q72_S245", "Q72_S246", "Q73", "Q74_S247", "Q74_S248", "Q74_S249", "Q74_S250", "Q74_S251", "Q74_S252", "Q74_S253", "Q74_S254", "Q74_S255", "Q75_S256", "Q75_S257", "Q75_S258", "Q75_S259", "Q75_S260", "Q75_S261", "Q75_S262", "Q75_S263", "Q75_S264", "Q76", "Q77_S265", "Q77_S266", "Q77_S267", "Q77_S268", "Q77_S269", "Q77_S270", "Q77_S271", "Q77_S272", "Q77_S273", "Q78_S274", "Q78_S275", "Q78_S276", "Q78_S277", "Q78_S278", "Q78_S279", "Q78_S280", "Q78_S281", "Q78_S282", "Q79", "Q80_S283", "Q80_S284", "Q80_S285", "Q80_S286", "Q80_S287", "Q80_S288", "Q80_S289", "Q80_S290", "Q80_S291", "Q81_S292", "Q81_S293", "Q81_S294", "Q81_S295", "Q81_S296", "Q81_S297", "Q81_S298", "Q81_S299", "Q81_S300", "Q82", "Q83_S301", "Q83_S302", "Q83_S303", "Q83_S304", "Q83_S305", "Q83_S306", "Q83_S307", "Q83_S308", "Q83_S309", "Q84_S310", "Q84_S311", "Q84_S312", "Q84_S313", "Q84_S314", "Q84_S315", "Q84_S316", "Q84_S317", "Q84_S318", "Q85", "Q86_S319", "Q86_S320", "Q86_S321", "Q86_S322", "Q86_S323", "Q86_S324", "Q86_S325", "Q86_S326", "Q86_S327", "Q87_S328", "Q87_S329", "Q87_S330", "Q87_S331", "Q87_S332", "Q87_S333", "Q87_S334", "Q87_S335", "Q87_S336", "Q88", "Q89_S337", "Q89_S338", "Q89_S339", "Q89_S340", "Q89_S341", "Q89_S342", "Q89_S343", "Q89_S344", "Q89_S345", "Q90_S346", "Q90_S347", "Q90_S348", "Q90_S349", "Q90_S350", "Q90_S351", "Q90_S352", "Q90_S353", "Q90_S354", "Q91_S355", "Q91_S356", "Q91_S357", "Q91_S358", "Q91_S359", "Q91_S360", "Q91_S361", "Q91_S362", "Q91_S363", "Q91_S364", "Q91_S365", "Q91_S366", "Q91_S367", "Q91_S368", "Q92_S369", "Q92_S370", "Q92_S371", "Q92_S372", "Q92_S373", "Q92_S374", "Q92_S375", "Q92_S376", "Q92_S377", "Q92_S378", "Q92_S379", "Q92_S380", "Q92_S381", "Q92_S382", "Q93", "Q94", "Q95", "Q96") FROM stdin;
2	2cRNHHBa1o6UsVt	1980-01-01 00:00:00	18	en	362070854	\N	R002	CAD		FED	E3		Y	Y			N	\N	ANON	Y		H	R2	R3	R3	R1	R1	R0	R3	R1	R0	Comentário de teste R002 A01									M	R1	R1	R3	R0	R0	R2	R3	R0	R0	Comentário de teste R002 A02									M	R1	R2	R0	R0	R3	R0	R0	R3	R2	Comentário de teste R002 A03									M	R2	R3	R3	R1	R2	R1	R3	R1	R3	Comentário de teste R002 A04									H	R3	R3	R2	R0	R1	R3	R0	R1	R2	Comentário de teste R002 A05									H	R1	R2	R1	R2	R1	R3	R1	R0	R3	Comentário de teste R002 A06									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	M	R1	R1	R3	R3	R2	R3	R1	R2	R2	Comentário de teste R002 A08									H	R2	R0	R2	R3	R3	R0	R3	R2	R2	Comentário de teste R002 A09									H	R0	R1	R0	R0	R2	R2	R0	R1	R2	Comentário de teste R002 A10									M	R3	R2	R3	R1	R3	R2	R0	R2	R0	Comentário de teste R002 A11									M	R3	R0	R2	R0	R0	R2	R0	R1	R0	Comentário de teste R002 A12									M	R0	R3	R0	R2	R3	R2	R1	R0	R1	Comentário de teste R002 A13									H	R1	R2	R0	R1	R1	R2	R2	R1	R2	Comentário de teste R002 A14									N	U	U	Y	N	N	\N	Y	N	Y	Y	Y	U	U	Efeito jurídico (teste).						\N									Distâncias de cobertura isotrópicas (teste).		
1	tQZCVEC3eAU8ClI	1980-01-01 00:00:00	18	pt-BR	1254928362	\N	R001	RS		FED	E3		Y	Y			N	\N	PUBL	Y		H	R0	R0	R1	R0	R2	R0	R0	R1	R3	Comentário de teste R001 A01									M	R2	R2	R2	R3	R0	R0	R3	R3	R3	Comentário de teste R001 A02									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	M	R0	R1	R0	R2	R2	R3	R1	R0	R1	Comentário de teste R001 A04									M	R1	R0	R2	R0	R2	R2	R1	R2	R1	Comentário de teste R001 A05									M	R1	R1	R1	R3	R1	R1	R3	R2	R0	Comentário de teste R001 A06									H	R2	R3	R2	R1	R2	R3	R2	R2	R0	Comentário de teste R001 A07									M	R0	R1	R3	R1	R2	R1	R3	R0	R3	Comentário de teste R001 A08									M	R0	R0	R3	R1	R3	R1	R3	R2	R0	Comentário de teste R001 A09									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	H	R1	R1	R1	R0	R1	R3	R1	R3	R2	Comentário de teste R001 A13									M	R1	R0	R0	R0	R1	R3	R1	R1	R0	Comentário de teste R001 A14									N	Y	\N	N	U	Y	U	N	N	\N	\N	\N	U	N	Efeito jurídico (teste).		\N							\N	\N	\N				Distâncias de cobertura isotrópicas (teste).		
3	mCUFpYSlXfpzsDQ	1980-01-01 00:00:00	18	pt-BR	2091416747	\N	R003	HEM		FED	E3		Y	Y			N	\N	NAMED	Y		M	R3	R1	R3	R0	R3	R3	R3	R2	R1	Comentário de teste R003 A01									M	R2	R1	R1	R3	R2	R0	R1	R0	R0	Comentário de teste R003 A02									M	R3	R1	R0	R0	R3	R2	R1	R2	R0	Comentário de teste R003 A03									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	M	R1	R2	R3	R0	R2	R2	R2	R2	R1	Comentário de teste R003 A05									H	R2	R1	R2	R1	R0	R2	R3	R0	R3	Comentário de teste R003 A06									M	R1	R1	R0	R0	R2	R0	R1	R3	R0	Comentário de teste R003 A07									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	H	R2	R2	R1	R0	R1	R3	R2	R3	R1	Comentário de teste R003 A09									M	R1	R0	R3	R1	R0	R1	R0	R0	R0	Comentário de teste R003 A10									M	R2	R0	R3	R3	R0	R0	R1	R3	R2	Comentário de teste R003 A11									H	R3	R0	R0	R0	R3	R2	R0	R2	R1	Comentário de teste R003 A12									M	R1	R3	R3	R3	R0	R3	R2	R0	R1	Comentário de teste R003 A13									H	R1	R2	R2	R2	R1	R0	R3	R0	R3	Comentário de teste R003 A14									N	U	Y	\N	U	Y	U	\N	N	N	U	U	N	N	Efeito jurídico (teste).			\N				\N								Distâncias de cobertura isotrópicas (teste).		
5	pP7ReIZ9X10hvnO	1980-01-01 00:00:00	18	pt-BR	1570734247	\N	R005	RS		FED	E3		Y	Y			N	\N	ANON	Y		L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	M	R2	R3	R3	R0	R1	R1	R0	R1	R3	Comentário de teste R005 A02									M	R3	R2	R3	R3	R1	R1	R1	R0	R1	Comentário de teste R005 A03									M	R0	R2	R1	R2	R2	R1	R0	R3	R3	Comentário de teste R005 A04									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	M	R3	R2	R2	R0	R3	R2	R2	R1	R1	Comentário de teste R005 A06									H	R2	R1	R3	R3	R3	R3	R2	R0	R1	Comentário de teste R005 A07									H	R3	R3	R3	R0	R0	R3	R3	R3	R1	Comentário de teste R005 A08									H	R1	R1	R1	R0	R3	R0	R0	R0	R1	Comentário de teste R005 A09									M	R0	R2	R1	R2	R3	R0	R0	R0	R2	Comentário de teste R005 A10									M	R3	R2	R1	R0	R0	R2	R3	R2	R2	Comentário de teste R005 A11									M	R3	R1	R1	R0	R3	R2	R0	R0	R1	Comentário de teste R005 A12									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Y	N	Y	\N	U	N	N	Y	N	Y	U	\N	\N	\N	Efeito jurídico (teste).			\N								\N	\N		Distâncias de cobertura isotrópicas (teste).		
4	6c9SqufWZVTmXaC	1980-01-01 00:00:00	18	en	1458910953	\N	R004	-oth-	Defesa civil	FED	E3		Y	Y			N	\N	ANON	Y		L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	H	R1	R2	R0	R3	R0	R2	R3	R0	R3	Comentário de teste R004 A02									M	R3	R1	R1	R0	R0	R1	R2	R2	R1	Comentário de teste R004 A03									M	R0	R2	R1	R3	R3	R3	R0	R1	R0	Comentário de teste R004 A04									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	M	R1	R3	R2	R3	R2	R0	R2	R0	R2	Comentário de teste R004 A08									M	R3	R0	R1	R0	R2	R2	R2	R0	R3	Comentário de teste R004 A09									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	H	R2	R3	R2	R0	R2	R0	R0	R2	R1	Comentário de teste R004 A11									M	R2	R3	R2	R1	R2	R3	R0	R3	R1	Comentário de teste R004 A12									H	R0	R3	R3	R1	R2	R3	R0	R1	R1	Comentário de teste R004 A13									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	N	N	\N	\N	\N	N	N	\N	U	U	U	\N	\N	Efeito jurídico (teste).			\N	\N	\N			\N				\N		Distâncias de cobertura isotrópicas (teste).		
6	F7yjWIogHTLvBla	1980-01-01 00:00:00	18	en	1252523226	\N	R006	RS		FED	E3		Y	Y			N	\N	PUBL	Y		L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	M	R3	R1	R0	R2	R0	R1	R3	R1	R2	Comentário de teste R006 A02									M	R1	R3	R1	R2	R2	R0	R3	R1	R1	Comentário de teste R006 A03									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	H	R1	R3	R0	R1	R0	R1	R3	R0	R0	Comentário de teste R006 A06									M	R3	R3	R2	R0	R0	R1	R2	R1	R1	Comentário de teste R006 A07									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	H	R2	R3	R2	R2	R3	R1	R0	R0	R0	Comentário de teste R006 A09									M	R0	R2	R3	R0	R1	R3	R2	R2	R3	Comentário de teste R006 A10									H	R0	R3	R1	R2	R3	R1	R2	R2	R3	Comentário de teste R006 A11									H	R3	R1	R3	R0	R3	R0	R3	R0	R0	Comentário de teste R006 A12									M	R1	R0	R2	R2	R2	R2	R0	R2	R2	Comentário de teste R006 A13									M	R2	R0	R0	R0	R1	R0	R3	R3	R3	Comentário de teste R006 A14									\N	N	N	\N	\N	N	Y	\N	N	Y	Y	U	N	U	\N	Efeito jurídico (teste).		\N	\N			\N								Distâncias de cobertura isotrópicas (teste).		
\.


--
-- Data for Name: lime_tokens_100101; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lime_tokens_100101 (tid, participant_id, firstname, lastname, email, emailstatus, token, language, blacklisted, sent, remindersent, remindercount, completed, usesleft, validfrom, validuntil, mpid, attribute_1, attribute_2) FROM stdin;
6	\N	Fabio	Melo	fabio@example.org	OK	xSH4UOUG2bB0TRx	en	\N	N	N	0	N	1	\N	\N	\N	R006	Instituto Melo
1	\N	Ana	Silva	ana@example.org	OK	ED3ZIubiLCxB4yB	pt-BR	\N	N	N	0	2026-10-20 10:52	0	\N	\N	\N	R001	Instituto Silva
2	\N	Bruno	Costa	bruno@example.org	OK	HN46hazmpQIlagb	en	\N	N	N	0	2026-10-20 10:52	0	\N	\N	\N	R002	Instituto Costa
3	\N	Carla	Souza	carla@example.org	OK	6kWLfgkERRmjMnP	pt-BR	\N	N	N	0	2026-10-20 10:52	0	\N	\N	\N	R003	Instituto Souza
4	\N	Davi	Lima	davi@example.org	OK	XuGsjN4cjTe5gDa	en	\N	N	N	0	2026-10-20 10:52	0	\N	\N	\N	R004	Instituto Lima
5	\N	Eva	Rocha	eva@example.org	OK	sUDocIcwulnrNzt	pt-BR	\N	N	N	0	2026-10-20 10:52	0	\N	\N	\N	R005	Instituto Rocha
\.


--
-- Data for Name: lime_tokens_100102; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lime_tokens_100102 (tid, participant_id, firstname, lastname, email, emailstatus, token, language, blacklisted, sent, remindersent, remindercount, completed, usesleft, validfrom, validuntil, mpid, attribute_1, attribute_2) FROM stdin;
1	\N	Ana	Silva	ana@example.org	OK	tQZCVEC3eAU8ClI	pt-BR	\N	N	N	0	2026-10-20 10:53	0	\N	\N	\N	R001	Instituto Silva
2	\N	Bruno	Costa	bruno@example.org	OK	2cRNHHBa1o6UsVt	en	\N	N	N	0	2026-10-20 10:53	0	\N	\N	\N	R002	Instituto Costa
3	\N	Carla	Souza	carla@example.org	OK	mCUFpYSlXfpzsDQ	pt-BR	\N	N	N	0	2026-10-20 10:54	0	\N	\N	\N	R003	Instituto Souza
4	\N	Davi	Lima	davi@example.org	OK	6c9SqufWZVTmXaC	en	\N	N	N	0	2026-10-20 10:54	0	\N	\N	\N	R004	Instituto Lima
5	\N	Eva	Rocha	eva@example.org	OK	pP7ReIZ9X10hvnO	pt-BR	\N	N	N	0	2026-10-20 10:54	0	\N	\N	\N	R005	Instituto Rocha
6	\N	Fabio	Melo	fabio@example.org	OK	F7yjWIogHTLvBla	en	\N	N	N	0	2026-10-20 10:55	0	\N	\N	\N	R006	Instituto Melo
\.


--
-- Name: lime_questions_qid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lime_questions_qid_seq', 382, true);


--
-- Name: lime_responses_100101_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lime_responses_100101_id_seq', 5, true);


--
-- Name: lime_responses_100102_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lime_responses_100102_id_seq', 6, true);


--
-- Name: lime_tokens_100101_tid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lime_tokens_100101_tid_seq', 6, true);


--
-- Name: lime_tokens_100102_tid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lime_tokens_100102_tid_seq', 6, true);


--
-- Name: lime_questions lime_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_questions
    ADD CONSTRAINT lime_questions_pkey PRIMARY KEY (qid);


--
-- Name: lime_responses_100101 lime_responses_100101_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_responses_100101
    ADD CONSTRAINT lime_responses_100101_pkey PRIMARY KEY (id);


--
-- Name: lime_responses_100102 lime_responses_100102_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_responses_100102
    ADD CONSTRAINT lime_responses_100102_pkey PRIMARY KEY (id);


--
-- Name: lime_tokens_100101 lime_tokens_100101_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_tokens_100101
    ADD CONSTRAINT lime_tokens_100101_pkey PRIMARY KEY (tid);


--
-- Name: lime_tokens_100102 lime_tokens_100102_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_tokens_100102
    ADD CONSTRAINT lime_tokens_100102_pkey PRIMARY KEY (tid);


--
-- Name: idx_email_100101_49036; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_100101_49036 ON public.lime_tokens_100101 USING btree (email);


--
-- Name: idx_email_100102_44648; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_100102_44648 ON public.lime_tokens_100102 USING btree (email);


--
-- Name: idx_survey_token_100101_7711; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_survey_token_100101_7711 ON public.lime_responses_100101 USING btree (token);


--
-- Name: idx_survey_token_100102_7436; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_survey_token_100102_7436 ON public.lime_responses_100102 USING btree (token);


--
-- Name: idx_token_token_100101_48000; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_token_token_100101_48000 ON public.lime_tokens_100101 USING btree (token);


--
-- Name: idx_token_token_100102_27089; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_token_token_100102_27089 ON public.lime_tokens_100102 USING btree (token);


--
-- Name: lime_idx1_questions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lime_idx1_questions ON public.lime_questions USING btree (sid);


--
-- Name: lime_idx2_questions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lime_idx2_questions ON public.lime_questions USING btree (gid);


--
-- Name: lime_idx3_questions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lime_idx3_questions ON public.lime_questions USING btree (type);


--
-- Name: lime_idx4_questions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lime_idx4_questions ON public.lime_questions USING btree (title);


--
-- Name: lime_idx5_questions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lime_idx5_questions ON public.lime_questions USING btree (parent_qid);


--
-- PostgreSQL database dump complete
--

\unrestrict IgsrOtXCUG3naagMhKaVwAcRNOVFc06oWRHRmgZrzzdsv5VkhNqvx0dnKbw9643

