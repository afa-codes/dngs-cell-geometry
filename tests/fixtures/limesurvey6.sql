--
-- PostgreSQL database dump
--

\restrict R3hTmomeMUbGZaRbk4wqhMgsVLNGezRMLp5UwOiS6IRx2GTqRFtZzhiPocZzJWc


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
-- Name: lime_survey_100101; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lime_survey_100101 (
    id integer NOT NULL,
    token character varying(36),
    submitdate timestamp without time zone,
    lastpage integer,
    startlanguage character varying(20) NOT NULL,
    seed character varying(31),
    "100101X1X1" text,
    "100101X1X2" character varying(5),
    "100101X1X2other" text,
    "100101X1X3" character varying(5),
    "100101X1X4" character varying(5),
    "100101X1X5ISO" character varying(5),
    "100101X1X5HEX" character varying(5),
    "100101X1X5QUAD" character varying(5),
    "100101X1X5TRI" character varying(5),
    "100101X1X5SFC" character varying(5),
    "100101X1X5NONE" character varying(5),
    "100101X1X6" character varying(5),
    "100101X1X7" text,
    "100101X1X8" character varying(5),
    "100101X1X9ok" character varying(5),
    "100101X2X10" character varying(1),
    "100101X3X11" character varying(1),
    "100101X3X12P1b_square" text,
    "100101X3X12P1b_triangle" text,
    "100101X3X12P1b_hexagon" text,
    "100101X3X12P2_square" text,
    "100101X3X12P2_triangle" text,
    "100101X3X12P2_hexagon" text,
    "100101X3X12P3_square" text,
    "100101X3X12P3_triangle" text,
    "100101X3X12P3_hexagon" text,
    "100101X3X12P4_square" text,
    "100101X3X12P4_triangle" text,
    "100101X3X12P4_hexagon" text,
    "100101X3X12P8_square" text,
    "100101X3X12P8_triangle" text,
    "100101X3X12P8_hexagon" text,
    "100101X3X13P1b" text,
    "100101X3X13P2" text,
    "100101X3X13P3" text,
    "100101X3X13P4" text,
    "100101X3X13P8" text,
    "100101X4X14" character varying(1),
    "100101X4X15" text,
    "100101X5X16" text,
    "100101X5X17" text,
    "100101X5X18" text
);


--
-- Name: lime_survey_100101_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lime_survey_100101_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lime_survey_100101_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lime_survey_100101_id_seq OWNED BY public.lime_survey_100101.id;


--
-- Name: lime_survey_100102; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lime_survey_100102 (
    id integer NOT NULL,
    token character varying(36),
    submitdate timestamp without time zone,
    lastpage integer,
    startlanguage character varying(20) NOT NULL,
    seed character varying(31),
    "100102X6X39" text,
    "100102X6X40" character varying(5),
    "100102X6X40other" text,
    "100102X6X41" character varying(5),
    "100102X6X42" character varying(5),
    "100102X6X43STAT" character varying(5),
    "100102X6X43HEX" character varying(5),
    "100102X6X43QUAD" character varying(5),
    "100102X6X43GEOC" character varying(5),
    "100102X6X43NONE" character varying(5),
    "100102X6X44" character varying(5),
    "100102X6X45" text,
    "100102X6X46" character varying(5),
    "100102X6X47ok" character varying(5),
    "100102X7X48" character varying(1),
    "100102X8X49" character varying(5),
    "100102X8X50P1a" character varying(5),
    "100102X8X50P1b" character varying(5),
    "100102X8X50P2" character varying(5),
    "100102X8X50P3" character varying(5),
    "100102X8X50P4" character varying(5),
    "100102X8X50P5" character varying(5),
    "100102X8X50P6" character varying(5),
    "100102X8X50P7" character varying(5),
    "100102X8X50P8" character varying(5),
    "100102X8X51P1a" text,
    "100102X8X51P1b" text,
    "100102X8X51P2" text,
    "100102X8X51P3" text,
    "100102X8X51P4" text,
    "100102X8X51P5" text,
    "100102X8X51P6" text,
    "100102X8X51P7" text,
    "100102X8X51P8" text,
    "100102X9X52" character varying(5),
    "100102X9X53P1a" character varying(5),
    "100102X9X53P1b" character varying(5),
    "100102X9X53P2" character varying(5),
    "100102X9X53P3" character varying(5),
    "100102X9X53P4" character varying(5),
    "100102X9X53P5" character varying(5),
    "100102X9X53P6" character varying(5),
    "100102X9X53P7" character varying(5),
    "100102X9X53P8" character varying(5),
    "100102X9X54P1a" text,
    "100102X9X54P1b" text,
    "100102X9X54P2" text,
    "100102X9X54P3" text,
    "100102X9X54P4" text,
    "100102X9X54P5" text,
    "100102X9X54P6" text,
    "100102X9X54P7" text,
    "100102X9X54P8" text,
    "100102X10X55" character varying(5),
    "100102X10X56P1a" character varying(5),
    "100102X10X56P1b" character varying(5),
    "100102X10X56P2" character varying(5),
    "100102X10X56P3" character varying(5),
    "100102X10X56P4" character varying(5),
    "100102X10X56P5" character varying(5),
    "100102X10X56P6" character varying(5),
    "100102X10X56P7" character varying(5),
    "100102X10X56P8" character varying(5),
    "100102X10X57P1a" text,
    "100102X10X57P1b" text,
    "100102X10X57P2" text,
    "100102X10X57P3" text,
    "100102X10X57P4" text,
    "100102X10X57P5" text,
    "100102X10X57P6" text,
    "100102X10X57P7" text,
    "100102X10X57P8" text,
    "100102X11X58" character varying(5),
    "100102X11X59P1a" character varying(5),
    "100102X11X59P1b" character varying(5),
    "100102X11X59P2" character varying(5),
    "100102X11X59P3" character varying(5),
    "100102X11X59P4" character varying(5),
    "100102X11X59P5" character varying(5),
    "100102X11X59P6" character varying(5),
    "100102X11X59P7" character varying(5),
    "100102X11X59P8" character varying(5),
    "100102X11X60P1a" text,
    "100102X11X60P1b" text,
    "100102X11X60P2" text,
    "100102X11X60P3" text,
    "100102X11X60P4" text,
    "100102X11X60P5" text,
    "100102X11X60P6" text,
    "100102X11X60P7" text,
    "100102X11X60P8" text,
    "100102X12X61" character varying(5),
    "100102X12X62P1a" character varying(5),
    "100102X12X62P1b" character varying(5),
    "100102X12X62P2" character varying(5),
    "100102X12X62P3" character varying(5),
    "100102X12X62P4" character varying(5),
    "100102X12X62P5" character varying(5),
    "100102X12X62P6" character varying(5),
    "100102X12X62P7" character varying(5),
    "100102X12X62P8" character varying(5),
    "100102X12X63P1a" text,
    "100102X12X63P1b" text,
    "100102X12X63P2" text,
    "100102X12X63P3" text,
    "100102X12X63P4" text,
    "100102X12X63P5" text,
    "100102X12X63P6" text,
    "100102X12X63P7" text,
    "100102X12X63P8" text,
    "100102X13X64" character varying(5),
    "100102X13X65P1a" character varying(5),
    "100102X13X65P1b" character varying(5),
    "100102X13X65P2" character varying(5),
    "100102X13X65P3" character varying(5),
    "100102X13X65P4" character varying(5),
    "100102X13X65P5" character varying(5),
    "100102X13X65P6" character varying(5),
    "100102X13X65P7" character varying(5),
    "100102X13X65P8" character varying(5),
    "100102X13X66P1a" text,
    "100102X13X66P1b" text,
    "100102X13X66P2" text,
    "100102X13X66P3" text,
    "100102X13X66P4" text,
    "100102X13X66P5" text,
    "100102X13X66P6" text,
    "100102X13X66P7" text,
    "100102X13X66P8" text,
    "100102X14X67" character varying(5),
    "100102X14X68P1a" character varying(5),
    "100102X14X68P1b" character varying(5),
    "100102X14X68P2" character varying(5),
    "100102X14X68P3" character varying(5),
    "100102X14X68P4" character varying(5),
    "100102X14X68P5" character varying(5),
    "100102X14X68P6" character varying(5),
    "100102X14X68P7" character varying(5),
    "100102X14X68P8" character varying(5),
    "100102X14X69P1a" text,
    "100102X14X69P1b" text,
    "100102X14X69P2" text,
    "100102X14X69P3" text,
    "100102X14X69P4" text,
    "100102X14X69P5" text,
    "100102X14X69P6" text,
    "100102X14X69P7" text,
    "100102X14X69P8" text,
    "100102X15X70" character varying(5),
    "100102X15X71P1a" character varying(5),
    "100102X15X71P1b" character varying(5),
    "100102X15X71P2" character varying(5),
    "100102X15X71P3" character varying(5),
    "100102X15X71P4" character varying(5),
    "100102X15X71P5" character varying(5),
    "100102X15X71P6" character varying(5),
    "100102X15X71P7" character varying(5),
    "100102X15X71P8" character varying(5),
    "100102X15X72P1a" text,
    "100102X15X72P1b" text,
    "100102X15X72P2" text,
    "100102X15X72P3" text,
    "100102X15X72P4" text,
    "100102X15X72P5" text,
    "100102X15X72P6" text,
    "100102X15X72P7" text,
    "100102X15X72P8" text,
    "100102X16X73" character varying(5),
    "100102X16X74P1a" character varying(5),
    "100102X16X74P1b" character varying(5),
    "100102X16X74P2" character varying(5),
    "100102X16X74P3" character varying(5),
    "100102X16X74P4" character varying(5),
    "100102X16X74P5" character varying(5),
    "100102X16X74P6" character varying(5),
    "100102X16X74P7" character varying(5),
    "100102X16X74P8" character varying(5),
    "100102X16X75P1a" text,
    "100102X16X75P1b" text,
    "100102X16X75P2" text,
    "100102X16X75P3" text,
    "100102X16X75P4" text,
    "100102X16X75P5" text,
    "100102X16X75P6" text,
    "100102X16X75P7" text,
    "100102X16X75P8" text,
    "100102X17X76" character varying(5),
    "100102X17X77P1a" character varying(5),
    "100102X17X77P1b" character varying(5),
    "100102X17X77P2" character varying(5),
    "100102X17X77P3" character varying(5),
    "100102X17X77P4" character varying(5),
    "100102X17X77P5" character varying(5),
    "100102X17X77P6" character varying(5),
    "100102X17X77P7" character varying(5),
    "100102X17X77P8" character varying(5),
    "100102X17X78P1a" text,
    "100102X17X78P1b" text,
    "100102X17X78P2" text,
    "100102X17X78P3" text,
    "100102X17X78P4" text,
    "100102X17X78P5" text,
    "100102X17X78P6" text,
    "100102X17X78P7" text,
    "100102X17X78P8" text,
    "100102X18X79" character varying(5),
    "100102X18X80P1a" character varying(5),
    "100102X18X80P1b" character varying(5),
    "100102X18X80P2" character varying(5),
    "100102X18X80P3" character varying(5),
    "100102X18X80P4" character varying(5),
    "100102X18X80P5" character varying(5),
    "100102X18X80P6" character varying(5),
    "100102X18X80P7" character varying(5),
    "100102X18X80P8" character varying(5),
    "100102X18X81P1a" text,
    "100102X18X81P1b" text,
    "100102X18X81P2" text,
    "100102X18X81P3" text,
    "100102X18X81P4" text,
    "100102X18X81P5" text,
    "100102X18X81P6" text,
    "100102X18X81P7" text,
    "100102X18X81P8" text,
    "100102X19X82" character varying(5),
    "100102X19X83P1a" character varying(5),
    "100102X19X83P1b" character varying(5),
    "100102X19X83P2" character varying(5),
    "100102X19X83P3" character varying(5),
    "100102X19X83P4" character varying(5),
    "100102X19X83P5" character varying(5),
    "100102X19X83P6" character varying(5),
    "100102X19X83P7" character varying(5),
    "100102X19X83P8" character varying(5),
    "100102X19X84P1a" text,
    "100102X19X84P1b" text,
    "100102X19X84P2" text,
    "100102X19X84P3" text,
    "100102X19X84P4" text,
    "100102X19X84P5" text,
    "100102X19X84P6" text,
    "100102X19X84P7" text,
    "100102X19X84P8" text,
    "100102X20X85" character varying(5),
    "100102X20X86P1a" character varying(5),
    "100102X20X86P1b" character varying(5),
    "100102X20X86P2" character varying(5),
    "100102X20X86P3" character varying(5),
    "100102X20X86P4" character varying(5),
    "100102X20X86P5" character varying(5),
    "100102X20X86P6" character varying(5),
    "100102X20X86P7" character varying(5),
    "100102X20X86P8" character varying(5),
    "100102X20X87P1a" text,
    "100102X20X87P1b" text,
    "100102X20X87P2" text,
    "100102X20X87P3" text,
    "100102X20X87P4" text,
    "100102X20X87P5" text,
    "100102X20X87P6" text,
    "100102X20X87P7" text,
    "100102X20X87P8" text,
    "100102X21X88" character varying(5),
    "100102X21X89P1a" character varying(5),
    "100102X21X89P1b" character varying(5),
    "100102X21X89P2" character varying(5),
    "100102X21X89P3" character varying(5),
    "100102X21X89P4" character varying(5),
    "100102X21X89P5" character varying(5),
    "100102X21X89P6" character varying(5),
    "100102X21X89P7" character varying(5),
    "100102X21X89P8" character varying(5),
    "100102X21X90P1a" text,
    "100102X21X90P1b" text,
    "100102X21X90P2" text,
    "100102X21X90P3" text,
    "100102X21X90P4" text,
    "100102X21X90P5" text,
    "100102X21X90P6" text,
    "100102X21X90P7" text,
    "100102X21X90P8" text,
    "100102X22X91A01" character varying(5),
    "100102X22X91A02" character varying(5),
    "100102X22X91A03" character varying(5),
    "100102X22X91A04" character varying(5),
    "100102X22X91A05" character varying(5),
    "100102X22X91A06" character varying(5),
    "100102X22X91A07" character varying(5),
    "100102X22X91A08" character varying(5),
    "100102X22X91A09" character varying(5),
    "100102X22X91A10" character varying(5),
    "100102X22X91A11" character varying(5),
    "100102X22X91A12" character varying(5),
    "100102X22X91A13" character varying(5),
    "100102X22X91A14" character varying(5),
    "100102X22X92A01" text,
    "100102X22X92A02" text,
    "100102X22X92A03" text,
    "100102X22X92A04" text,
    "100102X22X92A05" text,
    "100102X22X92A06" text,
    "100102X22X92A07" text,
    "100102X22X92A08" text,
    "100102X22X92A09" text,
    "100102X22X92A10" text,
    "100102X22X92A11" text,
    "100102X22X92A12" text,
    "100102X22X92A13" text,
    "100102X22X92A14" text,
    "100102X23X93" text,
    "100102X23X94" text,
    "100102X23X95" text,
    "100102X23X96" text
);


--
-- Name: lime_survey_100102_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lime_survey_100102_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lime_survey_100102_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lime_survey_100102_id_seq OWNED BY public.lime_survey_100102.id;


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
-- Name: lime_survey_100101 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_survey_100101 ALTER COLUMN id SET DEFAULT nextval('public.lime_survey_100101_id_seq'::regclass);


--
-- Name: lime_survey_100102 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_survey_100102 ALTER COLUMN id SET DEFAULT nextval('public.lime_survey_100102_id_seq'::regclass);


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
-- Data for Name: lime_survey_100101; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lime_survey_100101 (id, token, submitdate, lastpage, startlanguage, seed, "100101X1X1", "100101X1X2", "100101X1X2other", "100101X1X3", "100101X1X4", "100101X1X5ISO", "100101X1X5HEX", "100101X1X5QUAD", "100101X1X5TRI", "100101X1X5SFC", "100101X1X5NONE", "100101X1X6", "100101X1X7", "100101X1X8", "100101X1X9ok", "100101X2X10", "100101X3X11", "100101X3X12P1b_square", "100101X3X12P1b_triangle", "100101X3X12P1b_hexagon", "100101X3X12P2_square", "100101X3X12P2_triangle", "100101X3X12P2_hexagon", "100101X3X12P3_square", "100101X3X12P3_triangle", "100101X3X12P3_hexagon", "100101X3X12P4_square", "100101X3X12P4_triangle", "100101X3X12P4_hexagon", "100101X3X12P8_square", "100101X3X12P8_triangle", "100101X3X12P8_hexagon", "100101X3X13P1b", "100101X3X13P2", "100101X3X13P3", "100101X3X13P4", "100101X3X13P8", "100101X4X14", "100101X4X15", "100101X5X16", "100101X5X17", "100101X5X18") FROM stdin;
1	Kp6V3Lv5vx5RC07	1980-01-01 00:00:00	5	pt-BR	1550348478	R001	CGE		UNI	E3		Y	Y				Y	Consultoria para empresa de geocodificação (teste).	PUBL	Y			0.2	1	1	0		1	0.7	1	0.2	0.2		0	0	1	0				Justificativa de teste para P4.			Objeção de teste à nota P7 do triângulo.		Propriedade proposta: isotropia de distâncias (teste).	
\.


--
-- Data for Name: lime_survey_100102; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lime_survey_100102 (id, token, submitdate, lastpage, startlanguage, seed, "100102X6X39", "100102X6X40", "100102X6X40other", "100102X6X41", "100102X6X42", "100102X6X43STAT", "100102X6X43HEX", "100102X6X43QUAD", "100102X6X43GEOC", "100102X6X43NONE", "100102X6X44", "100102X6X45", "100102X6X46", "100102X6X47ok", "100102X7X48", "100102X8X49", "100102X8X50P1a", "100102X8X50P1b", "100102X8X50P2", "100102X8X50P3", "100102X8X50P4", "100102X8X50P5", "100102X8X50P6", "100102X8X50P7", "100102X8X50P8", "100102X8X51P1a", "100102X8X51P1b", "100102X8X51P2", "100102X8X51P3", "100102X8X51P4", "100102X8X51P5", "100102X8X51P6", "100102X8X51P7", "100102X8X51P8", "100102X9X52", "100102X9X53P1a", "100102X9X53P1b", "100102X9X53P2", "100102X9X53P3", "100102X9X53P4", "100102X9X53P5", "100102X9X53P6", "100102X9X53P7", "100102X9X53P8", "100102X9X54P1a", "100102X9X54P1b", "100102X9X54P2", "100102X9X54P3", "100102X9X54P4", "100102X9X54P5", "100102X9X54P6", "100102X9X54P7", "100102X9X54P8", "100102X10X55", "100102X10X56P1a", "100102X10X56P1b", "100102X10X56P2", "100102X10X56P3", "100102X10X56P4", "100102X10X56P5", "100102X10X56P6", "100102X10X56P7", "100102X10X56P8", "100102X10X57P1a", "100102X10X57P1b", "100102X10X57P2", "100102X10X57P3", "100102X10X57P4", "100102X10X57P5", "100102X10X57P6", "100102X10X57P7", "100102X10X57P8", "100102X11X58", "100102X11X59P1a", "100102X11X59P1b", "100102X11X59P2", "100102X11X59P3", "100102X11X59P4", "100102X11X59P5", "100102X11X59P6", "100102X11X59P7", "100102X11X59P8", "100102X11X60P1a", "100102X11X60P1b", "100102X11X60P2", "100102X11X60P3", "100102X11X60P4", "100102X11X60P5", "100102X11X60P6", "100102X11X60P7", "100102X11X60P8", "100102X12X61", "100102X12X62P1a", "100102X12X62P1b", "100102X12X62P2", "100102X12X62P3", "100102X12X62P4", "100102X12X62P5", "100102X12X62P6", "100102X12X62P7", "100102X12X62P8", "100102X12X63P1a", "100102X12X63P1b", "100102X12X63P2", "100102X12X63P3", "100102X12X63P4", "100102X12X63P5", "100102X12X63P6", "100102X12X63P7", "100102X12X63P8", "100102X13X64", "100102X13X65P1a", "100102X13X65P1b", "100102X13X65P2", "100102X13X65P3", "100102X13X65P4", "100102X13X65P5", "100102X13X65P6", "100102X13X65P7", "100102X13X65P8", "100102X13X66P1a", "100102X13X66P1b", "100102X13X66P2", "100102X13X66P3", "100102X13X66P4", "100102X13X66P5", "100102X13X66P6", "100102X13X66P7", "100102X13X66P8", "100102X14X67", "100102X14X68P1a", "100102X14X68P1b", "100102X14X68P2", "100102X14X68P3", "100102X14X68P4", "100102X14X68P5", "100102X14X68P6", "100102X14X68P7", "100102X14X68P8", "100102X14X69P1a", "100102X14X69P1b", "100102X14X69P2", "100102X14X69P3", "100102X14X69P4", "100102X14X69P5", "100102X14X69P6", "100102X14X69P7", "100102X14X69P8", "100102X15X70", "100102X15X71P1a", "100102X15X71P1b", "100102X15X71P2", "100102X15X71P3", "100102X15X71P4", "100102X15X71P5", "100102X15X71P6", "100102X15X71P7", "100102X15X71P8", "100102X15X72P1a", "100102X15X72P1b", "100102X15X72P2", "100102X15X72P3", "100102X15X72P4", "100102X15X72P5", "100102X15X72P6", "100102X15X72P7", "100102X15X72P8", "100102X16X73", "100102X16X74P1a", "100102X16X74P1b", "100102X16X74P2", "100102X16X74P3", "100102X16X74P4", "100102X16X74P5", "100102X16X74P6", "100102X16X74P7", "100102X16X74P8", "100102X16X75P1a", "100102X16X75P1b", "100102X16X75P2", "100102X16X75P3", "100102X16X75P4", "100102X16X75P5", "100102X16X75P6", "100102X16X75P7", "100102X16X75P8", "100102X17X76", "100102X17X77P1a", "100102X17X77P1b", "100102X17X77P2", "100102X17X77P3", "100102X17X77P4", "100102X17X77P5", "100102X17X77P6", "100102X17X77P7", "100102X17X77P8", "100102X17X78P1a", "100102X17X78P1b", "100102X17X78P2", "100102X17X78P3", "100102X17X78P4", "100102X17X78P5", "100102X17X78P6", "100102X17X78P7", "100102X17X78P8", "100102X18X79", "100102X18X80P1a", "100102X18X80P1b", "100102X18X80P2", "100102X18X80P3", "100102X18X80P4", "100102X18X80P5", "100102X18X80P6", "100102X18X80P7", "100102X18X80P8", "100102X18X81P1a", "100102X18X81P1b", "100102X18X81P2", "100102X18X81P3", "100102X18X81P4", "100102X18X81P5", "100102X18X81P6", "100102X18X81P7", "100102X18X81P8", "100102X19X82", "100102X19X83P1a", "100102X19X83P1b", "100102X19X83P2", "100102X19X83P3", "100102X19X83P4", "100102X19X83P5", "100102X19X83P6", "100102X19X83P7", "100102X19X83P8", "100102X19X84P1a", "100102X19X84P1b", "100102X19X84P2", "100102X19X84P3", "100102X19X84P4", "100102X19X84P5", "100102X19X84P6", "100102X19X84P7", "100102X19X84P8", "100102X20X85", "100102X20X86P1a", "100102X20X86P1b", "100102X20X86P2", "100102X20X86P3", "100102X20X86P4", "100102X20X86P5", "100102X20X86P6", "100102X20X86P7", "100102X20X86P8", "100102X20X87P1a", "100102X20X87P1b", "100102X20X87P2", "100102X20X87P3", "100102X20X87P4", "100102X20X87P5", "100102X20X87P6", "100102X20X87P7", "100102X20X87P8", "100102X21X88", "100102X21X89P1a", "100102X21X89P1b", "100102X21X89P2", "100102X21X89P3", "100102X21X89P4", "100102X21X89P5", "100102X21X89P6", "100102X21X89P7", "100102X21X89P8", "100102X21X90P1a", "100102X21X90P1b", "100102X21X90P2", "100102X21X90P3", "100102X21X90P4", "100102X21X90P5", "100102X21X90P6", "100102X21X90P7", "100102X21X90P8", "100102X22X91A01", "100102X22X91A02", "100102X22X91A03", "100102X22X91A04", "100102X22X91A05", "100102X22X91A06", "100102X22X91A07", "100102X22X91A08", "100102X22X91A09", "100102X22X91A10", "100102X22X91A11", "100102X22X91A12", "100102X22X91A13", "100102X22X91A14", "100102X22X92A01", "100102X22X92A02", "100102X22X92A03", "100102X22X92A04", "100102X22X92A05", "100102X22X92A06", "100102X22X92A07", "100102X22X92A08", "100102X22X92A09", "100102X22X92A10", "100102X22X92A11", "100102X22X92A12", "100102X22X92A13", "100102X22X92A14", "100102X23X93", "100102X23X94", "100102X23X95", "100102X23X96") FROM stdin;
1	IhtjTUpIztaIii5	1980-01-01 00:00:00	18	pt-BR	359795358	R001	RS		FED	E3		Y	Y			N	\N	PUBL	Y		L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	M	R2	R0	R0	R1	R3	R1	R2	R3	R2	Comentário de teste R001 A06									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	M	R3	R1	R2	R0	R2	R1	R2	R0	R1	Comentário de teste R001 A09									M	R2	R0	R0	R3	R3	R0	R2	R0	R3	Comentário de teste R001 A10									M	R0	R2	R3	R3	R0	R0	R0	R3	R2	Comentário de teste R001 A11									M	R1	R0	R2	R0	R0	R0	R0	R1	R3	Comentário de teste R001 A12									M	R2	R1	R0	R2	R2	R2	R1	R3	R3	Comentário de teste R001 A13									L	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U	\N	\N	N	U	U	U	U	\N	\N	\N	\N	\N	\N	Efeito jurídico (teste).	\N	\N						\N		Distâncias de cobertura isotrópicas (teste).		
\.


--
-- Data for Name: lime_tokens_100101; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lime_tokens_100101 (tid, participant_id, firstname, lastname, email, emailstatus, token, language, blacklisted, sent, remindersent, remindercount, completed, usesleft, validfrom, validuntil, mpid, attribute_1, attribute_2) FROM stdin;
1	\N	Ana	Silva	a@example.org	OK	Kp6V3Lv5vx5RC07		\N	N	N	0	2026-10-20 10:58	0	\N	\N	\N	R001	X
\.


--
-- Data for Name: lime_tokens_100102; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lime_tokens_100102 (tid, participant_id, firstname, lastname, email, emailstatus, token, language, blacklisted, sent, remindersent, remindercount, completed, usesleft, validfrom, validuntil, mpid, attribute_1, attribute_2) FROM stdin;
1	\N	Ana	Silva	a@example.org	OK	IhtjTUpIztaIii5		\N	N	N	0	2026-10-20 10:58	0	\N	\N	\N	R001	X
\.


--
-- Name: lime_questions_qid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lime_questions_qid_seq', 382, true);


--
-- Name: lime_survey_100101_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lime_survey_100101_id_seq', 1, true);


--
-- Name: lime_survey_100102_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lime_survey_100102_id_seq', 1, true);


--
-- Name: lime_tokens_100101_tid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lime_tokens_100101_tid_seq', 1, true);


--
-- Name: lime_tokens_100102_tid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lime_tokens_100102_tid_seq', 1, true);


--
-- Name: lime_questions lime_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_questions
    ADD CONSTRAINT lime_questions_pkey PRIMARY KEY (qid);


--
-- Name: lime_survey_100101 lime_survey_100101_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_survey_100101
    ADD CONSTRAINT lime_survey_100101_pkey PRIMARY KEY (id);


--
-- Name: lime_survey_100102 lime_survey_100102_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lime_survey_100102
    ADD CONSTRAINT lime_survey_100102_pkey PRIMARY KEY (id);


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
-- Name: idx_email_100101_41890; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_100101_41890 ON public.lime_tokens_100101 USING btree (email);


--
-- Name: idx_email_100102_9602; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_100102_9602 ON public.lime_tokens_100102 USING btree (email);


--
-- Name: idx_survey_token_100101_14500; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_survey_token_100101_14500 ON public.lime_survey_100101 USING btree (token);


--
-- Name: idx_survey_token_100102_45892; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_survey_token_100102_45892 ON public.lime_survey_100102 USING btree (token);


--
-- Name: idx_token_token_100101_4532; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_token_token_100101_4532 ON public.lime_tokens_100101 USING btree (token);


--
-- Name: idx_token_token_100102_40837; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_token_token_100102_40837 ON public.lime_tokens_100102 USING btree (token);


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

\unrestrict R3hTmomeMUbGZaRbk4wqhMgsVLNGezRMLp5UwOiS6IRx2GTqRFtZzhiPocZzJWc

