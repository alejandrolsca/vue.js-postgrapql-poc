--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgraphql_watch; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA postgraphql_watch;


ALTER SCHEMA postgraphql_watch OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = postgraphql_watch, pg_catalog;

--
-- Name: notify_watchers(); Type: FUNCTION; Schema: postgraphql_watch; Owner: postgres
--

CREATE FUNCTION notify_watchers() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$ begin perform pg_notify( 'postgraphql_watch', (select array_to_json(array_agg(x)) from (select schema_name as schema, command_tag as command from pg_event_trigger_ddl_commands()) as x)::text ); end; $$;


ALTER FUNCTION postgraphql_watch.notify_watchers() OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- Name: pr_id_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pr_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pr_id_sequence OWNER TO postgres;

--
-- Name: SEQUENCE pr_id_sequence; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON SEQUENCE pr_id_sequence IS 'Product ID Sequence';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE product (
    pr_id bigint DEFAULT nextval('pr_id_sequence'::regclass) NOT NULL,
    pr_jsonb jsonb,
    pr_createddate timestamp without time zone DEFAULT now() NOT NULL,
    pr_updatedate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE product OWNER TO postgres;

--
-- Name: search_products(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION search_products() RETURNS SETOF product
    LANGUAGE sql STABLE
    AS $$  select *
  from public.product
  where pr_jsonb->>'pr_status' = 'A'
  order by pr_id desc
$$;


ALTER FUNCTION public.search_products() OWNER TO postgres;

--
-- Name: compliance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE compliance (
    id bigint NOT NULL,
    co_jsonb jsonb NOT NULL
);


ALTER TABLE compliance OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "user" (
    id bigint NOT NULL,
    us_jsonb jsonb NOT NULL
);


ALTER TABLE "user" OWNER TO postgres;

--
-- Data for Name: compliance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY compliance (id, co_jsonb) FROM stdin;
1	{"id": 1, "Nombre": "my-other-name"}
2	{"id": 2, "Nombre": "my-other-name"}
3	{"id": 3, "Nombre": "my-other-name"}
\.


--
-- Name: pr_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pr_id_sequence', 463, true);


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY product (pr_id, pr_jsonb, pr_createddate, pr_updatedate) FROM stdin;
32	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:10:15.301254	2017-01-31 15:10:15.301254
31	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:10:13.262452	2017-01-31 15:10:13.262452
23	{"pr_name": "Product 23", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-25 15:11:56.821122	2017-01-25 15:11:56.821122
22	{"pr_name": "Product 22", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-25 14:43:22.436153	2017-01-25 14:43:22.436153
21	{"pr_name": "Product 21", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-25 14:16:02.732153	2017-01-25 14:16:02.732153
18	{"pr_name": "null", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-24 18:36:30.068248	2017-01-24 18:36:30.068248
16	{"pr_name": "Product 9", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-24 18:09:50.868298	2017-01-24 18:09:50.868298
14	{"pr_name": "Product 7", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-24 17:47:15.064298	2017-01-24 17:47:15.064298
17	{"pr_name": "null", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-24 18:33:20.256268	2017-01-24 18:33:20.256268
20	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-25 11:18:10.690153	2017-01-25 11:18:10.690153
12	{"pr_name": "Product 6", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-24 17:38:11.421298	2017-01-24 17:38:11.421298
13	{"pr_name": "Product 7", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-24 17:45:57.346298	2017-01-24 17:45:57.346298
9	{"pr_name": "Product 5", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product 5"}	2017-01-03 13:10:17.368217	2017-01-03 13:10:17.368217
24	{"pr_name": "TEST", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-25 16:05:04.137822	2017-01-25 16:05:04.137822
10	{"pr_name": "Product 5", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product 5"}	2017-01-03 13:18:50.772217	2017-01-03 13:18:50.772217
26	{"pr_name": "Test", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-27 10:00:40.095179	2017-01-27 10:00:40.095179
15	{"pr_name": "Product 8", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-24 18:08:04.040298	2017-01-24 18:08:04.040298
30	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:10:09.170065	2017-01-31 15:10:09.170065
28	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-30 14:27:11.962057	2017-01-30 14:27:11.962057
29	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:09:57.297184	2017-01-31 15:09:57.297184
53	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:16.640723	2017-01-31 15:19:16.640723
54	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:16.839743	2017-01-31 15:19:16.839743
52	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:16.370696	2017-01-31 15:19:16.370696
51	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:16.131672	2017-01-31 15:19:16.131672
50	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:15.895648	2017-01-31 15:19:15.895648
49	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:15.650624	2017-01-31 15:19:15.650624
48	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:15.398599	2017-01-31 15:19:15.398599
47	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:15.184577	2017-01-31 15:19:15.184577
46	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:14.91255	2017-01-31 15:19:14.91255
45	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:14.638523	2017-01-31 15:19:14.638523
44	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:14.406499	2017-01-31 15:19:14.406499
43	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:14.137472	2017-01-31 15:19:14.137472
42	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:13.903449	2017-01-31 15:19:13.903449
41	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:13.653424	2017-01-31 15:19:13.653424
40	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:13.31539	2017-01-31 15:19:13.31539
38	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:12.377296	2017-01-31 15:19:12.377296
37	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:12.293288	2017-01-31 15:19:12.293288
36	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:10:25.017416	2017-01-31 15:10:25.017416
35	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:10:24.522366	2017-01-31 15:10:24.522366
34	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:10:23.875302	2017-01-31 15:10:23.875302
33	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:10:23.235238	2017-01-31 15:10:23.235238
27	{"pr_name": "Test Product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-27 10:08:37.552179	2017-01-27 10:08:37.552179
25	{"pr_name": "TEST 2", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-25 16:05:43.003708	2017-01-25 16:05:43.003708
8	{"pr_name": "Product 4", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product 4"}	2017-01-03 13:10:09.461217	2017-01-03 13:10:09.461217
7	{"pr_name": "Product 3", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product 3"}	2017-01-03 13:10:02.464217	2017-01-03 13:10:02.464217
6	{"pr_name": "Product 2", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product 2"}	2017-01-03 13:09:51.024217	2017-01-03 13:09:51.024217
5	{"pr_name": "Product 1", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product 1"}	2017-01-03 13:09:37.649217	2017-01-03 13:09:37.649217
89	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:22.654324	2017-01-31 15:19:22.654324
88	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:22.601319	2017-01-31 15:19:22.601319
87	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:22.362295	2017-01-31 15:19:22.362295
86	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:22.240283	2017-01-31 15:19:22.240283
85	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:22.089268	2017-01-31 15:19:22.089268
84	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:21.920251	2017-01-31 15:19:21.920251
83	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:21.845243	2017-01-31 15:19:21.845243
82	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:21.656224	2017-01-31 15:19:21.656224
81	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:21.481207	2017-01-31 15:19:21.481207
80	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:21.306189	2017-01-31 15:19:21.306189
79	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:21.160175	2017-01-31 15:19:21.160175
78	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:21.007159	2017-01-31 15:19:21.007159
77	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:20.91015	2017-01-31 15:19:20.91015
76	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:20.741133	2017-01-31 15:19:20.741133
75	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:20.595118	2017-01-31 15:19:20.595118
74	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:20.397098	2017-01-31 15:19:20.397098
73	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:20.137072	2017-01-31 15:19:20.137072
72	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:19.990058	2017-01-31 15:19:19.990058
71	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:19.871046	2017-01-31 15:19:19.871046
70	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:19.71103	2017-01-31 15:19:19.71103
69	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:19.564015	2017-01-31 15:19:19.564015
68	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:19.496008	2017-01-31 15:19:19.496008
67	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:19.303989	2017-01-31 15:19:19.303989
66	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:19.094968	2017-01-31 15:19:19.094968
65	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:18.884947	2017-01-31 15:19:18.884947
64	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:18.740933	2017-01-31 15:19:18.740933
63	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:18.618921	2017-01-31 15:19:18.618921
62	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:18.464905	2017-01-31 15:19:18.464905
61	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:18.271886	2017-01-31 15:19:18.271886
60	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:18.11587	2017-01-31 15:19:18.11587
59	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:17.90985	2017-01-31 15:19:17.90985
58	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:17.720831	2017-01-31 15:19:17.720831
57	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:17.582817	2017-01-31 15:19:17.582817
56	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:17.374796	2017-01-31 15:19:17.374796
55	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:17.100769	2017-01-31 15:19:17.100769
39	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:19:12.893348	2017-01-31 15:19:12.893348
93	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:40.299216	2017-01-31 15:22:40.299216
92	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:39.703157	2017-01-31 15:22:39.703157
91	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:22.127173	2017-01-31 15:22:22.127173
90	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:22.112171	2017-01-31 15:22:22.112171
100	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:48.471829	2017-01-31 15:22:48.471829
99	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:48.001782	2017-01-31 15:22:48.001782
98	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:47.486731	2017-01-31 15:22:47.486731
97	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:47.069689	2017-01-31 15:22:47.069689
96	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:46.671649	2017-01-31 15:22:46.671649
95	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:46.170599	2017-01-31 15:22:46.170599
94	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:45.656548	2017-01-31 15:22:45.656548
103	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:51.025676	2017-01-31 15:22:51.025676
102	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:50.805654	2017-01-31 15:22:50.805654
101	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:48.790861	2017-01-31 15:22:48.790861
105	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:56.319395	2017-01-31 15:22:56.319395
104	{"pr_name": "Tes product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:22:56.117375	2017-01-31 15:22:56.117375
110	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:20.11229	2017-01-31 15:26:20.11229
109	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:19.667246	2017-01-31 15:26:19.667246
108	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:19.115191	2017-01-31 15:26:19.115191
107	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:18.563135	2017-01-31 15:26:18.563135
106	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:17.870468	2017-01-31 15:26:17.870468
124	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:27.134788	2017-01-31 15:26:27.134788
123	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:26.417716	2017-01-31 15:26:26.417716
122	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:24.943773	2017-01-31 15:26:24.943773
121	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:24.766756	2017-01-31 15:26:24.766756
120	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:24.641743	2017-01-31 15:26:24.641743
119	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:24.486728	2017-01-31 15:26:24.486728
118	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:24.371716	2017-01-31 15:26:24.371716
117	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:24.216701	2017-01-31 15:26:24.216701
116	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:24.054684	2017-01-31 15:26:24.054684
115	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:23.933672	2017-01-31 15:26:23.933672
146	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:36.097881	2017-01-31 15:26:36.097881
145	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:35.962868	2017-01-31 15:26:35.962868
144	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:35.794851	2017-01-31 15:26:35.794851
142	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:35.511823	2017-01-31 15:26:35.511823
143	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:35.666838	2017-01-31 15:26:35.666838
141	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:35.363808	2017-01-31 15:26:35.363808
140	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:35.217793	2017-01-31 15:26:35.217793
139	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:35.075779	2017-01-31 15:26:35.075779
138	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:34.935765	2017-01-31 15:26:34.935765
137	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:34.803752	2017-01-31 15:26:34.803752
136	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:34.643736	2017-01-31 15:26:34.643736
135	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:34.508722	2017-01-31 15:26:34.508722
134	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:34.344706	2017-01-31 15:26:34.344706
133	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:34.243696	2017-01-31 15:26:34.243696
132	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:34.066678	2017-01-31 15:26:34.066678
131	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:33.940666	2017-01-31 15:26:33.940666
130	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:33.793651	2017-01-31 15:26:33.793651
129	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:33.636635	2017-01-31 15:26:33.636635
128	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:33.48162	2017-01-31 15:26:33.48162
127	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:33.332605	2017-01-31 15:26:33.332605
126	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:33.170589	2017-01-31 15:26:33.170589
125	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:33.030575	2017-01-31 15:26:33.030575
147	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:45.960252	2017-01-31 16:44:45.960252
114	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:23.81066	2017-01-31 15:26:23.81066
113	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:23.658645	2017-01-31 15:26:23.658645
112	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:23.474626	2017-01-31 15:26:23.474626
111	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 15:26:23.295609	2017-01-31 15:26:23.295609
196	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:53.694752	2017-01-31 16:44:53.694752
195	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:53.589752	2017-01-31 16:44:53.589752
194	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:53.346752	2017-01-31 16:44:53.346752
193	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:53.173252	2017-01-31 16:44:53.173252
192	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:53.003252	2017-01-31 16:44:53.003252
191	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:52.848252	2017-01-31 16:44:52.848252
190	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:52.636752	2017-01-31 16:44:52.636752
189	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:52.470252	2017-01-31 16:44:52.470252
188	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:52.320752	2017-01-31 16:44:52.320752
187	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:51.897752	2017-01-31 16:44:51.897752
186	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:51.708252	2017-01-31 16:44:51.708252
185	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:51.566752	2017-01-31 16:44:51.566752
184	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:51.381752	2017-01-31 16:44:51.381752
183	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:51.230752	2017-01-31 16:44:51.230752
182	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:51.030752	2017-01-31 16:44:51.030752
181	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:50.877752	2017-01-31 16:44:50.877752
180	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:50.706752	2017-01-31 16:44:50.706752
179	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:50.513752	2017-01-31 16:44:50.513752
178	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:50.348752	2017-01-31 16:44:50.348752
177	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:50.185752	2017-01-31 16:44:50.185752
176	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:50.050252	2017-01-31 16:44:50.050252
175	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:49.877752	2017-01-31 16:44:49.877752
174	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:49.733752	2017-01-31 16:44:49.733752
173	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:49.585752	2017-01-31 16:44:49.585752
172	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:49.425752	2017-01-31 16:44:49.425752
171	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:49.252752	2017-01-31 16:44:49.252752
170	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:49.114252	2017-01-31 16:44:49.114252
169	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:48.972752	2017-01-31 16:44:48.972752
168	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:48.832252	2017-01-31 16:44:48.832252
167	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:48.664252	2017-01-31 16:44:48.664252
166	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:48.514752	2017-01-31 16:44:48.514752
165	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:48.442752	2017-01-31 16:44:48.442752
164	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:48.241752	2017-01-31 16:44:48.241752
162	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:48.027252	2017-01-31 16:44:48.027252
161	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:47.848752	2017-01-31 16:44:47.848752
160	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:47.728252	2017-01-31 16:44:47.728252
159	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:47.630252	2017-01-31 16:44:47.630252
158	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:47.437752	2017-01-31 16:44:47.437752
157	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:47.359752	2017-01-31 16:44:47.359752
156	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:47.196752	2017-01-31 16:44:47.196752
155	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:47.049252	2017-01-31 16:44:47.049252
154	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:46.787252	2017-01-31 16:44:46.787252
153	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:46.636752	2017-01-31 16:44:46.636752
152	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:46.470752	2017-01-31 16:44:46.470752
151	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:46.201752	2017-01-31 16:44:46.201752
150	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:46.061752	2017-01-31 16:44:46.061752
149	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:46.012252	2017-01-31 16:44:46.012252
202	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:54.748252	2017-01-31 16:44:54.748252
200	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:54.427752	2017-01-31 16:44:54.427752
198	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:54.079752	2017-01-31 16:44:54.079752
201	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:54.626752	2017-01-31 16:44:54.626752
199	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:54.297252	2017-01-31 16:44:54.297252
197	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:53.949752	2017-01-31 16:44:53.949752
163	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:48.122252	2017-01-31 16:44:48.122252
148	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:44:45.994252	2017-01-31 16:44:45.994252
203	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "A", "pr_description": "Test Product"}	2017-01-31 16:45:24.350152	2017-01-31 16:45:24.350152
204	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "A", "pr_description": "Test Product"}	2017-01-31 16:45:24.483652	2017-01-31 16:45:24.483652
244	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:10.570958	2017-02-03 17:38:10.570958
245	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:10.783958	2017-02-03 17:38:10.783958
240	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:09.752958	2017-02-03 17:38:09.752958
243	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:10.337958	2017-02-03 17:38:10.337958
242	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:10.141958	2017-02-03 17:38:10.141958
241	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:09.966958	2017-02-03 17:38:09.966958
238	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:09.545958	2017-02-03 17:38:09.545958
239	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:09.650958	2017-02-03 17:38:09.650958
236	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:09.169958	2017-02-03 17:38:09.169958
237	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:09.302958	2017-02-03 17:38:09.302958
235	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:08.976958	2017-02-03 17:38:08.976958
234	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:08.849958	2017-02-03 17:38:08.849958
233	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:08.666958	2017-02-03 17:38:08.666958
232	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:08.513958	2017-02-03 17:38:08.513958
230	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:08.238958	2017-02-03 17:38:08.238958
231	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:08.360958	2017-02-03 17:38:08.360958
228	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:07.835958	2017-02-03 17:38:07.835958
229	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:08.049958	2017-02-03 17:38:08.049958
227	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:07.619958	2017-02-03 17:38:07.619958
226	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:07.258958	2017-02-03 17:38:07.258958
225	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:07.028958	2017-02-03 17:38:07.028958
224	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:06.829958	2017-02-03 17:38:06.829958
223	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:06.821958	2017-02-03 17:38:06.821958
222	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:06.785958	2017-02-03 17:38:06.785958
221	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:26.949652	2017-01-31 16:45:26.949652
220	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:26.785152	2017-01-31 16:45:26.785152
219	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:26.663152	2017-01-31 16:45:26.663152
218	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:26.508652	2017-01-31 16:45:26.508652
217	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:26.358152	2017-01-31 16:45:26.358152
216	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:26.215652	2017-01-31 16:45:26.215652
215	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:26.073652	2017-01-31 16:45:26.073652
213	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:25.794652	2017-01-31 16:45:25.794652
212	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:25.680652	2017-01-31 16:45:25.680652
211	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:25.517152	2017-01-31 16:45:25.517152
210	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:25.394152	2017-01-31 16:45:25.394152
209	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:25.263652	2017-01-31 16:45:25.263652
208	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:25.100152	2017-01-31 16:45:25.100152
207	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:24.925152	2017-01-31 16:45:24.925152
206	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:24.770152	2017-01-31 16:45:24.770152
205	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:24.640152	2017-01-31 16:45:24.640152
297	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:19.994958	2017-02-03 17:38:19.994958
290	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:18.810958	2017-02-03 17:38:18.810958
296	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:19.747958	2017-02-03 17:38:19.747958
300	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:20.529958	2017-02-03 17:38:20.529958
286	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:18.126958	2017-02-03 17:38:18.126958
285	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:17.952958	2017-02-03 17:38:17.952958
283	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:17.764958	2017-02-03 17:38:17.764958
293	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:19.314958	2017-02-03 17:38:19.314958
279	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:17.195958	2017-02-03 17:38:17.195958
278	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:17.050958	2017-02-03 17:38:17.050958
277	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:16.715958	2017-02-03 17:38:16.715958
265	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:14.636958	2017-02-03 17:38:14.636958
276	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:16.489958	2017-02-03 17:38:16.489958
273	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:15.911958	2017-02-03 17:38:15.911958
275	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:16.270958	2017-02-03 17:38:16.270958
269	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:15.213958	2017-02-03 17:38:15.213958
272	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:15.728958	2017-02-03 17:38:15.728958
271	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:15.539958	2017-02-03 17:38:15.539958
264	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:14.151958	2017-02-03 17:38:14.151958
270	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:15.408958	2017-02-03 17:38:15.408958
268	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:15.025958	2017-02-03 17:38:15.025958
262	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:13.788958	2017-02-03 17:38:13.788958
267	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:14.844958	2017-02-03 17:38:14.844958
263	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:13.953958	2017-02-03 17:38:13.953958
258	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:13.083958	2017-02-03 17:38:13.083958
257	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:12.798958	2017-02-03 17:38:12.798958
261	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:13.642958	2017-02-03 17:38:13.642958
260	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:13.448958	2017-02-03 17:38:13.448958
256	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:12.594958	2017-02-03 17:38:12.594958
259	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:13.251958	2017-02-03 17:38:13.251958
255	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:12.419958	2017-02-03 17:38:12.419958
254	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:12.248958	2017-02-03 17:38:12.248958
253	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:12.062958	2017-02-03 17:38:12.062958
250	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:11.539958	2017-02-03 17:38:11.539958
252	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:11.868958	2017-02-03 17:38:11.868958
249	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:11.368958	2017-02-03 17:38:11.368958
251	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:11.691958	2017-02-03 17:38:11.691958
247	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:11.011958	2017-02-03 17:38:11.011958
248	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:11.194958	2017-02-03 17:38:11.194958
299	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:20.330958	2017-02-03 17:38:20.330958
298	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:20.132958	2017-02-03 17:38:20.132958
295	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:19.634958	2017-02-03 17:38:19.634958
294	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:19.470958	2017-02-03 17:38:19.470958
292	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:19.152958	2017-02-03 17:38:19.152958
291	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:18.998958	2017-02-03 17:38:18.998958
289	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:18.621958	2017-02-03 17:38:18.621958
288	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:18.519958	2017-02-03 17:38:18.519958
287	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:18.348958	2017-02-03 17:38:18.348958
284	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:17.872958	2017-02-03 17:38:17.872958
282	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:17.538958	2017-02-03 17:38:17.538958
281	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:17.342958	2017-02-03 17:38:17.342958
280	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:17.213958	2017-02-03 17:38:17.213958
274	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:16.173958	2017-02-03 17:38:16.173958
266	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:14.652958	2017-02-03 17:38:14.652958
246	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-03 17:38:10.922958	2017-02-03 17:38:10.922958
332	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:56.827373	2017-02-17 17:13:56.827373
331	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:56.676358	2017-02-17 17:13:56.676358
330	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:56.472337	2017-02-17 17:13:56.472337
329	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:56.326323	2017-02-17 17:13:56.326323
328	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:56.187309	2017-02-17 17:13:56.187309
327	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:56.028293	2017-02-17 17:13:56.028293
326	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:55.866277	2017-02-17 17:13:55.866277
325	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:55.749265	2017-02-17 17:13:55.749265
324	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:55.576248	2017-02-17 17:13:55.576248
323	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:55.570247	2017-02-17 17:13:55.570247
322	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:55.390229	2017-02-17 17:13:55.390229
321	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:55.253215	2017-02-17 17:13:55.253215
320	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:54.970187	2017-02-17 17:13:54.970187
319	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:54.954185	2017-02-17 17:13:54.954185
318	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:54.893179	2017-02-17 17:13:54.893179
317	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:54.416132	2017-02-17 17:13:54.416132
314	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:53.985088	2017-02-17 17:13:53.985088
316	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:54.256116	2017-02-17 17:13:54.256116
313	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:53.787069	2017-02-17 17:13:53.787069
312	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:53.657056	2017-02-17 17:13:53.657056
311	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:53.506041	2017-02-17 17:13:53.506041
310	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:53.357026	2017-02-17 17:13:53.357026
309	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:53.237014	2017-02-17 17:13:53.237014
308	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:53.071997	2017-02-17 17:13:53.071997
307	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:52.929983	2017-02-17 17:13:52.929983
306	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:52.764966	2017-02-17 17:13:52.764966
305	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:52.59995	2017-02-17 17:13:52.59995
304	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:52.445935	2017-02-17 17:13:52.445935
303	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:52.158906	2017-02-17 17:13:52.158906
302	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:52.017892	2017-02-17 17:13:52.017892
301	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:51.974887	2017-02-17 17:13:51.974887
344	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:58.681558	2017-02-17 17:13:58.681558
342	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:58.357526	2017-02-17 17:13:58.357526
340	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:58.065496	2017-02-17 17:13:58.065496
338	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:57.759466	2017-02-17 17:13:57.759466
336	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:57.456436	2017-02-17 17:13:57.456436
334	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:57.152405	2017-02-17 17:13:57.152405
333	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:57.013391	2017-02-17 17:13:57.013391
214	{"pr_name": "Test product", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-01-31 16:45:25.972652	2017-01-31 16:45:25.972652
396	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:55.317221	2017-02-17 17:14:55.317221
392	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:54.957185	2017-02-17 17:14:54.957185
390	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:54.314121	2017-02-17 17:14:54.314121
384	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:53.230012	2017-02-17 17:14:53.230012
388	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:53.962086	2017-02-17 17:14:53.962086
386	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:53.635053	2017-02-17 17:14:53.635053
382	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:52.964986	2017-02-17 17:14:52.964986
380	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:52.758965	2017-02-17 17:14:52.758965
378	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:52.158905	2017-02-17 17:14:52.158905
376	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:51.943884	2017-02-17 17:14:51.943884
374	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:51.545844	2017-02-17 17:14:51.545844
372	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:51.261816	2017-02-17 17:14:51.261816
370	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:50.986788	2017-02-17 17:14:50.986788
368	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:50.585748	2017-02-17 17:14:50.585748
366	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:50.328722	2017-02-17 17:14:50.328722
364	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:50.037693	2017-02-17 17:14:50.037693
362	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:49.739663	2017-02-17 17:14:49.739663
360	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:49.464636	2017-02-17 17:14:49.464636
358	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:49.025592	2017-02-17 17:14:49.025592
356	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:48.719561	2017-02-17 17:14:48.719561
354	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:48.427532	2017-02-17 17:14:48.427532
352	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:48.139503	2017-02-17 17:14:48.139503
350	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:47.862476	2017-02-17 17:14:47.862476
348	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:47.549444	2017-02-17 17:14:47.549444
346	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:47.220411	2017-02-17 17:14:47.220411
343	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:58.510541	2017-02-17 17:13:58.510541
341	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:58.214511	2017-02-17 17:13:58.214511
339	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:57.912481	2017-02-17 17:13:57.912481
337	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:57.594449	2017-02-17 17:13:57.594449
335	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:57.292419	2017-02-17 17:13:57.292419
315	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:13:54.1041	2017-02-17 17:13:54.1041
412	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:14.1851	2017-02-17 17:28:14.1851
411	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:13.822064	2017-02-17 17:28:13.822064
410	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:13.811062	2017-02-17 17:28:13.811062
409	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:13.780059	2017-02-17 17:28:13.780059
408	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:57.179407	2017-02-17 17:14:57.179407
407	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:57.038393	2017-02-17 17:14:57.038393
406	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:56.880377	2017-02-17 17:14:56.880377
405	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:56.717361	2017-02-17 17:14:56.717361
404	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:56.560345	2017-02-17 17:14:56.560345
403	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:56.386328	2017-02-17 17:14:56.386328
402	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:56.254315	2017-02-17 17:14:56.254315
401	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:56.064296	2017-02-17 17:14:56.064296
400	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:55.914281	2017-02-17 17:14:55.914281
399	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:55.762266	2017-02-17 17:14:55.762266
398	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:55.638253	2017-02-17 17:14:55.638253
397	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:55.491238	2017-02-17 17:14:55.491238
395	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:55.143204	2017-02-17 17:14:55.143204
394	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:54.974187	2017-02-17 17:14:54.974187
391	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:54.474137	2017-02-17 17:14:54.474137
389	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:54.165106	2017-02-17 17:14:54.165106
387	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:53.838073	2017-02-17 17:14:53.838073
385	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:53.382028	2017-02-17 17:14:53.382028
383	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:53.093999	2017-02-17 17:14:53.093999
381	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:52.819971	2017-02-17 17:14:52.819971
379	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:52.567946	2017-02-17 17:14:52.567946
377	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:52.017891	2017-02-17 17:14:52.017891
375	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:51.70986	2017-02-17 17:14:51.70986
371	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:51.139803	2017-02-17 17:14:51.139803
369	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:50.727762	2017-02-17 17:14:50.727762
367	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:50.458735	2017-02-17 17:14:50.458735
365	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:50.20371	2017-02-17 17:14:50.20371
363	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:49.887678	2017-02-17 17:14:49.887678
361	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:49.60165	2017-02-17 17:14:49.60165
359	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:49.296619	2017-02-17 17:14:49.296619
357	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:48.878577	2017-02-17 17:14:48.878577
355	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:48.579547	2017-02-17 17:14:48.579547
353	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:48.292519	2017-02-17 17:14:48.292519
351	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:48.000489	2017-02-17 17:14:48.000489
349	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:47.70146	2017-02-17 17:14:47.70146
347	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:47.394429	2017-02-17 17:14:47.394429
345	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:47.059395	2017-02-17 17:14:47.059395
441	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:18.895571	2017-02-17 17:28:18.895571
440	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:18.745556	2017-02-17 17:28:18.745556
434	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:17.735455	2017-02-17 17:28:17.735455
433	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:17.573439	2017-02-17 17:28:17.573439
431	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:17.292411	2017-02-17 17:28:17.292411
428	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:16.847366	2017-02-17 17:28:16.847366
425	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:16.322314	2017-02-17 17:28:16.322314
423	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:15.930274	2017-02-17 17:28:15.930274
420	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:15.465228	2017-02-17 17:28:15.465228
419	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:15.270208	2017-02-17 17:28:15.270208
416	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:14.993181	2017-02-17 17:28:14.993181
414	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:14.48413	2017-02-17 17:28:14.48413
413	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:14.318113	2017-02-17 17:28:14.318113
447	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:46.512332	2017-02-17 17:28:46.512332
450	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:49.054586	2017-02-17 17:28:49.054586
455	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "A", "pr_description": "Test Product"}	2017-02-17 17:28:51.78986	2017-02-17 17:28:51.78986
459	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:53.955076	2017-02-17 17:28:53.955076
445	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:19.537635	2017-02-17 17:28:19.537635
442	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:19.049586	2017-02-17 17:28:19.049586
439	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:18.514533	2017-02-17 17:28:18.514533
438	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:18.337515	2017-02-17 17:28:18.337515
436	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:18.097491	2017-02-17 17:28:18.097491
432	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:17.48343	2017-02-17 17:28:17.48343
429	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:16.99038	2017-02-17 17:28:16.99038
426	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:16.509332	2017-02-17 17:28:16.509332
424	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:16.225304	2017-02-17 17:28:16.225304
418	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:15.147196	2017-02-17 17:28:15.147196
415	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:14.973179	2017-02-17 17:28:14.973179
393	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:54.964186	2017-02-17 17:14:54.964186
373	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:14:51.40783	2017-02-17 17:14:51.40783
446	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:46.09429	2017-02-17 17:28:46.09429
452	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:49.414622	2017-02-17 17:28:49.414622
449	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:48.88657	2017-02-17 17:28:48.88657
454	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "A", "pr_description": "Test Product"}	2017-02-17 17:28:51.59484	2017-02-17 17:28:51.59484
457	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:52.145896	2017-02-17 17:28:52.145896
458	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "A", "pr_description": "Test Product"}	2017-02-17 17:28:53.779059	2017-02-17 17:28:53.779059
463	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:56.413322	2017-02-17 17:28:56.413322
460	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:55.508232	2017-02-17 17:28:55.508232
444	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:19.375619	2017-02-17 17:28:19.375619
443	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:19.204602	2017-02-17 17:28:19.204602
437	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:18.269508	2017-02-17 17:28:18.269508
435	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:17.902472	2017-02-17 17:28:17.902472
430	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:17.101391	2017-02-17 17:28:17.101391
427	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:16.594341	2017-02-17 17:28:16.594341
422	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:15.805262	2017-02-17 17:28:15.805262
421	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:15.565238	2017-02-17 17:28:15.565238
417	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:15.000181	2017-02-17 17:28:15.000181
448	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:46.983379	2017-02-17 17:28:46.983379
451	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:49.244605	2017-02-17 17:28:49.244605
453	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "A", "pr_description": "Test Product"}	2017-02-17 17:28:51.415823	2017-02-17 17:28:51.415823
456	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:51.967878	2017-02-17 17:28:51.967878
462	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:56.247306	2017-02-17 17:28:56.247306
461	{"pr_name": "asdasdasdasd", "pr_price": 9.99, "pr_status": "I", "pr_description": "Test Product"}	2017-02-17 17:28:55.521233	2017-02-17 17:28:55.521233
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "user" (id, us_jsonb) FROM stdin;
1	{"id": 1, "Read": true, "Nombre": "Carlos"}
2	{"id": 2, "Read": true, "Nombre": "Alfredo"}
\.


--
-- Name: product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (pr_id);


--
-- Name: compliance compliance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY compliance
    ADD CONSTRAINT compliance_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: postgraphql_watch; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER postgraphql_watch ON ddl_command_end
         WHEN TAG IN ('ALTER DOMAIN', 'ALTER FOREIGN TABLE', 'ALTER FUNCTION', 'ALTER SCHEMA', 'ALTER TABLE', 'ALTER TYPE', 'ALTER VIEW', 'COMMENT', 'CREATE DOMAIN', 'CREATE FOREIGN TABLE', 'CREATE FUNCTION', 'CREATE SCHEMA', 'CREATE TABLE', 'CREATE TABLE AS', 'CREATE VIEW', 'DROP DOMAIN', 'DROP FOREIGN TABLE', 'DROP FUNCTION', 'DROP SCHEMA', 'DROP TABLE', 'DROP VIEW', 'GRANT', 'REVOKE', 'SELECT INTO')
   EXECUTE PROCEDURE postgraphql_watch.notify_watchers();


--
-- PostgreSQL database dump complete
--

