--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1 (Debian 15.1-1.pgdg110+1)

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

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: movies; Type: TABLE; Schema: public; Owner: greenlight
--

CREATE TABLE public.movies (
    id bigint NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    title text NOT NULL,
    year integer NOT NULL,
    runtime integer NOT NULL,
    genres text[] NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    CONSTRAINT genres_length_check CHECK (((array_length(genres, 1) >= 1) AND (array_length(genres, 1) <= 5))),
    CONSTRAINT movies_runtime_check CHECK ((runtime >= 0)),
    CONSTRAINT movies_year_check CHECK (((year >= 1888) AND ((year)::double precision <= date_part('year'::text, now()))))
);


ALTER TABLE public.movies OWNER TO greenlight;

--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: greenlight
--

CREATE SEQUENCE public.movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movies_id_seq OWNER TO greenlight;

--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: greenlight
--

ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: greenlight
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    dirty boolean NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO greenlight;

--
-- Name: users; Type: TABLE; Schema: public; Owner: greenlight
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    email public.citext NOT NULL,
    password_hash bytea NOT NULL,
    activated boolean NOT NULL,
    version integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.users OWNER TO greenlight;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: greenlight
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO greenlight;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: greenlight
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: greenlight
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: greenlight
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: greenlight
--

COPY public.movies (id, created_at, title, year, runtime, genres, version) FROM stdin;
1	2023-01-25 15:09:19+00	Moana	2016	107	{animation,adventure}	1
3	2023-01-25 15:09:34+00	Deadpool	2016	108	{action,comedy}	1
4	2023-01-25 15:09:41+00	The Breakfast Club	1986	96	{drama}	1
2	2023-01-25 15:09:27+00	Black Panther	2018	134	{sci-fi,action,adventure}	2
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: greenlight
--

COPY public.schema_migrations (version, dirty) FROM stdin;
4	f
3	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: greenlight
--

COPY public.users (id, created_at, name, email, password_hash, activated, version) FROM stdin;
1	2023-01-28 05:49:25+00	Alice Smith	alice@example.com	\\x243261243132245a336d69766d325a79564e61652e3258355832525a4f30444e4c74714f57506149326c516d7353317166576b5570376f627950484f	f	1
5	2023-01-28 08:06:40+00	Bob Jones	bob@example.com	\\x243261243132244864666975432e2f68633942414a707770756857614f4932425271426b466e32762e52494f535a2f344f37787a784f2f41516c6b71	f	1
8	2023-01-28 08:26:09+00	Bob Bobs	bobby@example.com	\\x24326124313224355361502e39494e2e64346b446a4f562e4d553153657776357253304561544e6e6b6278393979556674365278424671684a464d79	f	1
9	2023-01-28 08:28:18+00	Sponge Bob	sponge@example.com	\\x24326124313224767176453855534c6c46502e335a754d4655323051756c317a67306c434241416e5438585a72464563366a3378346e707a65547471	f	1
10	2023-01-28 08:40:39+00	Squidward	squid@example.com	\\x2432612431322450726963384c644971777a78327143694a325866472e6546673174534e7a765035707070585249576f463648674b49372e5a6c344f	f	1
11	2023-01-28 08:48:21+00	Yers	yers@example.com	\\x243261243132245165522f545063694d2e68426447737178743365744f734f36526168675a50437a64496e495658624c7a6f4d4f334c77495a792e4f	f	1
12	2023-01-28 08:54:58+00	Agu	agu@example.com	\\x243261243132244e6262565654426e4b325276396568546830646e432e6a6c654f6252757177736c5545417445496c536f312f643957755968725361	f	1
13	2023-01-28 08:56:07+00	pidor	nepidor@example.com	\\x24326124313224687038444d6f53516c2f31704a79554b622f2f7964757947446f334d2f41536264775a5a6e7971634169576e536b364b3178744c36	f	1
14	2023-01-28 09:01:53+00	nepidor	pidor@example.com	\\x243261243132244f4c70597950734f587a697356536276655249426e75732e44457835374b7779484a384f4d734c55786f744364776568616b476471	f	1
15	2023-01-28 09:03:58+00	nepidor1	pidor1@example.com	\\x2432612431322478723742515355553661497a394e574d6549684f6e4f367831325250455078526f584550637368734e4a34424d5a6d4b3470517779	f	1
16	2023-01-28 09:04:40+00	nepidor2	pidor2@example.com	\\x24326124313224414b496942553769762f3765626673433570434379754179704345324662635138694f35666857534d4370354678473633677a7647	f	1
17	2023-01-28 09:08:22+00	nepidor3	pidor3@example.com	\\x243261243132246c4b3030346845455077754b6576414e612f5236477542654352306a467945332f697a6f5174345a6e6c43326c5864762f37472e4f	f	1
18	2023-01-28 09:15:18+00	nepidor4	pidor4@example.com	\\x243261243132246e78774e4b67734842317230555a5a766834756f4375626b6234684d42343846733745516149507877636e326b754d333179754f61	f	1
19	2023-01-29 08:12:45+00	Juicy Jones	juicy@example.com	\\x24326124313224535065387537724d79616c43394f726a544949564a2e70777576544f7565324f6f4261442f75506d425a764a7746416d6b54653371	f	1
20	2023-01-29 08:14:16+00	Samanta Jones	samanta@example.com	\\x243261243132242f2e2e364848644e5838652f4d5736305331465830657070454a646f564f635a41506631796c5761636d6c7454543738336a4e7071	f	1
\.


--
-- Name: movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: greenlight
--

SELECT pg_catalog.setval('public.movies_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: greenlight
--

SELECT pg_catalog.setval('public.users_id_seq', 20, true);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: greenlight
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: greenlight
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: greenlight
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: greenlight
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: movies_genres_idx; Type: INDEX; Schema: public; Owner: greenlight
--

CREATE INDEX movies_genres_idx ON public.movies USING gin (genres);


--
-- Name: movies_title_idx; Type: INDEX; Schema: public; Owner: greenlight
--

CREATE INDEX movies_title_idx ON public.movies USING gin (to_tsvector('simple'::regconfig, title));


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT CREATE ON SCHEMA public TO greenlight;


--
-- PostgreSQL database dump complete
--

