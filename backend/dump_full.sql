--
-- PostgreSQL database dump
--

\restrict H2kornYRkUldCivWCv7sDaWuhqOkzT6hYqmVuivJFrV68m1CNhfzGxPrFQLfCRY

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: enum_Orders_statutCom; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_Orders_statutCom" AS ENUM (
    'pending',
    'shipped',
    'completed',
    'cancelled'
);


ALTER TYPE public."enum_Orders_statutCom" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: CartItems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CartItems" (
    id integer NOT NULL,
    quantity integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "cartId" integer,
    "productId" integer
);


ALTER TABLE public."CartItems" OWNER TO postgres;

--
-- Name: CartItems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CartItems_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CartItems_id_seq" OWNER TO postgres;

--
-- Name: CartItems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CartItems_id_seq" OWNED BY public."CartItems".id;


--
-- Name: Carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Carts" (
    id integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer
);


ALTER TABLE public."Carts" OWNER TO postgres;

--
-- Name: Carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Carts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Carts_id_seq" OWNER TO postgres;

--
-- Name: Carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Carts_id_seq" OWNED BY public."Carts".id;


--
-- Name: Categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Categories" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Categories" OWNER TO postgres;

--
-- Name: Categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Categories_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Categories_id_seq" OWNER TO postgres;

--
-- Name: Categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Categories_id_seq" OWNED BY public."Categories".id;


--
-- Name: OrderItems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrderItems" (
    id integer NOT NULL,
    "productName" character varying(255),
    "productPrice" double precision,
    quantity integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "orderId" integer,
    "productId" integer
);


ALTER TABLE public."OrderItems" OWNER TO postgres;

--
-- Name: OrderItems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OrderItems_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OrderItems_id_seq" OWNER TO postgres;

--
-- Name: OrderItems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OrderItems_id_seq" OWNED BY public."OrderItems".id;


--
-- Name: Orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Orders" (
    id integer NOT NULL,
    "statutCom" public."enum_Orders_statutCom" DEFAULT 'pending'::public."enum_Orders_statutCom",
    total numeric(10,2) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer,
    city character varying(255) NOT NULL,
    street character varying(255) NOT NULL
);


ALTER TABLE public."Orders" OWNER TO postgres;

--
-- Name: Orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Orders_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Orders_id_seq" OWNER TO postgres;

--
-- Name: Orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Orders_id_seq" OWNED BY public."Orders".id;


--
-- Name: Products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Products" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    stock integer DEFAULT 0,
    "imageUrl" character varying(255),
    "isActive" boolean DEFAULT true,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "categoryId" integer
);


ALTER TABLE public."Products" OWNER TO postgres;

--
-- Name: Products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Products_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Products_id_seq" OWNER TO postgres;

--
-- Name: Products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Products_id_seq" OWNED BY public."Products".id;


--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    role character varying(255) DEFAULT 'client'::character varying NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Users_id_seq" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Users_id_seq" OWNED BY public."Users".id;


--
-- Name: CartItems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItems" ALTER COLUMN id SET DEFAULT nextval('public."CartItems_id_seq"'::regclass);


--
-- Name: Carts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Carts" ALTER COLUMN id SET DEFAULT nextval('public."Carts_id_seq"'::regclass);


--
-- Name: Categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories" ALTER COLUMN id SET DEFAULT nextval('public."Categories_id_seq"'::regclass);


--
-- Name: OrderItems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItems" ALTER COLUMN id SET DEFAULT nextval('public."OrderItems_id_seq"'::regclass);


--
-- Name: Orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders" ALTER COLUMN id SET DEFAULT nextval('public."Orders_id_seq"'::regclass);


--
-- Name: Products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products" ALTER COLUMN id SET DEFAULT nextval('public."Products_id_seq"'::regclass);


--
-- Name: Users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users" ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);


--
-- Data for Name: CartItems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CartItems" (id, quantity, "createdAt", "updatedAt", "cartId", "productId") FROM stdin;
\.


--
-- Data for Name: Carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Carts" (id, "createdAt", "updatedAt", "userId") FROM stdin;
1	2025-09-06 19:01:47.113+01	2025-09-06 19:01:47.113+01	2
2	2025-09-06 19:14:25.821+01	2025-09-06 19:14:25.821+01	4
3	2025-09-10 17:04:04.002+01	2025-09-10 17:04:04.002+01	5
\.


--
-- Data for Name: Categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Categories" (id, name, "createdAt", "updatedAt") FROM stdin;
7	Bracelets	2025-09-01 14:27:00.43+01	2025-09-01 14:27:00.43+01
8	Lunettes	2025-09-01 14:27:25.676+01	2025-09-01 14:27:25.676+01
9	Montres	2025-09-01 14:59:31.03+01	2025-09-01 14:59:31.03+01
\.


--
-- Data for Name: OrderItems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OrderItems" (id, "productName", "productPrice", quantity, "createdAt", "updatedAt", "orderId", "productId") FROM stdin;
3	\N	\N	1	2025-09-10 12:52:32.886+01	2025-09-10 12:52:32.886+01	3	21
5	\N	\N	1	2025-09-10 17:04:28.408+01	2025-09-10 17:04:28.408+01	5	16
6	\N	\N	1	2025-09-10 21:02:36.528+01	2025-09-10 21:02:36.528+01	6	21
1	\N	\N	2	2025-09-10 00:58:23.104+01	2025-09-10 00:58:23.104+01	\N	\N
2	\N	\N	1	2025-09-10 01:20:24.542+01	2025-09-10 01:20:24.542+01	2	\N
4	\N	\N	2	2025-09-10 16:45:19.37+01	2025-09-10 16:45:19.37+01	4	\N
\.


--
-- Data for Name: Orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Orders" (id, "statutCom", total, "createdAt", "updatedAt", "userId", city, street) FROM stdin;
2	pending	17.99	2025-09-10 01:20:24.475+01	2025-09-10 01:20:24.475+01	2	B├®ja├»a	Tobal
3	pending	9.50	2025-09-10 12:52:32.824+01	2025-09-10 12:52:32.824+01	4	B├®ja├»a	Oued ghir
4	pending	30.98	2025-09-10 16:45:19.275+01	2025-09-10 16:45:19.275+01	2	Alger	rue didouche mourad
5	pending	455.00	2025-09-10 17:04:28.381+01	2025-09-10 17:04:28.381+01	5	B├®ja├»a	Larbaa,Toudja
6	pending	9.50	2025-09-10 21:02:36.466+01	2025-09-10 21:02:36.466+01	2	Oran	rue akid lotfi
\.


--
-- Data for Name: Products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Products" (id, name, description, price, stock, "imageUrl", "isActive", "createdAt", "updatedAt", "categoryId") FROM stdin;
15	Montre EA	Montre grise italienne EMPORIO ARMANI	700.00	4	https://images.pexels.com/photos/125779/pexels-photo-125779.jpeg	t	2025-09-02 00:26:41.852+01	2025-09-11 01:28:39.103+01	9
20	Bracelet couleur lin	D├®couvrez notre pack exclusif de 5 bracelets en lin, con├ºus pour les amateurs de bijoux naturels et artisanaux. Chaque bracelet est fabriqu├® ├á la main avec des fibres de lin de haute qualit├®, garantissant ├á la fois durabilit├®, confort et l├®g├¿ret├®.\n\nCaract├®ristiques du produit :\n\nMat├®riau naturel : Lin 100% biologique, doux et respectueux de la peau.\n\nTaille ajustable : Convient ├á la plupart des poignets gr├óce ├á un syst├¿me de n┼ôuds coulissants facile ├á ajuster.\n\nDesign unique : Chaque bracelet poss├¿de un motif boh├¿me distinct, parfait pour un look casual ou ├®l├®gant.\n\nCouleurs vari├®es : Ce pack contient 5 couleurs diff├®rentes, allant du beige naturel au brun profond, pour sÔÇÖadapter ├á tous vos styles et tenues.\n\nArtisanat ├®thique : Fabriqu├® ├á la main par des artisans qualifi├®s, soutenant le commerce ├®quitable et les pratiques durables.\n\nAvantages :\n\nId├®al pour un look quotidien, se combinant facilement avec dÔÇÖautres accessoires.\n\nParfait comme cadeau pour lui ou elle, emball├® dans un petit sac en tissu r├®utilisable.\n\nL├®gers et r├®sistants, ils sont adapt├®s ├á un usage quotidien, que ce soit au travail, ├á lÔÇÖ├®cole ou en voyage.\n\nConseils dÔÇÖentretien :\n\n├ëvitez lÔÇÖeau et les produits chimiques pour pr├®server la couleur et la texture du lin.\n\nNettoyez d├®licatement avec un chiffon humide en cas de salissure.\n\nPourquoi choisir notre pack de bracelets en linÔÇ»?\nCe set est pens├® pour ceux qui appr├®cient la simplicit├® naturelle et lÔÇÖ├®l├®gance artisanale. Que vous soyez ├á la recherche dÔÇÖun cadeau significatif, dÔÇÖun accessoire tendance ou simplement dÔÇÖun bijou qui refl├¿te votre style boh├¿me, ce pack de bracelets en lin est fait pour vous.	10.00	12	https://images.pexels.com/photos/322674/pexels-photo-322674.jpeg	t	2025-09-02 00:37:22.75+01	2025-09-11 01:29:03.759+01	7
13	lunettes de soleil	lunettes classique	14.00	20	https://pikaso.cdnpk.net/private/production/2307671495/render.png?token=exp=1777939200~hmac=ba7ed37f93f690ddb47f07dd3d1322dd84ec0c58caf10356907108021e986cdc	t	2025-09-01 19:00:50.271+01	2025-09-01 19:00:50.271+01	8
12	Bracelet en acier	bracelet solide en acier inoxydable	15.00	25	https://pikaso.cdnpk.net/private/production/2307658274/render.png?token=exp=1777939200~hmac=1b06fe6d49e2997814abcacfab7daf6bd7a76b6da9f5d4767fa021ed6edaf785	t	2025-09-01 18:58:07.037+01	2025-09-02 00:06:25.155+01	7
9	smart watch	Montre digitale plein d'options	55.00	25	https://pikaso.cdnpk.net/private/production/2018218653/C702fU04y4sv7yN7NwPc3rILgIO4KKcx5V5v3joB.jpg?token=exp=1777939200~hmac=5247a865c0fbec5ed86625c0bd2732f6583bc5a941b060a9239ee24016edfcf2	t	2025-09-01 18:47:48.061+01	2025-09-02 00:06:39.292+01	9
14	Montre Hublot	Montre hublot haut de gamme	1300.00	2	https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg	t	2025-09-02 00:25:34.717+01	2025-09-02 00:25:34.717+01	9
16	montre ADAMKIMMEL	montre prestigieuse con├ºue sp├®cialement pour un look ├®legant	450.00	7	https://images.pexels.com/photos/277390/pexels-photo-277390.jpeg	t	2025-09-02 00:29:41.116+01	2025-09-02 00:29:41.116+01	9
17	Montre citizen	CITIZEN watch on black edition	280.00	4	https://images.pexels.com/photos/592815/pexels-photo-592815.jpeg	t	2025-09-02 00:32:08.184+01	2025-09-02 00:32:08.184+01	9
18	Lunettes ryback	lunettes de soleil good quality	24.00	8	https://images.pexels.com/photos/712395/pexels-photo-712395.jpeg	t	2025-09-02 00:34:04.142+01	2025-09-02 00:34:04.142+01	8
19	Lunettes bleu ciel	lunettes tendance au bleu des bourgeois	18.00	10	https://images.pexels.com/photos/1499480/pexels-photo-1499480.jpeg	t	2025-09-02 00:35:40.637+01	2025-09-02 00:35:40.637+01	8
21	Bracelet classique	bracelet en boules	4.50	11	https://images.pexels.com/photos/3419947/pexels-photo-3419947.jpeg	t	2025-09-02 00:38:14.21+01	2025-09-02 00:38:14.21+01	7
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" (id, username, email, password, "createdAt", "updatedAt", role) FROM stdin;
1	Khoualdi Lyazid	khoualdilyazid232@gmail.com	$2b$10$NHReZmT427QJdusKz4U0guHL.sT5dmJeRSNTRRVlMbzMaGsNxQrWO	2025-09-01 00:04:36.889+01	2025-09-01 00:04:36.889+01	client
2	Kh	yazidkhoualdi5@gmail.com	$2b$10$sHT1XjG856oBHFo8RWnHXOLyvTD7ZgrWJQLaWQqYZDyidEwtrTIWm	2025-09-02 23:12:37.491+01	2025-09-02 23:12:37.491+01	client
4	Khoualdi	zazzikhoualdi@gmail.com	$2b$10$VQjemtdnGdfsC67MzfDc1u2e779XeSWNkLmbpu4EsaELQzbrKPTRC	2025-09-04 20:05:47.365+01	2025-09-04 20:05:47.365+01	client
5	Amaouche Samy	eyshield02@gmail.com	$2b$10$uo0ukSfOjd84a3PlOpGtvetPjSXscn3hfnlcfJvq9OEOY5463G9Fa	2025-09-10 17:03:28.473+01	2025-09-10 17:03:28.473+01	client
8	Admin	khoualdilyazid139@gmail.com	$2b$10$m.Xe57TkoiVwn4Rpf/zMpesaIZWrliG38bXur6buTkuPZsLCxZxjy	2025-09-10 21:56:12.901058+01	2025-09-10 21:56:12.901058+01	admin
\.


--
-- Name: CartItems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."CartItems_id_seq"', 16, true);


--
-- Name: Carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Carts_id_seq"', 3, true);


--
-- Name: Categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Categories_id_seq"', 11, true);


--
-- Name: OrderItems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderItems_id_seq"', 6, true);


--
-- Name: Orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Orders_id_seq"', 6, true);


--
-- Name: Products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Products_id_seq"', 22, true);


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_id_seq"', 8, true);


--
-- Name: CartItems CartItems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItems"
    ADD CONSTRAINT "CartItems_pkey" PRIMARY KEY (id);


--
-- Name: Carts Carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Carts"
    ADD CONSTRAINT "Carts_pkey" PRIMARY KEY (id);


--
-- Name: Categories Categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key" UNIQUE (name);


--
-- Name: Categories Categories_name_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key1" UNIQUE (name);


--
-- Name: Categories Categories_name_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key10" UNIQUE (name);


--
-- Name: Categories Categories_name_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key11" UNIQUE (name);


--
-- Name: Categories Categories_name_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key12" UNIQUE (name);


--
-- Name: Categories Categories_name_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key13" UNIQUE (name);


--
-- Name: Categories Categories_name_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key14" UNIQUE (name);


--
-- Name: Categories Categories_name_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key15" UNIQUE (name);


--
-- Name: Categories Categories_name_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key16" UNIQUE (name);


--
-- Name: Categories Categories_name_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key17" UNIQUE (name);


--
-- Name: Categories Categories_name_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key18" UNIQUE (name);


--
-- Name: Categories Categories_name_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key19" UNIQUE (name);


--
-- Name: Categories Categories_name_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key2" UNIQUE (name);


--
-- Name: Categories Categories_name_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key20" UNIQUE (name);


--
-- Name: Categories Categories_name_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key21" UNIQUE (name);


--
-- Name: Categories Categories_name_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key22" UNIQUE (name);


--
-- Name: Categories Categories_name_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key23" UNIQUE (name);


--
-- Name: Categories Categories_name_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key24" UNIQUE (name);


--
-- Name: Categories Categories_name_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key25" UNIQUE (name);


--
-- Name: Categories Categories_name_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key26" UNIQUE (name);


--
-- Name: Categories Categories_name_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key27" UNIQUE (name);


--
-- Name: Categories Categories_name_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key28" UNIQUE (name);


--
-- Name: Categories Categories_name_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key29" UNIQUE (name);


--
-- Name: Categories Categories_name_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key3" UNIQUE (name);


--
-- Name: Categories Categories_name_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key30" UNIQUE (name);


--
-- Name: Categories Categories_name_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key31" UNIQUE (name);


--
-- Name: Categories Categories_name_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key32" UNIQUE (name);


--
-- Name: Categories Categories_name_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key33" UNIQUE (name);


--
-- Name: Categories Categories_name_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key34" UNIQUE (name);


--
-- Name: Categories Categories_name_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key35" UNIQUE (name);


--
-- Name: Categories Categories_name_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key36" UNIQUE (name);


--
-- Name: Categories Categories_name_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key37" UNIQUE (name);


--
-- Name: Categories Categories_name_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key38" UNIQUE (name);


--
-- Name: Categories Categories_name_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key39" UNIQUE (name);


--
-- Name: Categories Categories_name_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key4" UNIQUE (name);


--
-- Name: Categories Categories_name_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key40" UNIQUE (name);


--
-- Name: Categories Categories_name_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key41" UNIQUE (name);


--
-- Name: Categories Categories_name_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key42" UNIQUE (name);


--
-- Name: Categories Categories_name_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key43" UNIQUE (name);


--
-- Name: Categories Categories_name_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key44" UNIQUE (name);


--
-- Name: Categories Categories_name_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key45" UNIQUE (name);


--
-- Name: Categories Categories_name_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key46" UNIQUE (name);


--
-- Name: Categories Categories_name_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key47" UNIQUE (name);


--
-- Name: Categories Categories_name_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key48" UNIQUE (name);


--
-- Name: Categories Categories_name_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key49" UNIQUE (name);


--
-- Name: Categories Categories_name_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key5" UNIQUE (name);


--
-- Name: Categories Categories_name_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key50" UNIQUE (name);


--
-- Name: Categories Categories_name_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key51" UNIQUE (name);


--
-- Name: Categories Categories_name_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key52" UNIQUE (name);


--
-- Name: Categories Categories_name_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key53" UNIQUE (name);


--
-- Name: Categories Categories_name_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key54" UNIQUE (name);


--
-- Name: Categories Categories_name_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key55" UNIQUE (name);


--
-- Name: Categories Categories_name_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key56" UNIQUE (name);


--
-- Name: Categories Categories_name_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key57" UNIQUE (name);


--
-- Name: Categories Categories_name_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key58" UNIQUE (name);


--
-- Name: Categories Categories_name_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key59" UNIQUE (name);


--
-- Name: Categories Categories_name_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key6" UNIQUE (name);


--
-- Name: Categories Categories_name_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key60" UNIQUE (name);


--
-- Name: Categories Categories_name_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key61" UNIQUE (name);


--
-- Name: Categories Categories_name_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key62" UNIQUE (name);


--
-- Name: Categories Categories_name_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key63" UNIQUE (name);


--
-- Name: Categories Categories_name_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key64" UNIQUE (name);


--
-- Name: Categories Categories_name_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key65" UNIQUE (name);


--
-- Name: Categories Categories_name_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key66" UNIQUE (name);


--
-- Name: Categories Categories_name_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key67" UNIQUE (name);


--
-- Name: Categories Categories_name_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key68" UNIQUE (name);


--
-- Name: Categories Categories_name_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key69" UNIQUE (name);


--
-- Name: Categories Categories_name_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key7" UNIQUE (name);


--
-- Name: Categories Categories_name_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key70" UNIQUE (name);


--
-- Name: Categories Categories_name_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key71" UNIQUE (name);


--
-- Name: Categories Categories_name_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key72" UNIQUE (name);


--
-- Name: Categories Categories_name_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key73" UNIQUE (name);


--
-- Name: Categories Categories_name_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key74" UNIQUE (name);


--
-- Name: Categories Categories_name_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key75" UNIQUE (name);


--
-- Name: Categories Categories_name_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key76" UNIQUE (name);


--
-- Name: Categories Categories_name_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key8" UNIQUE (name);


--
-- Name: Categories Categories_name_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_name_key9" UNIQUE (name);


--
-- Name: Categories Categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_pkey" PRIMARY KEY (id);


--
-- Name: OrderItems OrderItems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItems"
    ADD CONSTRAINT "OrderItems_pkey" PRIMARY KEY (id);


--
-- Name: Orders Orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_pkey" PRIMARY KEY (id);


--
-- Name: Products Products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key" UNIQUE (email);


--
-- Name: Users Users_email_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key1" UNIQUE (email);


--
-- Name: Users Users_email_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key10" UNIQUE (email);


--
-- Name: Users Users_email_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key11" UNIQUE (email);


--
-- Name: Users Users_email_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key12" UNIQUE (email);


--
-- Name: Users Users_email_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key13" UNIQUE (email);


--
-- Name: Users Users_email_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key14" UNIQUE (email);


--
-- Name: Users Users_email_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key15" UNIQUE (email);


--
-- Name: Users Users_email_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key16" UNIQUE (email);


--
-- Name: Users Users_email_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key17" UNIQUE (email);


--
-- Name: Users Users_email_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key18" UNIQUE (email);


--
-- Name: Users Users_email_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key19" UNIQUE (email);


--
-- Name: Users Users_email_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key2" UNIQUE (email);


--
-- Name: Users Users_email_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key20" UNIQUE (email);


--
-- Name: Users Users_email_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key21" UNIQUE (email);


--
-- Name: Users Users_email_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key22" UNIQUE (email);


--
-- Name: Users Users_email_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key23" UNIQUE (email);


--
-- Name: Users Users_email_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key24" UNIQUE (email);


--
-- Name: Users Users_email_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key25" UNIQUE (email);


--
-- Name: Users Users_email_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key26" UNIQUE (email);


--
-- Name: Users Users_email_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key27" UNIQUE (email);


--
-- Name: Users Users_email_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key28" UNIQUE (email);


--
-- Name: Users Users_email_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key29" UNIQUE (email);


--
-- Name: Users Users_email_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key3" UNIQUE (email);


--
-- Name: Users Users_email_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key30" UNIQUE (email);


--
-- Name: Users Users_email_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key31" UNIQUE (email);


--
-- Name: Users Users_email_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key32" UNIQUE (email);


--
-- Name: Users Users_email_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key33" UNIQUE (email);


--
-- Name: Users Users_email_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key34" UNIQUE (email);


--
-- Name: Users Users_email_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key35" UNIQUE (email);


--
-- Name: Users Users_email_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key36" UNIQUE (email);


--
-- Name: Users Users_email_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key37" UNIQUE (email);


--
-- Name: Users Users_email_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key38" UNIQUE (email);


--
-- Name: Users Users_email_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key39" UNIQUE (email);


--
-- Name: Users Users_email_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key4" UNIQUE (email);


--
-- Name: Users Users_email_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key40" UNIQUE (email);


--
-- Name: Users Users_email_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key41" UNIQUE (email);


--
-- Name: Users Users_email_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key42" UNIQUE (email);


--
-- Name: Users Users_email_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key43" UNIQUE (email);


--
-- Name: Users Users_email_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key44" UNIQUE (email);


--
-- Name: Users Users_email_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key45" UNIQUE (email);


--
-- Name: Users Users_email_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key46" UNIQUE (email);


--
-- Name: Users Users_email_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key47" UNIQUE (email);


--
-- Name: Users Users_email_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key48" UNIQUE (email);


--
-- Name: Users Users_email_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key49" UNIQUE (email);


--
-- Name: Users Users_email_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key5" UNIQUE (email);


--
-- Name: Users Users_email_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key50" UNIQUE (email);


--
-- Name: Users Users_email_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key51" UNIQUE (email);


--
-- Name: Users Users_email_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key52" UNIQUE (email);


--
-- Name: Users Users_email_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key53" UNIQUE (email);


--
-- Name: Users Users_email_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key54" UNIQUE (email);


--
-- Name: Users Users_email_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key55" UNIQUE (email);


--
-- Name: Users Users_email_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key56" UNIQUE (email);


--
-- Name: Users Users_email_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key57" UNIQUE (email);


--
-- Name: Users Users_email_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key58" UNIQUE (email);


--
-- Name: Users Users_email_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key59" UNIQUE (email);


--
-- Name: Users Users_email_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key6" UNIQUE (email);


--
-- Name: Users Users_email_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key60" UNIQUE (email);


--
-- Name: Users Users_email_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key61" UNIQUE (email);


--
-- Name: Users Users_email_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key62" UNIQUE (email);


--
-- Name: Users Users_email_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key63" UNIQUE (email);


--
-- Name: Users Users_email_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key64" UNIQUE (email);


--
-- Name: Users Users_email_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key65" UNIQUE (email);


--
-- Name: Users Users_email_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key66" UNIQUE (email);


--
-- Name: Users Users_email_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key67" UNIQUE (email);


--
-- Name: Users Users_email_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key68" UNIQUE (email);


--
-- Name: Users Users_email_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key69" UNIQUE (email);


--
-- Name: Users Users_email_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key7" UNIQUE (email);


--
-- Name: Users Users_email_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key70" UNIQUE (email);


--
-- Name: Users Users_email_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key71" UNIQUE (email);


--
-- Name: Users Users_email_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key72" UNIQUE (email);


--
-- Name: Users Users_email_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key73" UNIQUE (email);


--
-- Name: Users Users_email_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key74" UNIQUE (email);


--
-- Name: Users Users_email_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key75" UNIQUE (email);


--
-- Name: Users Users_email_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key76" UNIQUE (email);


--
-- Name: Users Users_email_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key8" UNIQUE (email);


--
-- Name: Users Users_email_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key9" UNIQUE (email);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: CartItems CartItems_cartId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItems"
    ADD CONSTRAINT "CartItems_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES public."Carts"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CartItems CartItems_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItems"
    ADD CONSTRAINT "CartItems_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Products"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Carts Carts_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Carts"
    ADD CONSTRAINT "Carts_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: OrderItems OrderItems_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItems"
    ADD CONSTRAINT "OrderItems_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Orders"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: OrderItems OrderItems_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItems"
    ADD CONSTRAINT "OrderItems_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Products"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Orders Orders_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Products Products_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Categories"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict H2kornYRkUldCivWCv7sDaWuhqOkzT6hYqmVuivJFrV68m1CNhfzGxPrFQLfCRY

