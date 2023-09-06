--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 14.9 (Homebrew)

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
-- Name: application_pets; Type: TABLE; Schema: public; Owner: williamweston
--

CREATE TABLE public.application_pets (
    id bigint NOT NULL,
    pet_id bigint,
    application_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    app_pet_status character varying
);


ALTER TABLE public.application_pets OWNER TO williamweston;

--
-- Name: application_pets_id_seq; Type: SEQUENCE; Schema: public; Owner: williamweston
--

CREATE SEQUENCE public.application_pets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.application_pets_id_seq OWNER TO williamweston;

--
-- Name: application_pets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: williamweston
--

ALTER SEQUENCE public.application_pets_id_seq OWNED BY public.application_pets.id;


--
-- Name: applications; Type: TABLE; Schema: public; Owner: williamweston
--

CREATE TABLE public.applications (
    id bigint NOT NULL,
    applicant_name character varying,
    full_address character varying,
    description character varying,
    application_status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.applications OWNER TO williamweston;

--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: williamweston
--

CREATE SEQUENCE public.applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.applications_id_seq OWNER TO williamweston;

--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: williamweston
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: williamweston
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO williamweston;

--
-- Name: pets; Type: TABLE; Schema: public; Owner: williamweston
--

CREATE TABLE public.pets (
    id bigint NOT NULL,
    adoptable boolean,
    age integer,
    breed character varying,
    name character varying,
    shelter_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    application_id bigint
);


ALTER TABLE public.pets OWNER TO williamweston;

--
-- Name: pets_id_seq; Type: SEQUENCE; Schema: public; Owner: williamweston
--

CREATE SEQUENCE public.pets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pets_id_seq OWNER TO williamweston;

--
-- Name: pets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: williamweston
--

ALTER SEQUENCE public.pets_id_seq OWNED BY public.pets.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: williamweston
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO williamweston;

--
-- Name: shelters; Type: TABLE; Schema: public; Owner: williamweston
--

CREATE TABLE public.shelters (
    id bigint NOT NULL,
    foster_program boolean,
    name character varying,
    city character varying,
    rank integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.shelters OWNER TO williamweston;

--
-- Name: shelters_id_seq; Type: SEQUENCE; Schema: public; Owner: williamweston
--

CREATE SEQUENCE public.shelters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shelters_id_seq OWNER TO williamweston;

--
-- Name: shelters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: williamweston
--

ALTER SEQUENCE public.shelters_id_seq OWNED BY public.shelters.id;


--
-- Name: veterinarians; Type: TABLE; Schema: public; Owner: williamweston
--

CREATE TABLE public.veterinarians (
    id bigint NOT NULL,
    on_call boolean,
    review_rating integer,
    name character varying,
    veterinary_office_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.veterinarians OWNER TO williamweston;

--
-- Name: veterinarians_id_seq; Type: SEQUENCE; Schema: public; Owner: williamweston
--

CREATE SEQUENCE public.veterinarians_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.veterinarians_id_seq OWNER TO williamweston;

--
-- Name: veterinarians_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: williamweston
--

ALTER SEQUENCE public.veterinarians_id_seq OWNED BY public.veterinarians.id;


--
-- Name: veterinary_offices; Type: TABLE; Schema: public; Owner: williamweston
--

CREATE TABLE public.veterinary_offices (
    id bigint NOT NULL,
    boarding_services boolean,
    max_patient_capacity integer,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.veterinary_offices OWNER TO williamweston;

--
-- Name: veterinary_offices_id_seq; Type: SEQUENCE; Schema: public; Owner: williamweston
--

CREATE SEQUENCE public.veterinary_offices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.veterinary_offices_id_seq OWNER TO williamweston;

--
-- Name: veterinary_offices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: williamweston
--

ALTER SEQUENCE public.veterinary_offices_id_seq OWNED BY public.veterinary_offices.id;


--
-- Name: application_pets id; Type: DEFAULT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.application_pets ALTER COLUMN id SET DEFAULT nextval('public.application_pets_id_seq'::regclass);


--
-- Name: applications id; Type: DEFAULT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- Name: pets id; Type: DEFAULT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.pets ALTER COLUMN id SET DEFAULT nextval('public.pets_id_seq'::regclass);


--
-- Name: shelters id; Type: DEFAULT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.shelters ALTER COLUMN id SET DEFAULT nextval('public.shelters_id_seq'::regclass);


--
-- Name: veterinarians id; Type: DEFAULT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.veterinarians ALTER COLUMN id SET DEFAULT nextval('public.veterinarians_id_seq'::regclass);


--
-- Name: veterinary_offices id; Type: DEFAULT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.veterinary_offices ALTER COLUMN id SET DEFAULT nextval('public.veterinary_offices_id_seq'::regclass);


--
-- Data for Name: application_pets; Type: TABLE DATA; Schema: public; Owner: williamweston
--

COPY public.application_pets (id, pet_id, application_id, created_at, updated_at, app_pet_status) FROM stdin;
5	5	2	2023-09-06 01:39:46.787344	2023-09-06 01:39:46.787344	\N
6	1	2	2023-09-06 01:39:54.29364	2023-09-06 01:49:11.086552	approved
7	3	2	2023-09-06 01:39:58.57259	2023-09-06 01:49:11.091371	approved
4	5	2	2023-09-06 01:39:32.435765	2023-09-06 01:49:11.094124	approved
1	1	1	2023-09-06 01:00:59.4747	2023-09-06 17:06:19.969818	approved
2	2	1	2023-09-06 01:00:59.476506	2023-09-06 17:06:19.977504	approved
3	3	1	2023-09-06 01:00:59.477845	2023-09-06 17:06:19.983508	approved
\.


--
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: williamweston
--

COPY public.applications (id, applicant_name, full_address, description, application_status, created_at, updated_at) FROM stdin;
4	Test West	123 Test Address; Test, Colorado 80829	I would love to help a friend have a new home	In Progress	2023-09-06 01:30:31.179638	2023-09-06 01:30:31.179638
2	Joop Stark	123 Test Address; Test, Colorado 80829	Test for approve all apps	Approved	2023-09-06 01:19:45.25872	2023-09-06 01:49:11.097209
1	Charlie Brown	123 Peanuts Rd, Lansing MI, 48864	Charlie has been looking forward to picking out a friend	Approved	2023-09-06 01:00:59.46761	2023-09-06 17:06:19.985351
3	Joop Stark	123 Test Address; Test, Colorado 80829	teST aPPROVAL	Approved	2023-09-06 01:21:08.495762	2023-09-06 17:11:29.883608
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: williamweston
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-09-06 01:00:59.411518	2023-09-06 01:00:59.411518
\.


--
-- Data for Name: pets; Type: TABLE DATA; Schema: public; Owner: williamweston
--

COPY public.pets (id, adoptable, age, breed, name, shelter_id, created_at, updated_at, application_id) FROM stdin;
1	t	1	beagle	Snoopy	1	2023-09-06 01:00:59.459857	2023-09-06 01:00:59.459857	\N
2	t	3	doberman	Lobster	1	2023-09-06 01:00:59.461819	2023-09-06 01:00:59.461819	\N
3	t	4	beagle	Snoop Dogg	1	2023-09-06 01:00:59.463347	2023-09-06 01:00:59.463347	\N
4	t	2	beagle	Snoop	1	2023-09-05 20:01:16.298947	2023-09-05 20:01:16.298947	\N
5	t	5	beagle	Mr. SnOOp	1	2023-09-05 20:05:06.778414	2023-09-05 20:05:06.778414	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: williamweston
--

COPY public.schema_migrations (version) FROM stdin;
20230224211524
20230224211614
20230224211702
20230224213052
20230831211529
20230831211919
20230831212451
20230901014311
20230902045324
\.


--
-- Data for Name: shelters; Type: TABLE DATA; Schema: public; Owner: williamweston
--

COPY public.shelters (id, foster_program, name, city, rank, created_at, updated_at) FROM stdin;
1	f	Aurora shelter	Aurora, CO	9	2023-09-06 01:00:59.450319	2023-09-06 01:00:59.450319
\.


--
-- Data for Name: veterinarians; Type: TABLE DATA; Schema: public; Owner: williamweston
--

COPY public.veterinarians (id, on_call, review_rating, name, veterinary_office_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: veterinary_offices; Type: TABLE DATA; Schema: public; Owner: williamweston
--

COPY public.veterinary_offices (id, boarding_services, max_patient_capacity, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: application_pets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: williamweston
--

SELECT pg_catalog.setval('public.application_pets_id_seq', 7, true);


--
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: williamweston
--

SELECT pg_catalog.setval('public.applications_id_seq', 4, true);


--
-- Name: pets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: williamweston
--

SELECT pg_catalog.setval('public.pets_id_seq', 5, true);


--
-- Name: shelters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: williamweston
--

SELECT pg_catalog.setval('public.shelters_id_seq', 1, true);


--
-- Name: veterinarians_id_seq; Type: SEQUENCE SET; Schema: public; Owner: williamweston
--

SELECT pg_catalog.setval('public.veterinarians_id_seq', 1, false);


--
-- Name: veterinary_offices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: williamweston
--

SELECT pg_catalog.setval('public.veterinary_offices_id_seq', 1, false);


--
-- Name: application_pets application_pets_pkey; Type: CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.application_pets
    ADD CONSTRAINT application_pets_pkey PRIMARY KEY (id);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: pets pets_pkey; Type: CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT pets_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: shelters shelters_pkey; Type: CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.shelters
    ADD CONSTRAINT shelters_pkey PRIMARY KEY (id);


--
-- Name: veterinarians veterinarians_pkey; Type: CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.veterinarians
    ADD CONSTRAINT veterinarians_pkey PRIMARY KEY (id);


--
-- Name: veterinary_offices veterinary_offices_pkey; Type: CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.veterinary_offices
    ADD CONSTRAINT veterinary_offices_pkey PRIMARY KEY (id);


--
-- Name: index_application_pets_on_application_id; Type: INDEX; Schema: public; Owner: williamweston
--

CREATE INDEX index_application_pets_on_application_id ON public.application_pets USING btree (application_id);


--
-- Name: index_application_pets_on_pet_id; Type: INDEX; Schema: public; Owner: williamweston
--

CREATE INDEX index_application_pets_on_pet_id ON public.application_pets USING btree (pet_id);


--
-- Name: index_pets_on_application_id; Type: INDEX; Schema: public; Owner: williamweston
--

CREATE INDEX index_pets_on_application_id ON public.pets USING btree (application_id);


--
-- Name: index_pets_on_shelter_id; Type: INDEX; Schema: public; Owner: williamweston
--

CREATE INDEX index_pets_on_shelter_id ON public.pets USING btree (shelter_id);


--
-- Name: index_veterinarians_on_veterinary_office_id; Type: INDEX; Schema: public; Owner: williamweston
--

CREATE INDEX index_veterinarians_on_veterinary_office_id ON public.veterinarians USING btree (veterinary_office_id);


--
-- Name: application_pets fk_rails_412710cd26; Type: FK CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.application_pets
    ADD CONSTRAINT fk_rails_412710cd26 FOREIGN KEY (pet_id) REFERENCES public.pets(id);


--
-- Name: pets fk_rails_4581795ce5; Type: FK CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT fk_rails_4581795ce5 FOREIGN KEY (application_id) REFERENCES public.applications(id);


--
-- Name: application_pets fk_rails_6ac8983e3b; Type: FK CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.application_pets
    ADD CONSTRAINT fk_rails_6ac8983e3b FOREIGN KEY (application_id) REFERENCES public.applications(id);


--
-- Name: pets fk_rails_92fb5d7a05; Type: FK CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT fk_rails_92fb5d7a05 FOREIGN KEY (shelter_id) REFERENCES public.shelters(id);


--
-- Name: veterinarians fk_rails_d296209ae6; Type: FK CONSTRAINT; Schema: public; Owner: williamweston
--

ALTER TABLE ONLY public.veterinarians
    ADD CONSTRAINT fk_rails_d296209ae6 FOREIGN KEY (veterinary_office_id) REFERENCES public.veterinary_offices(id);


--
-- PostgreSQL database dump complete
--

