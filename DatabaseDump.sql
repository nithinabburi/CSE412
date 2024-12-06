--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 17.0

-- Started on 2024-12-06 11:25:23 MST

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
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3664 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 24699)
-- Name: ORDER; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ORDER" (
    order_id integer NOT NULL,
    email character varying(255) NOT NULL
);


ALTER TABLE public."ORDER" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24698)
-- Name: ORDER_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ORDER_order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ORDER_order_id_seq" OWNER TO postgres;

--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 219
-- Name: ORDER_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ORDER_order_id_seq" OWNED BY public."ORDER".order_id;


--
-- TOC entry 223 (class 1259 OID 24718)
-- Name: author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author (
    author_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.author OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24717)
-- Name: author_author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.author_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.author_author_id_seq OWNER TO postgres;

--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 222
-- Name: author_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.author_author_id_seq OWNED BY public.author.author_id;


--
-- TOC entry 221 (class 1259 OID 24710)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    isbn character varying(20) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    cover character varying(10000),
    price numeric(10,2)
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24725)
-- Name: copy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.copy (
    copy_id integer NOT NULL,
    isbn character varying(20) NOT NULL,
    condition character varying(50)
);


ALTER TABLE public.copy OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24724)
-- Name: copy_copy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.copy_copy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.copy_copy_id_seq OWNER TO postgres;

--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 224
-- Name: copy_copy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.copy_copy_id_seq OWNED BY public.copy.copy_id;


--
-- TOC entry 227 (class 1259 OID 24751)
-- Name: orders_copy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders_copy (
    order_id integer NOT NULL,
    copy_id integer NOT NULL
);


ALTER TABLE public.orders_copy OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24822)
-- Name: purchases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchases (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    book_isbn character varying(50) NOT NULL,
    book_name character varying(255) NOT NULL,
    purchase_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.purchases OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24821)
-- Name: purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchases_id_seq OWNER TO postgres;

--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 228
-- Name: purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchases_id_seq OWNED BY public.purchases.id;


--
-- TOC entry 218 (class 1259 OID 24691)
-- Name: user_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_account (
    email character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL
);


ALTER TABLE public.user_account OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24736)
-- Name: written_by; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.written_by (
    isbn character varying(20) NOT NULL,
    author_id integer NOT NULL
);


ALTER TABLE public.written_by OWNER TO postgres;

--
-- TOC entry 3477 (class 2604 OID 24702)
-- Name: ORDER order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORDER" ALTER COLUMN order_id SET DEFAULT nextval('public."ORDER_order_id_seq"'::regclass);


--
-- TOC entry 3478 (class 2604 OID 24721)
-- Name: author author_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author ALTER COLUMN author_id SET DEFAULT nextval('public.author_author_id_seq'::regclass);


--
-- TOC entry 3479 (class 2604 OID 24728)
-- Name: copy copy_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.copy ALTER COLUMN copy_id SET DEFAULT nextval('public.copy_copy_id_seq'::regclass);


--
-- TOC entry 3480 (class 2604 OID 24825)
-- Name: purchases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases ALTER COLUMN id SET DEFAULT nextval('public.purchases_id_seq'::regclass);


--
-- TOC entry 3649 (class 0 OID 24699)
-- Dependencies: 220
-- Data for Name: ORDER; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ORDER" (order_id, email) FROM stdin;
2	abirks8@eventbrite.com
3	achastelain1x@last.fm
4	ahowgego12@yale.edu
5	aroberson2k@google.nl
6	asimounet5@imgur.com
7	aspraggon1u@ebay.co.uk
8	astenbridge2j@theatlantic.com
9	astrode1o@imgur.com
10	bbartrumw@amazon.de
11	bbusainu@themeforest.net
12	bmeckiff2b@umn.edu
13	bthorneloe20@webs.com
14	ccherry1@topsy.com
15	cendrizzi2l@discovery.com
16	cfoulstonel@sciencedaily.com
17	cjosselsohn2i@newsvine.com
18	ckunze29@t.co
19	coulett0@smugmug.com
20	ddavidai1q@cpanel.net
21	ddudenieq@odnoklassniki.ru
22	dgadaud1e@sphinn.com
23	eandrzej1n@google.co.jp
24	eblaes1v@usda.gov
25	ebourhillb@netvibes.com
26	eguillotin2p@nps.gov
27	emacquire2@cloudflare.com
28	epirelli17@abc.net.au
29	farne1t@histats.com
30	fbodechon1f@blog.com
31	fburlingo@yale.edu
32	fchateri@e-recht24.de
33	fmanderson1h@shop-pro.jp
34	glathwellh@washington.edu
35	glightend@phoca.cz
36	gmazzey2n@archive.org
37	gpeealessk@unesco.org
38	grosenfrucht16@shop-pro.jp
39	gschule1p@surveymonkey.com
40	gsitford3@apple.com
41	hde1l@mashable.com
42	hivashnyov1a@yolasite.com
43	jbew18@cpanel.net
44	jgundrey28@ow.ly
45	jondricek2g@census.gov
46	kbyram1w@nps.gov
47	kdugalda@amazonaws.com
48	kfreiburgere@seesaa.net
49	khanhard13@is.gd
50	kkingswood10@aboutads.info
51	klanghorn2f@amazon.co.jp
52	kmckinn2d@goo.gl
53	kparr19@stumbleupon.com
54	kstranger4@bbb.org
55	lcestard1g@time.com
56	lcraine15@dell.com
57	lfaucherand1z@hatena.ne.jp
58	lhurcombe23@umich.edu
59	lmarcinkowskis@archive.org
60	mdenington1j@vkontakte.ru
61	mfilipiak24@discovery.com
62	mformiglit@accuweather.com
63	mgiacubo1i@elpais.com
64	mmozzetti7@sourceforge.net
65	molivello27@t-online.de
66	mrubke22@marriott.com
67	mthurbym@domainmarket.com
68	nbrackenx@slashdot.org
69	ncatt1r@wired.com
70	nvankov2c@bravesites.com
71	oguilbert9@about.me
72	omodeny@theguardian.com
73	pchastang25@indiatimes.com
74	pfitzsimons2a@cisco.com
75	pgrandham1b@imdb.com
76	pjurczik2r@microsoft.com
77	pmalins2m@google.co.jp
78	rcassella11@unc.edu
79	rcecchetelli2o@sourceforge.net
80	rdafferng@huffingtonpost.com
81	rdronsfield1s@yelp.com
82	sdadley14@livejournal.com
83	sdyment21@51.la
84	srobatham1d@unblog.fr
85	srottcher6@cocolog-nifty.com
86	ssherwyn1m@ask.com
87	tbailiss1k@pcworld.com
88	tbelchambersv@sohu.com
89	tdumbrall26@google.it
90	tferrieriop@rakuten.co.jp
91	tgorryr@flavors.me
92	tgrigoirez@engadget.com
93	tjedraszekn@loc.gov
94	tpardue2e@stanford.edu
95	vfeeney2h@uol.com.br
96	vgoodingej@stanford.edu
97	vmartignonif@livejournal.com
98	wbesset2q@sohu.com
99	wde1c@qq.com
100	welgramc@accuweather.com
101	wortell1y@mapy.cz
103	abirks8@eventbrite.com
104	achastelain1x@last.fm
105	ahowgego12@yale.edu
106	aroberson2k@google.nl
107	asimounet5@imgur.com
108	aspraggon1u@ebay.co.uk
109	astenbridge2j@theatlantic.com
110	astrode1o@imgur.com
111	bbartrumw@amazon.de
112	bbusainu@themeforest.net
113	bmeckiff2b@umn.edu
114	bthorneloe20@webs.com
115	ccherry1@topsy.com
116	cendrizzi2l@discovery.com
117	cfoulstonel@sciencedaily.com
118	cjosselsohn2i@newsvine.com
119	ckunze29@t.co
120	coulett0@smugmug.com
121	ddavidai1q@cpanel.net
122	ddudenieq@odnoklassniki.ru
123	dgadaud1e@sphinn.com
124	eandrzej1n@google.co.jp
125	eblaes1v@usda.gov
126	ebourhillb@netvibes.com
127	eguillotin2p@nps.gov
128	emacquire2@cloudflare.com
129	epirelli17@abc.net.au
130	farne1t@histats.com
131	fbodechon1f@blog.com
132	fburlingo@yale.edu
133	fchateri@e-recht24.de
134	fmanderson1h@shop-pro.jp
135	glathwellh@washington.edu
136	glightend@phoca.cz
137	gmazzey2n@archive.org
138	gpeealessk@unesco.org
139	grosenfrucht16@shop-pro.jp
140	gschule1p@surveymonkey.com
141	gsitford3@apple.com
142	hde1l@mashable.com
143	hivashnyov1a@yolasite.com
144	jbew18@cpanel.net
145	jgundrey28@ow.ly
146	jondricek2g@census.gov
147	kbyram1w@nps.gov
148	kdugalda@amazonaws.com
149	kfreiburgere@seesaa.net
150	khanhard13@is.gd
151	kkingswood10@aboutads.info
152	klanghorn2f@amazon.co.jp
153	kmckinn2d@goo.gl
154	kparr19@stumbleupon.com
155	kstranger4@bbb.org
156	lcestard1g@time.com
157	lcraine15@dell.com
158	lfaucherand1z@hatena.ne.jp
159	lhurcombe23@umich.edu
160	lmarcinkowskis@archive.org
161	mdenington1j@vkontakte.ru
162	mfilipiak24@discovery.com
163	mformiglit@accuweather.com
164	mgiacubo1i@elpais.com
165	mmozzetti7@sourceforge.net
166	molivello27@t-online.de
167	mrubke22@marriott.com
168	mthurbym@domainmarket.com
169	nbrackenx@slashdot.org
170	ncatt1r@wired.com
171	nvankov2c@bravesites.com
172	oguilbert9@about.me
173	omodeny@theguardian.com
174	pchastang25@indiatimes.com
175	pfitzsimons2a@cisco.com
176	pgrandham1b@imdb.com
177	pjurczik2r@microsoft.com
178	pmalins2m@google.co.jp
179	rcassella11@unc.edu
180	rcecchetelli2o@sourceforge.net
181	rdafferng@huffingtonpost.com
182	rdronsfield1s@yelp.com
183	sdadley14@livejournal.com
184	sdyment21@51.la
185	srobatham1d@unblog.fr
186	srottcher6@cocolog-nifty.com
187	ssherwyn1m@ask.com
188	tbailiss1k@pcworld.com
189	tbelchambersv@sohu.com
190	tdumbrall26@google.it
191	tferrieriop@rakuten.co.jp
192	tgorryr@flavors.me
193	tgrigoirez@engadget.com
194	tjedraszekn@loc.gov
195	tpardue2e@stanford.edu
196	vfeeney2h@uol.com.br
197	vgoodingej@stanford.edu
198	vmartignonif@livejournal.com
199	wbesset2q@sohu.com
200	wde1c@qq.com
\.


--
-- TOC entry 3652 (class 0 OID 24718)
-- Dependencies: 223
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.author (author_id, name) FROM stdin;
1	Yancy D'Antuoni
2	Melony Woodthorpe
3	Gaven Giorgetti
4	Ilise Schall
5	Kimmi Highwood
6	Bay Wannell
7	Elmira Curnokk
8	Aurlie Stuehmeier
9	Wittie Wrotham
10	Bernice Paulin
11	Evelyn Ovise
12	Mick Kytley
13	Kenton Matushevitz
14	Udall Bambra
15	Kasper Innis
16	Lian Faherty
17	Marita Boule
18	Vanny Reye
19	Zuzana Fulkes
20	Mala Grigori
21	Jenny Kenderdine
22	Con Yukhnin
23	Claybourne Vearnals
24	Randene Denisovo
25	Selig Jellman
26	Nataniel Pietron
27	Wendi Ettles
28	Curtice McGeachey
29	Lucilia Shorthouse
30	Tiffani Hardcastle
31	Adrien Casterot
32	Rochette Bramsom
33	Birdie Kryszkiecicz
34	Quinn Friman
35	Barrie Shayler
36	Caria Ilyin
37	Holli Cordner
38	Mable Issard
39	Stephan Marco
40	Sammy Brahm
41	Bettina Clinton
42	Theodosia Douch
43	Jason Tyson
44	Tedie Etter
45	Sabrina Lowensohn
46	Ashely Paulig
47	Brander Kiledal
48	Leola Crippin
49	Carleton Roller
50	Anne-marie Dashkovich
\.


--
-- TOC entry 3650 (class 0 OID 24710)
-- Dependencies: 221
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book (isbn, name, description, cover, price) FROM stdin;
208704344-2	The Secret Garden	In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.	http://studiopress.com/lobortis/convallis.png?habitasse=nulla&platea=justo&dictumst=aliquam&maecenas=quis&ut=turpis&massa=eget&quis=elit&augue=sodales&luctus=scelerisque&tincidunt=mauris&nulla=sit&mollis=amet&molestie=eros&lorem=suspendisse&quisque=accumsan&ut=tortor&erat=quis&curabitur=turpis&gravida=sed&nisi=ante&at=vivamus&nibh=tortor&in=duis&hac=mattis&habitasse=egestas&platea=metus&dictumst=aenean&aliquam=fermentum&augue=donec&quam=ut&sollicitudin=mauris&vitae=eget&consectetuer=massa&eget=tempor&rutrum=convallis&at=nulla&lorem=neque&integer=libero&tincidunt=convallis	74.34
577674073-8	The Great Gatsby	Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.	http://mashable.com/consequat/dui/nec/nisi.aspx?non=morbi	10.37
708973808-6	Pride and Prejudice	Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.	http://java.com/turpis/eget/elit/sodales/scelerisque/mauris/sit.jsp?porttitor=volutpat&lorem=erat&id=quisque&ligula=erat&suspendisse=eros&ornare=viverra&consequat=eget&lectus=congue&in=eget&est=semper&risus=rutrum&auctor=nulla&sed=nunc&tristique=purus&in=phasellus&tempus=in&sit=felis&amet=donec&sem=semper&fusce=sapien&consequat=a&nulla=libero&nisl=nam&nunc=dui&nisl=proin&duis=leo&bibendum=odio&felis=porttitor&sed=id&interdum=consequat&venenatis=in&turpis=consequat&enim=ut&blandit=nulla&mi=sed&in=accumsan&porttitor=felis&pede=ut&justo=at&eu=dolor&massa=quis&donec=odio&dapibus=consequat&duis=varius&at=integer&velit=ac&eu=leo&est=pellentesque&congue=ultrices&elementum=mattis&in=odio&hac=donec&habitasse=vitae&platea=nisi&dictumst=nam&morbi=ultrices&vestibulum=libero&velit=non&id=mattis&pretium=pulvinar&iaculis=nulla&diam=pede&erat=ullamcorper&fermentum=augue&justo=a&nec=suscipit&condimentum=nulla&neque=elit&sapien=ac&placerat=nulla&ante=sed&nulla=vel&justo=enim&aliquam=sit&quis=amet	42.82
331569357-9	To Kill a Mockingbird	Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.	http://slate.com/mauris/ullamcorper/purus/sit/amet.aspx?imperdiet=sem&et=sed&commodo=sagittis&vulputate=nam&justo=congue&in=risus&blandit=semper&ultrices=porta&enim=volutpat&lorem=quam&ipsum=pede&dolor=lobortis&sit=ligula&amet=sit&consectetuer=amet&adipiscing=eleifend&elit=pede&proin=libero&interdum=quis&mauris=orci&non=nullam&ligula=molestie&pellentesque=nibh&ultrices=in&phasellus=lectus&id=pellentesque&sapien=at&in=nulla&sapien=suspendisse&iaculis=potenti&congue=cras&vivamus=in&metus=purus&arcu=eu&adipiscing=magna&molestie=vulputate&hendrerit=luctus&at=cum&vulputate=sociis&vitae=natoque&nisl=penatibus&aenean=et&lectus=magnis&pellentesque=dis&eget=parturient&nunc=montes&donec=nascetur&quis=ridiculus&orci=mus&eget=vivamus&orci=vestibulum&vehicula=sagittis&condimentum=sapien&curabitur=cum&in=sociis&libero=natoque&ut=penatibus&massa=et&volutpat=magnis&convallis=dis&morbi=parturient&odio=montes&odio=nascetur&elementum=ridiculus&eu=mus&interdum=etiam&eu=vel&tincidunt=augue&in=vestibulum&leo=rutrum&maecenas=rutrum&pulvinar=neque&lobortis=aenean&est=auctor&phasellus=gravida&sit=sem&amet=praesent&erat=id&nulla=massa&tempus=id	13.05
096034064-5	Harry Potter and the Sorcerer's Stone	Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.	https://un.org/aliquet/at/feugiat/non/pretium/quis.xml?non=risus&interdum=praesent&in=lectus&ante=vestibulum&vestibulum=quam&ante=sapien&ipsum=varius&primis=ut&in=blandit&faucibus=non&orci=interdum&luctus=in&et=ante&ultrices=vestibulum&posuere=ante&cubilia=ipsum&curae=primis&duis=in&faucibus=faucibus&accumsan=orci&odio=luctus&curabitur=et&convallis=ultrices&duis=posuere&consequat=cubilia&dui=curae&nec=duis&nisi=faucibus&volutpat=accumsan&eleifend=odio&donec=curabitur&ut=convallis&dolor=duis&morbi=consequat&vel=dui&lectus=nec&in=nisi&quam=volutpat&fringilla=eleifend&rhoncus=donec&mauris=ut&enim=dolor&leo=morbi&rhoncus=vel&sed=lectus&vestibulum=in&sit=quam&amet=fringilla&cursus=rhoncus&id=mauris&turpis=enim&integer=leo&aliquet=rhoncus&massa=sed&id=vestibulum&lobortis=sit&convallis=amet&tortor=cursus&risus=id&dapibus=turpis&augue=integer&vel=aliquet&accumsan=massa&tellus=id&nisi=lobortis&eu=convallis&orci=tortor&mauris=risus&lacinia=dapibus&sapien=augue&quis=vel&libero=accumsan&nullam=tellus&sit=nisi&amet=eu&turpis=orci&elementum=mauris&ligula=lacinia&vehicula=sapien&consequat=quis&morbi=libero&a=nullam&ipsum=sit&integer=amet&a=turpis&nibh=elementum&in=ligula&quis=vehicula&justo=consequat&maecenas=morbi&rhoncus=a&aliquam=ipsum&lacus=integer&morbi=a	30.14
490417166-7	The Catcher in the Rye	Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.	https://uol.com.br/ante/ipsum/primis.html?in=pellentesque&hac=ultrices&habitasse=phasellus&platea=id&dictumst=sapien&morbi=in&vestibulum=sapien	16.19
125879241-9	1984	Donec vitae nisi.	https://ox.ac.uk/a.png?eu=commodo&felis=placerat&fusce=praesent&posuere=blandit&felis=nam&sed=nulla&lacus=integer&morbi=pede&sem=justo&mauris=lacinia	22.46
435399461-1	The Hobbit	Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.	http://dropbox.com/erat/volutpat/in/congue/etiam/justo.jpg?vitae=integer&nisi=tincidunt&nam=ante&ultrices=vel&libero=ipsum&non=praesent&mattis=blandit&pulvinar=lacinia&nulla=erat&pede=vestibulum&ullamcorper=sed&augue=magna&a=at&suscipit=nunc&nulla=commodo&elit=placerat&ac=praesent&nulla=blandit&sed=nam&vel=nulla&enim=integer&sit=pede&amet=justo&nunc=lacinia	9.81
779725567-9	Moby Dick	Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.	http://mysql.com/duis/faucibus/accumsan/odio.jsp?posuere=praesent&metus=blandit&vitae=lacinia&ipsum=erat&aliquam=vestibulum&non=sed&mauris=magna&morbi=at&non=nunc&lectus=commodo&aliquam=placerat&sit=praesent&amet=blandit&diam=nam&in=nulla&magna=integer&bibendum=pede&imperdiet=justo&nullam=lacinia&orci=eget&pede=tincidunt&venenatis=eget&non=tempus&sodales=vel&sed=pede&tincidunt=morbi&eu=porttitor&felis=lorem&fusce=id&posuere=ligula&felis=suspendisse&sed=ornare	6.48
154830619-3	The Hunger Games	Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.	https://printfriendly.com/et/ultrices/posuere/cubilia.png?ligula=vel&sit=est&amet=donec&eleifend=odio	16.09
436000431-1	The Da Vinci Code	Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.	https://com.com/donec/vitae/nisi/nam/ultrices/libero/non.jsp?integer=primis&non=in&velit=faucibus&donec=orci&diam=luctus&neque=et&vestibulum=ultrices&eget=posuere&vulputate=cubilia&ut=curae&ultrices=duis&vel=faucibus&augue=accumsan&vestibulum=odio&ante=curabitur&ipsum=convallis&primis=duis&in=consequat&faucibus=dui&orci=nec&luctus=nisi&et=volutpat&ultrices=eleifend&posuere=donec&cubilia=ut&curae=dolor&donec=morbi&pharetra=vel&magna=lectus&vestibulum=in&aliquet=quam&ultrices=fringilla&erat=rhoncus&tortor=mauris&sollicitudin=enim&mi=leo&sit=rhoncus&amet=sed&lobortis=vestibulum	77.33
226218219-1	The Lord of the Rings	Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.	https://sun.com/rutrum/at/lorem/integer/tincidunt/ante/vel.jpg?neque=et&duis=ultrices&bibendum=posuere&morbi=cubilia&non=curae&quam=nulla&nec=dapibus&dui=dolor&luctus=vel&rutrum=est&nulla=donec&tellus=odio&in=justo&sagittis=sollicitudin&dui=ut&vel=suscipit&nisl=a&duis=feugiat&ac=et&nibh=eros&fusce=vestibulum&lacus=ac&purus=est&aliquet=lacinia&at=nisi&feugiat=venenatis&non=tristique&pretium=fusce&quis=congue&lectus=diam&suspendisse=id&potenti=ornare&in=imperdiet&eleifend=sapien&quam=urna&a=pretium&odio=nisl&in=ut&hac=volutpat&habitasse=sapien&platea=arcu&dictumst=sed&maecenas=augue&ut=aliquam&massa=erat&quis=volutpat&augue=in&luctus=congue&tincidunt=etiam&nulla=justo&mollis=etiam&molestie=pretium&lorem=iaculis&quisque=justo&ut=in&erat=hac&curabitur=habitasse&gravida=platea&nisi=dictumst&at=etiam&nibh=faucibus&in=cursus&hac=urna&habitasse=ut&platea=tellus&dictumst=nulla&aliquam=ut&augue=erat&quam=id&sollicitudin=mauris&vitae=vulputate&consectetuer=elementum&eget=nullam&rutrum=varius&at=nulla&lorem=facilisi&integer=cras&tincidunt=non&ante=velit&vel=nec&ipsum=nisi&praesent=vulputate&blandit=nonummy&lacinia=maecenas&erat=tincidunt&vestibulum=lacus&sed=at&magna=velit&at=vivamus&nunc=vel&commodo=nulla&placerat=eget&praesent=eros&blandit=elementum&nam=pellentesque	12.26
303500591-5	Gone with the Wind	Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.	https://prweb.com/nulla.png?quis=ut&libero=dolor&nullam=morbi&sit=vel&amet=lectus&turpis=in&elementum=quam&ligula=fringilla&vehicula=rhoncus&consequat=mauris&morbi=enim&a=leo&ipsum=rhoncus&integer=sed&a=vestibulum&nibh=sit&in=amet&quis=cursus&justo=id&maecenas=turpis&rhoncus=integer&aliquam=aliquet&lacus=massa&morbi=id&quis=lobortis&tortor=convallis&id=tortor&nulla=risus&ultrices=dapibus&aliquet=augue&maecenas=vel&leo=accumsan&odio=tellus&condimentum=nisi&id=eu&luctus=orci&nec=mauris&molestie=lacinia&sed=sapien&justo=quis&pellentesque=libero&viverra=nullam&pede=sit&ac=amet&diam=turpis&cras=elementum&pellentesque=ligula&volutpat=vehicula&dui=consequat&maecenas=morbi&tristique=a&est=ipsum&et=integer&tempus=a&semper=nibh&est=in&quam=quis&pharetra=justo&magna=maecenas&ac=rhoncus&consequat=aliquam&metus=lacus&sapien=morbi&ut=quis&nunc=tortor&vestibulum=id&ante=nulla&ipsum=ultrices&primis=aliquet&in=maecenas&faucibus=leo&orci=odio&luctus=condimentum&et=id&ultrices=luctus&posuere=nec&cubilia=molestie&curae=sed&mauris=justo&viverra=pellentesque&diam=viverra&vitae=pede&quam=ac&suspendisse=diam&potenti=cras&nullam=pellentesque&porttitor=volutpat&lacus=dui	93.62
891839219-2	The Alchemist	Vivamus vel nulla eget eros elementum pellentesque.	https://irs.gov/felis/sed/lacus/morbi/sem/mauris/laoreet.jpg?morbi=non&sem=ligula&mauris=pellentesque&laoreet=ultrices&ut=phasellus&rhoncus=id&aliquet=sapien&pulvinar=in&sed=sapien&nisl=iaculis&nunc=congue&rhoncus=vivamus&dui=metus&vel=arcu&sem=adipiscing&sed=molestie&sagittis=hendrerit&nam=at&congue=vulputate&risus=vitae&semper=nisl&porta=aenean&volutpat=lectus&quam=pellentesque&pede=eget&lobortis=nunc&ligula=donec&sit=quis&amet=orci&eleifend=eget&pede=orci&libero=vehicula&quis=condimentum&orci=curabitur&nullam=in&molestie=libero&nibh=ut&in=massa&lectus=volutpat&pellentesque=convallis&at=morbi&nulla=odio&suspendisse=odio&potenti=elementum&cras=eu&in=interdum&purus=eu&eu=tincidunt&magna=in&vulputate=leo&luctus=maecenas&cum=pulvinar&sociis=lobortis&natoque=est&penatibus=phasellus&et=sit&magnis=amet&dis=erat&parturient=nulla&montes=tempus	88.60
743901110-4	The Girl with the Dragon Tattoo	Duis consequat dui nec nisi volutpat eleifend.	https://baidu.com/ac/tellus.xml?interdum=justo&mauris=sollicitudin&non=ut&ligula=suscipit&pellentesque=a&ultrices=feugiat&phasellus=et&id=eros&sapien=vestibulum&in=ac&sapien=est&iaculis=lacinia&congue=nisi&vivamus=venenatis	69.75
075071435-2	The Fault in Our Stars	Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.	http://umich.edu/nisi/venenatis/tristique.html?elit=pede&sodales=lobortis&scelerisque=ligula&mauris=sit&sit=amet&amet=eleifend&eros=pede&suspendisse=libero&accumsan=quis&tortor=orci&quis=nullam&turpis=molestie&sed=nibh&ante=in&vivamus=lectus&tortor=pellentesque&duis=at&mattis=nulla&egestas=suspendisse&metus=potenti&aenean=cras&fermentum=in&donec=purus&ut=eu&mauris=magna&eget=vulputate&massa=luctus&tempor=cum&convallis=sociis&nulla=natoque&neque=penatibus&libero=et&convallis=magnis&eget=dis&eleifend=parturient&luctus=montes&ultricies=nascetur&eu=ridiculus&nibh=mus&quisque=vivamus&id=vestibulum&justo=sagittis&sit=sapien&amet=cum&sapien=sociis&dignissim=natoque&vestibulum=penatibus&vestibulum=et&ante=magnis&ipsum=dis&primis=parturient&in=montes&faucibus=nascetur&orci=ridiculus&luctus=mus&et=etiam&ultrices=vel&posuere=augue&cubilia=vestibulum&curae=rutrum&nulla=rutrum&dapibus=neque&dolor=aenean&vel=auctor&est=gravida&donec=sem&odio=praesent&justo=id&sollicitudin=massa&ut=id&suscipit=nisl&a=venenatis&feugiat=lacinia&et=aenean&eros=sit&vestibulum=amet	60.09
222710781-2	The Chronicles of Narnia	Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.	https://uiuc.edu/lacus/at/velit/vivamus.jsp?nunc=sollicitudin&proin=ut&at=suscipit&turpis=a&a=feugiat&pede=et&posuere=eros&nonummy=vestibulum&integer=ac&non=est&velit=lacinia&donec=nisi&diam=venenatis	65.75
225672602-9	The Kite Runner	Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.	http://example.com/sagittis/sapien/cum/sociis.xml?a=nulla&ipsum=facilisi&integer=cras&a=non&nibh=velit&in=nec&quis=nisi&justo=vulputate&maecenas=nonummy&rhoncus=maecenas&aliquam=tincidunt&lacus=lacus&morbi=at&quis=velit&tortor=vivamus&id=vel&nulla=nulla&ultrices=eget&aliquet=eros&maecenas=elementum&leo=pellentesque&odio=quisque&condimentum=porta&id=volutpat&luctus=erat&nec=quisque&molestie=erat	37.19
304107594-6	The Shining	Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.	https://over-blog.com/sociis/natoque/penatibus/et.json?vivamus=amet&vel=lobortis&nulla=sapien&eget=sapien&eros=non&elementum=mi&pellentesque=integer&quisque=ac&porta=neque&volutpat=duis&erat=bibendum&quisque=morbi&erat=non&eros=quam&viverra=nec&eget=dui&congue=luctus&eget=rutrum&semper=nulla&rutrum=tellus&nulla=in&nunc=sagittis&purus=dui&phasellus=vel&in=nisl&felis=duis&donec=ac&semper=nibh&sapien=fusce&a=lacus&libero=purus&nam=aliquet&dui=at&proin=feugiat&leo=non&odio=pretium&porttitor=quis&id=lectus&consequat=suspendisse&in=potenti&consequat=in&ut=eleifend&nulla=quam&sed=a&accumsan=odio&felis=in&ut=hac&at=habitasse&dolor=platea&quis=dictumst&odio=maecenas&consequat=ut&varius=massa&integer=quis&ac=augue&leo=luctus&pellentesque=tincidunt&ultrices=nulla&mattis=mollis&odio=molestie&donec=lorem&vitae=quisque&nisi=ut&nam=erat&ultrices=curabitur&libero=gravida&non=nisi&mattis=at&pulvinar=nibh&nulla=in&pede=hac&ullamcorper=habitasse&augue=platea&a=dictumst&suscipit=aliquam&nulla=augue&elit=quam&ac=sollicitudin&nulla=vitae&sed=consectetuer&vel=eget	35.38
431625063-9	Brave New World	Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.	http://home.pl/est.jsp?et=vestibulum&magnis=quam&dis=sapien&parturient=varius&montes=ut&nascetur=blandit&ridiculus=non&mus=interdum&vivamus=in&vestibulum=ante&sagittis=vestibulum&sapien=ante&cum=ipsum&sociis=primis&natoque=in&penatibus=faucibus&et=orci&magnis=luctus&dis=et&parturient=ultrices&montes=posuere&nascetur=cubilia&ridiculus=curae&mus=duis&etiam=faucibus&vel=accumsan&augue=odio&vestibulum=curabitur&rutrum=convallis&rutrum=duis&neque=consequat&aenean=dui&auctor=nec&gravida=nisi&sem=volutpat&praesent=eleifend&id=donec&massa=ut&id=dolor&nisl=morbi&venenatis=vel&lacinia=lectus	83.55
495033656-8	The Color Purple	Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.	http://stumbleupon.com/faucibus/accumsan/odio/curabitur.jpg?adipiscing=mi&lorem=integer&vitae=ac&mattis=neque&nibh=duis&ligula=bibendum&nec=morbi&sem=non&duis=quam&aliquam=nec&convallis=dui&nunc=luctus&proin=rutrum&at=nulla&turpis=tellus&a=in&pede=sagittis&posuere=dui&nonummy=vel&integer=nisl&non=duis&velit=ac&donec=nibh&diam=fusce&neque=lacus&vestibulum=purus&eget=aliquet&vulputate=at&ut=feugiat&ultrices=non&vel=pretium&augue=quis&vestibulum=lectus&ante=suspendisse&ipsum=potenti&primis=in&in=eleifend&faucibus=quam&orci=a&luctus=odio&et=in&ultrices=hac&posuere=habitasse&cubilia=platea&curae=dictumst&donec=maecenas&pharetra=ut&magna=massa&vestibulum=quis&aliquet=augue&ultrices=luctus&erat=tincidunt&tortor=nulla&sollicitudin=mollis&mi=molestie&sit=lorem&amet=quisque&lobortis=ut&sapien=erat&sapien=curabitur&non=gravida&mi=nisi&integer=at&ac=nibh&neque=in&duis=hac&bibendum=habitasse&morbi=platea&non=dictumst&quam=aliquam&nec=augue&dui=quam&luctus=sollicitudin&rutrum=vitae&nulla=consectetuer&tellus=eget&in=rutrum&sagittis=at&dui=lorem&vel=integer&nisl=tincidunt&duis=ante&ac=vel&nibh=ipsum&fusce=praesent&lacus=blandit&purus=lacinia&aliquet=erat&at=vestibulum&feugiat=sed	79.97
134502056-2	The Help	Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.	http://apple.com/est/phasellus/sit/amet/erat.jsp?sollicitudin=potenti&ut=nullam&suscipit=porttitor&a=lacus&feugiat=at&et=turpis&eros=donec&vestibulum=posuere&ac=metus&est=vitae&lacinia=ipsum&nisi=aliquam&venenatis=non&tristique=mauris&fusce=morbi&congue=non&diam=lectus&id=aliquam&ornare=sit&imperdiet=amet&sapien=diam&urna=in&pretium=magna&nisl=bibendum&ut=imperdiet&volutpat=nullam&sapien=orci&arcu=pede	98.90
660686815-7	The Road	Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.	https://hao123.com/sapien.js?habitasse=in&platea=congue&dictumst=etiam&morbi=justo&vestibulum=etiam&velit=pretium&id=iaculis&pretium=justo&iaculis=in&diam=hac&erat=habitasse&fermentum=platea&justo=dictumst&nec=etiam&condimentum=faucibus&neque=cursus&sapien=urna&placerat=ut&ante=tellus&nulla=nulla&justo=ut&aliquam=erat&quis=id&turpis=mauris&eget=vulputate&elit=elementum&sodales=nullam&scelerisque=varius&mauris=nulla&sit=facilisi&amet=cras&eros=non&suspendisse=velit&accumsan=nec&tortor=nisi&quis=vulputate&turpis=nonummy&sed=maecenas&ante=tincidunt&vivamus=lacus&tortor=at&duis=velit&mattis=vivamus&egestas=vel&metus=nulla&aenean=eget&fermentum=eros&donec=elementum&ut=pellentesque&mauris=quisque&eget=porta&massa=volutpat&tempor=erat&convallis=quisque&nulla=erat&neque=eros&libero=viverra&convallis=eget&eget=congue&eleifend=eget&luctus=semper&ultricies=rutrum&eu=nulla&nibh=nunc&quisque=purus&id=phasellus&justo=in&sit=felis&amet=donec&sapien=semper&dignissim=sapien&vestibulum=a&vestibulum=libero&ante=nam&ipsum=dui&primis=proin&in=leo&faucibus=odio&orci=porttitor&luctus=id&et=consequat&ultrices=in&posuere=consequat&cubilia=ut&curae=nulla&nulla=sed&dapibus=accumsan&dolor=felis&vel=ut	29.22
294068275-5	The Grapes of Wrath	Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.	http://yahoo.com/praesent.png?consequat=sapien&morbi=a&a=libero&ipsum=nam&integer=dui&a=proin&nibh=leo&in=odio&quis=porttitor&justo=id&maecenas=consequat&rhoncus=in&aliquam=consequat&lacus=ut&morbi=nulla&quis=sed	94.30
095795420-4	The Picture of Dorian Gray	Maecenas ut massa quis augue luctus tincidunt.	http://addtoany.com/donec/odio/justo.json?proin=in&risus=quam&praesent=fringilla&lectus=rhoncus&vestibulum=mauris&quam=enim&sapien=leo&varius=rhoncus&ut=sed&blandit=vestibulum&non=sit&interdum=amet&in=cursus&ante=id&vestibulum=turpis&ante=integer&ipsum=aliquet&primis=massa&in=id	68.94
461330545-4	The Sun Also Rises	Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.	https://newyorker.com/diam/cras.aspx?placerat=duis&ante=bibendum&nulla=morbi&justo=non&aliquam=quam&quis=nec&turpis=dui&eget=luctus&elit=rutrum&sodales=nulla&scelerisque=tellus&mauris=in&sit=sagittis&amet=dui&eros=vel&suspendisse=nisl&accumsan=duis&tortor=ac&quis=nibh&turpis=fusce&sed=lacus&ante=purus&vivamus=aliquet&tortor=at&duis=feugiat&mattis=non&egestas=pretium&metus=quis&aenean=lectus&fermentum=suspendisse&donec=potenti&ut=in&mauris=eleifend&eget=quam&massa=a&tempor=odio&convallis=in&nulla=hac	65.83
206829829-5	The Bell Jar	Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.	http://taobao.com/donec/vitae.html?in=eget&hac=congue&habitasse=eget&platea=semper&dictumst=rutrum&etiam=nulla&faucibus=nunc&cursus=purus	84.51
269591809-7	The Handmaid's Tale	Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.	https://wix.com/quam/suspendisse/potenti/nullam/porttitor.html?imperdiet=neque&nullam=libero&orci=convallis&pede=eget&venenatis=eleifend&non=luctus&sodales=ultricies&sed=eu&tincidunt=nibh&eu=quisque&felis=id&fusce=justo&posuere=sit&felis=amet&sed=sapien&lacus=dignissim&morbi=vestibulum&sem=vestibulum&mauris=ante&laoreet=ipsum&ut=primis&rhoncus=in&aliquet=faucibus&pulvinar=orci&sed=luctus&nisl=et&nunc=ultrices&rhoncus=posuere&dui=cubilia&vel=curae&sem=nulla&sed=dapibus&sagittis=dolor&nam=vel&congue=est&risus=donec&semper=odio&porta=justo&volutpat=sollicitudin&quam=ut&pede=suscipit&lobortis=a&ligula=feugiat&sit=et&amet=eros&eleifend=vestibulum&pede=ac&libero=est&quis=lacinia&orci=nisi&nullam=venenatis&molestie=tristique&nibh=fusce&in=congue&lectus=diam&pellentesque=id&at=ornare&nulla=imperdiet&suspendisse=sapien&potenti=urna&cras=pretium&in=nisl&purus=ut&eu=volutpat&magna=sapien&vulputate=arcu&luctus=sed&cum=augue&sociis=aliquam&natoque=erat&penatibus=volutpat&et=in	39.48
145797554-8	The Stand	Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.	https://wired.com/amet/sapien/dignissim/vestibulum/vestibulum/ante/ipsum.png?est=sapien&risus=cum&auctor=sociis&sed=natoque&tristique=penatibus&in=et&tempus=magnis&sit=dis&amet=parturient&sem=montes&fusce=nascetur&consequat=ridiculus&nulla=mus&nisl=etiam&nunc=vel&nisl=augue&duis=vestibulum&bibendum=rutrum&felis=rutrum&sed=neque&interdum=aenean&venenatis=auctor&turpis=gravida&enim=sem&blandit=praesent&mi=id&in=massa&porttitor=id&pede=nisl&justo=venenatis&eu=lacinia&massa=aenean&donec=sit&dapibus=amet&duis=justo&at=morbi&velit=ut&eu=odio&est=cras&congue=mi&elementum=pede&in=malesuada&hac=in&habitasse=imperdiet&platea=et&dictumst=commodo&morbi=vulputate&vestibulum=justo&velit=in&id=blandit&pretium=ultrices&iaculis=enim&diam=lorem&erat=ipsum&fermentum=dolor&justo=sit&nec=amet	34.97
506371457-9	The Lovely Bones	Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.	http://plala.or.jp/dolor/vel/est/donec/odio.jsp?platea=sit&dictumst=amet&aliquam=eros&augue=suspendisse&quam=accumsan&sollicitudin=tortor&vitae=quis&consectetuer=turpis&eget=sed&rutrum=ante&at=vivamus&lorem=tortor&integer=duis&tincidunt=mattis&ante=egestas&vel=metus&ipsum=aenean&praesent=fermentum&blandit=donec&lacinia=ut&erat=mauris&vestibulum=eget&sed=massa&magna=tempor&at=convallis&nunc=nulla	76.48
101990666-9	The Old Man and the Sea	Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.	https://disqus.com/donec.js?lobortis=tempus&convallis=vel&tortor=pede&risus=morbi&dapibus=porttitor&augue=lorem&vel=id&accumsan=ligula&tellus=suspendisse&nisi=ornare&eu=consequat&orci=lectus&mauris=in&lacinia=est&sapien=risus&quis=auctor&libero=sed&nullam=tristique&sit=in&amet=tempus&turpis=sit&elementum=amet&ligula=sem&vehicula=fusce&consequat=consequat&morbi=nulla&a=nisl&ipsum=nunc&integer=nisl	18.69
452143153-4	The Outsiders	Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.	http://apple.com/a/suscipit/nulla/elit/ac/nulla/sed.jpg?ultrices=dictumst&posuere=morbi&cubilia=vestibulum&curae=velit&nulla=id&dapibus=pretium&dolor=iaculis&vel=diam&est=erat&donec=fermentum&odio=justo&justo=nec&sollicitudin=condimentum&ut=neque&suscipit=sapien&a=placerat&feugiat=ante&et=nulla&eros=justo&vestibulum=aliquam&ac=quis&est=turpis&lacinia=eget&nisi=elit&venenatis=sodales&tristique=scelerisque&fusce=mauris&congue=sit&diam=amet&id=eros&ornare=suspendisse&imperdiet=accumsan&sapien=tortor&urna=quis&pretium=turpis&nisl=sed&ut=ante&volutpat=vivamus&sapien=tortor&arcu=duis&sed=mattis&augue=egestas&aliquam=metus&erat=aenean&volutpat=fermentum&in=donec&congue=ut&etiam=mauris&justo=eget&etiam=massa&pretium=tempor&iaculis=convallis&justo=nulla&in=neque&hac=libero&habitasse=convallis	16.89
318045442-3	The Glass Castle	Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.	https://taobao.com/dui/nec/nisi.json?eros=sed&elementum=ante&pellentesque=vivamus&quisque=tortor&porta=duis&volutpat=mattis&erat=egestas&quisque=metus&erat=aenean&eros=fermentum&viverra=donec&eget=ut&congue=mauris&eget=eget&semper=massa&rutrum=tempor&nulla=convallis&nunc=nulla&purus=neque&phasellus=libero&in=convallis	72.61
778490071-6	The Martian	Etiam faucibus cursus urna.	http://baidu.com/aliquam/non/mauris.xml?tortor=tincidunt&risus=lacus&dapibus=at&augue=velit&vel=vivamus&accumsan=vel&tellus=nulla&nisi=eget&eu=eros&orci=elementum&mauris=pellentesque&lacinia=quisque&sapien=porta&quis=volutpat&libero=erat&nullam=quisque&sit=erat&amet=eros&turpis=viverra&elementum=eget&ligula=congue&vehicula=eget	67.98
779316129-7	The Night Circus	Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.	http://imgur.com/mi/sit/amet/lobortis.jpg?primis=nunc&in=rhoncus&faucibus=dui&orci=vel&luctus=sem&et=sed&ultrices=sagittis&posuere=nam&cubilia=congue&curae=risus&nulla=semper&dapibus=porta&dolor=volutpat&vel=quam&est=pede&donec=lobortis&odio=ligula&justo=sit&sollicitudin=amet&ut=eleifend&suscipit=pede&a=libero&feugiat=quis&et=orci&eros=nullam&vestibulum=molestie&ac=nibh&est=in&lacinia=lectus&nisi=pellentesque&venenatis=at&tristique=nulla&fusce=suspendisse&congue=potenti&diam=cras&id=in&ornare=purus&imperdiet=eu&sapien=magna&urna=vulputate&pretium=luctus&nisl=cum&ut=sociis&volutpat=natoque&sapien=penatibus&arcu=et&sed=magnis&augue=dis&aliquam=parturient&erat=montes&volutpat=nascetur&in=ridiculus&congue=mus&etiam=vivamus&justo=vestibulum&etiam=sagittis&pretium=sapien&iaculis=cum&justo=sociis&in=natoque	82.77
301792926-4	The Goldfinch	Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.	https://sogou.com/massa/id/lobortis/convallis/tortor.json?euismod=enim&scelerisque=leo&quam=rhoncus&turpis=sed&adipiscing=vestibulum&lorem=sit&vitae=amet&mattis=cursus&nibh=id&ligula=turpis&nec=integer&sem=aliquet&duis=massa&aliquam=id&convallis=lobortis&nunc=convallis&proin=tortor&at=risus&turpis=dapibus&a=augue&pede=vel&posuere=accumsan&nonummy=tellus&integer=nisi&non=eu&velit=orci&donec=mauris&diam=lacinia&neque=sapien&vestibulum=quis&eget=libero&vulputate=nullam&ut=sit&ultrices=amet&vel=turpis&augue=elementum&vestibulum=ligula&ante=vehicula&ipsum=consequat&primis=morbi&in=a&faucibus=ipsum&orci=integer&luctus=a&et=nibh&ultrices=in&posuere=quis&cubilia=justo&curae=maecenas&donec=rhoncus&pharetra=aliquam&magna=lacus&vestibulum=morbi&aliquet=quis&ultrices=tortor&erat=id&tortor=nulla&sollicitudin=ultrices&mi=aliquet&sit=maecenas&amet=leo&lobortis=odio&sapien=condimentum&sapien=id&non=luctus&mi=nec&integer=molestie&ac=sed&neque=justo&duis=pellentesque&bibendum=viverra&morbi=pede&non=ac&quam=diam&nec=cras&dui=pellentesque&luctus=volutpat&rutrum=dui&nulla=maecenas&tellus=tristique&in=est&sagittis=et&dui=tempus&vel=semper&nisl=est&duis=quam&ac=pharetra&nibh=magna&fusce=ac&lacus=consequat&purus=metus	7.17
063014273-4	The Book Thief	Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.	http://java.com/massa/quis/augue.aspx?nascetur=commodo&ridiculus=placerat&mus=praesent&vivamus=blandit&vestibulum=nam&sagittis=nulla&sapien=integer&cum=pede&sociis=justo&natoque=lacinia&penatibus=eget&et=tincidunt&magnis=eget&dis=tempus&parturient=vel&montes=pede&nascetur=morbi&ridiculus=porttitor&mus=lorem&etiam=id&vel=ligula&augue=suspendisse&vestibulum=ornare&rutrum=consequat&rutrum=lectus&neque=in&aenean=est&auctor=risus&gravida=auctor&sem=sed&praesent=tristique&id=in&massa=tempus&id=sit&nisl=amet&venenatis=sem&lacinia=fusce&aenean=consequat&sit=nulla&amet=nisl&justo=nunc&morbi=nisl&ut=duis&odio=bibendum&cras=felis&mi=sed&pede=interdum&malesuada=venenatis&in=turpis&imperdiet=enim&et=blandit&commodo=mi&vulputate=in&justo=porttitor&in=pede&blandit=justo&ultrices=eu&enim=massa&lorem=donec&ipsum=dapibus&dolor=duis&sit=at&amet=velit&consectetuer=eu&adipiscing=est&elit=congue&proin=elementum&interdum=in&mauris=hac&non=habitasse&ligula=platea&pellentesque=dictumst&ultrices=morbi&phasellus=vestibulum&id=velit&sapien=id	70.17
449687655-8	The Giver	Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.	https://deviantart.com/faucibus/orci.jpg?imperdiet=integer&et=a&commodo=nibh&vulputate=in&justo=quis&in=justo&blandit=maecenas&ultrices=rhoncus&enim=aliquam&lorem=lacus&ipsum=morbi&dolor=quis&sit=tortor	60.51
724679144-2	The Time Traveler's Wife	Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.	https://mapquest.com/aliquet/pulvinar/sed.aspx?justo=et&eu=ultrices&massa=posuere&donec=cubilia&dapibus=curae&duis=mauris&at=viverra&velit=diam&eu=vitae&est=quam&congue=suspendisse&elementum=potenti&in=nullam&hac=porttitor&habitasse=lacus&platea=at&dictumst=turpis&morbi=donec&vestibulum=posuere&velit=metus&id=vitae&pretium=ipsum&iaculis=aliquam&diam=non&erat=mauris&fermentum=morbi&justo=non&nec=lectus&condimentum=aliquam&neque=sit&sapien=amet&placerat=diam&ante=in&nulla=magna&justo=bibendum&aliquam=imperdiet&quis=nullam&turpis=orci&eget=pede&elit=venenatis&sodales=non&scelerisque=sodales&mauris=sed&sit=tincidunt&amet=eu&eros=felis&suspendisse=fusce&accumsan=posuere&tortor=felis&quis=sed&turpis=lacus&sed=morbi&ante=sem&vivamus=mauris&tortor=laoreet&duis=ut&mattis=rhoncus&egestas=aliquet&metus=pulvinar&aenean=sed&fermentum=nisl&donec=nunc&ut=rhoncus&mauris=dui&eget=vel&massa=sem&tempor=sed&convallis=sagittis&nulla=nam&neque=congue&libero=risus&convallis=semper&eget=porta&eleifend=volutpat&luctus=quam&ultricies=pede&eu=lobortis&nibh=ligula&quisque=sit&id=amet&justo=eleifend&sit=pede&amet=libero&sapien=quis	24.55
040159971-X	The Princess Bride	Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.	http://latimes.com/primis/in/faucibus/orci/luctus/et.json?lobortis=volutpat&est=eleifend&phasellus=donec&sit=ut&amet=dolor&erat=morbi&nulla=vel&tempus=lectus&vivamus=in	75.30
319769295-0	The Hitchhiker's Guide to the Galaxy	Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.	http://biglobe.ne.jp/venenatis/turpis/enim/blandit/mi.js?quam=sed&pharetra=lacus&magna=morbi&ac=sem&consequat=mauris&metus=laoreet&sapien=ut&ut=rhoncus&nunc=aliquet&vestibulum=pulvinar&ante=sed&ipsum=nisl&primis=nunc&in=rhoncus&faucibus=dui&orci=vel&luctus=sem&et=sed&ultrices=sagittis&posuere=nam&cubilia=congue&curae=risus&mauris=semper&viverra=porta&diam=volutpat&vitae=quam&quam=pede&suspendisse=lobortis&potenti=ligula&nullam=sit&porttitor=amet&lacus=eleifend&at=pede&turpis=libero&donec=quis&posuere=orci&metus=nullam&vitae=molestie&ipsum=nibh&aliquam=in&non=lectus&mauris=pellentesque&morbi=at&non=nulla&lectus=suspendisse&aliquam=potenti&sit=cras&amet=in&diam=purus&in=eu&magna=magna&bibendum=vulputate&imperdiet=luctus&nullam=cum&orci=sociis&pede=natoque&venenatis=penatibus&non=et&sodales=magnis&sed=dis&tincidunt=parturient&eu=montes&felis=nascetur&fusce=ridiculus&posuere=mus&felis=vivamus&sed=vestibulum&lacus=sagittis&morbi=sapien&sem=cum&mauris=sociis&laoreet=natoque&ut=penatibus&rhoncus=et&aliquet=magnis&pulvinar=dis&sed=parturient&nisl=montes&nunc=nascetur&rhoncus=ridiculus&dui=mus&vel=etiam&sem=vel&sed=augue&sagittis=vestibulum&nam=rutrum&congue=rutrum&risus=neque&semper=aenean&porta=auctor	24.56
190891590-0	The Scarlet Letter	Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.	http://360.cn/tristique/est/et.html?ac=neque&consequat=aenean&metus=auctor&sapien=gravida&ut=sem&nunc=praesent&vestibulum=id&ante=massa&ipsum=id&primis=nisl&in=venenatis&faucibus=lacinia&orci=aenean&luctus=sit&et=amet&ultrices=justo&posuere=morbi&cubilia=ut&curae=odio&mauris=cras&viverra=mi&diam=pede&vitae=malesuada&quam=in&suspendisse=imperdiet&potenti=et&nullam=commodo&porttitor=vulputate&lacus=justo&at=in&turpis=blandit&donec=ultrices&posuere=enim&metus=lorem&vitae=ipsum&ipsum=dolor&aliquam=sit&non=amet&mauris=consectetuer&morbi=adipiscing&non=elit	87.61
269742664-7	The Jungle Book	Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.	http://surveymonkey.com/euismod/scelerisque/quam/turpis/adipiscing.js?sapien=integer&dignissim=non&vestibulum=velit&vestibulum=donec&ante=diam&ipsum=neque&primis=vestibulum&in=eget&faucibus=vulputate&orci=ut&luctus=ultrices&et=vel&ultrices=augue&posuere=vestibulum&cubilia=ante&curae=ipsum&nulla=primis&dapibus=in&dolor=faucibus&vel=orci&est=luctus&donec=et&odio=ultrices&justo=posuere&sollicitudin=cubilia&ut=curae&suscipit=donec&a=pharetra&feugiat=magna&et=vestibulum&eros=aliquet&vestibulum=ultrices&ac=erat&est=tortor&lacinia=sollicitudin&nisi=mi&venenatis=sit&tristique=amet&fusce=lobortis&congue=sapien&diam=sapien&id=non&ornare=mi&imperdiet=integer&sapien=ac&urna=neque&pretium=duis&nisl=bibendum&ut=morbi&volutpat=non&sapien=quam&arcu=nec&sed=dui&augue=luctus&aliquam=rutrum&erat=nulla&volutpat=tellus&in=in&congue=sagittis&etiam=dui&justo=vel&etiam=nisl&pretium=duis&iaculis=ac&justo=nibh&in=fusce&hac=lacus&habitasse=purus&platea=aliquet&dictumst=at&etiam=feugiat&faucibus=non&cursus=pretium&urna=quis&ut=lectus&tellus=suspendisse&nulla=potenti&ut=in&erat=eleifend&id=quam&mauris=a&vulputate=odio&elementum=in&nullam=hac&varius=habitasse&nulla=platea&facilisi=dictumst&cras=maecenas&non=ut&velit=massa	47.25
179113873-X	The Count of Monte Cristo	Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.	https://abc.net.au/erat.jsp?fusce=quisque&consequat=erat&nulla=eros&nisl=viverra&nunc=eget&nisl=congue&duis=eget&bibendum=semper&felis=rutrum&sed=nulla&interdum=nunc&venenatis=purus&turpis=phasellus&enim=in&blandit=felis&mi=donec&in=semper&porttitor=sapien&pede=a&justo=libero&eu=nam&massa=dui&donec=proin&dapibus=leo&duis=odio&at=porttitor&velit=id&eu=consequat&est=in&congue=consequat&elementum=ut&in=nulla&hac=sed&habitasse=accumsan&platea=felis&dictumst=ut&morbi=at&vestibulum=dolor&velit=quis&id=odio&pretium=consequat&iaculis=varius&diam=integer&erat=ac&fermentum=leo&justo=pellentesque&nec=ultrices&condimentum=mattis&neque=odio&sapien=donec&placerat=vitae&ante=nisi&nulla=nam&justo=ultrices&aliquam=libero&quis=non&turpis=mattis&eget=pulvinar&elit=nulla&sodales=pede&scelerisque=ullamcorper&mauris=augue&sit=a&amet=suscipit&eros=nulla&suspendisse=elit&accumsan=ac&tortor=nulla&quis=sed&turpis=vel&sed=enim&ante=sit&vivamus=amet&tortor=nunc&duis=viverra&mattis=dapibus&egestas=nulla&metus=suscipit&aenean=ligula&fermentum=in&donec=lacus&ut=curabitur&mauris=at	71.11
699686500-X	The Secret Life of Bees	Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.	http://unicef.org/pellentesque/viverra/pede/ac/diam/cras/pellentesque.html?volutpat=sodales&erat=sed&quisque=tincidunt&erat=eu&eros=felis&viverra=fusce&eget=posuere&congue=felis&eget=sed&semper=lacus&rutrum=morbi&nulla=sem&nunc=mauris&purus=laoreet&phasellus=ut&in=rhoncus&felis=aliquet&donec=pulvinar&semper=sed&sapien=nisl&a=nunc&libero=rhoncus&nam=dui&dui=vel&proin=sem&leo=sed&odio=sagittis&porttitor=nam&id=congue&consequat=risus&in=semper&consequat=porta&ut=volutpat&nulla=quam&sed=pede&accumsan=lobortis&felis=ligula&ut=sit&at=amet&dolor=eleifend&quis=pede&odio=libero&consequat=quis&varius=orci&integer=nullam&ac=molestie&leo=nibh&pellentesque=in&ultrices=lectus&mattis=pellentesque&odio=at&donec=nulla&vitae=suspendisse&nisi=potenti	16.87
681639813-0	The Joy Luck Club	Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.	https://imgur.com/duis/mattis/egestas/metus/aenean.png?sapien=morbi&a=non&libero=quam&nam=nec&dui=dui&proin=luctus&leo=rutrum&odio=nulla&porttitor=tellus	88.98
446107995-3	The Sound and the Fury	Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.	https://mashable.com/sapien/varius/ut/blandit/non.png?volutpat=quisque&eleifend=porta&donec=volutpat&ut=erat&dolor=quisque&morbi=erat&vel=eros&lectus=viverra&in=eget&quam=congue&fringilla=eget&rhoncus=semper&mauris=rutrum&enim=nulla&leo=nunc&rhoncus=purus&sed=phasellus&vestibulum=in&sit=felis&amet=donec&cursus=semper&id=sapien&turpis=a&integer=libero&aliquet=nam&massa=dui&id=proin&lobortis=leo&convallis=odio&tortor=porttitor&risus=id&dapibus=consequat&augue=in&vel=consequat&accumsan=ut&tellus=nulla&nisi=sed&eu=accumsan	38.90
740453190-X	The Secret Garden	Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.	https://posterous.com/sed.jpg?duis=ut&bibendum=mauris&morbi=eget&non=massa&quam=tempor&nec=convallis&dui=nulla&luctus=neque&rutrum=libero&nulla=convallis&tellus=eget&in=eleifend&sagittis=luctus&dui=ultricies&vel=eu&nisl=nibh	82.75
324528178-1	The Great Gatsby	Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.	https://theglobeandmail.com/ante/ipsum.html?ipsum=a&praesent=ipsum&blandit=integer&lacinia=a&erat=nibh&vestibulum=in&sed=quis&magna=justo&at=maecenas&nunc=rhoncus&commodo=aliquam&placerat=lacus&praesent=morbi&blandit=quis&nam=tortor&nulla=id&integer=nulla&pede=ultrices&justo=aliquet&lacinia=maecenas&eget=leo&tincidunt=odio&eget=condimentum&tempus=id&vel=luctus&pede=nec&morbi=molestie&porttitor=sed&lorem=justo&id=pellentesque&ligula=viverra&suspendisse=pede&ornare=ac&consequat=diam&lectus=cras&in=pellentesque&est=volutpat&risus=dui&auctor=maecenas&sed=tristique&tristique=est&in=et&tempus=tempus&sit=semper&amet=est&sem=quam&fusce=pharetra&consequat=magna&nulla=ac&nisl=consequat&nunc=metus&nisl=sapien&duis=ut&bibendum=nunc&felis=vestibulum&sed=ante&interdum=ipsum&venenatis=primis&turpis=in&enim=faucibus&blandit=orci&mi=luctus&in=et&porttitor=ultrices&pede=posuere&justo=cubilia&eu=curae&massa=mauris&donec=viverra&dapibus=diam&duis=vitae&at=quam	47.88
268530109-7	Pride and Prejudice	Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.	http://google.it/vel/pede/morbi.aspx?elit=tortor&proin=duis&risus=mattis&praesent=egestas	97.39
\.


--
-- TOC entry 3654 (class 0 OID 24725)
-- Dependencies: 225
-- Data for Name: copy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.copy (copy_id, isbn, condition) FROM stdin;
1	208704344-2	new
2	577674073-8	good
3	708973808-6	used
4	331569357-9	used
5	096034064-5	used
6	490417166-7	new
7	125879241-9	new
8	435399461-1	used
9	779725567-9	used
10	154830619-3	new
11	436000431-1	new
12	226218219-1	new
13	303500591-5	used
14	891839219-2	used
15	743901110-4	new
16	075071435-2	new
17	222710781-2	good
18	225672602-9	good
19	304107594-6	new
20	431625063-9	new
21	495033656-8	good
22	134502056-2	new
23	660686815-7	used
24	294068275-5	used
25	095795420-4	new
26	461330545-4	good
27	206829829-5	new
28	269591809-7	good
29	145797554-8	used
30	506371457-9	new
31	101990666-9	good
32	452143153-4	used
33	318045442-3	good
34	778490071-6	used
35	779316129-7	new
36	301792926-4	used
37	063014273-4	good
38	449687655-8	good
39	724679144-2	used
40	040159971-X	used
41	319769295-0	good
42	190891590-0	new
43	269742664-7	new
44	179113873-X	new
45	699686500-X	used
46	681639813-0	new
47	446107995-3	good
48	740453190-X	good
49	324528178-1	good
50	268530109-7	used
\.


--
-- TOC entry 3656 (class 0 OID 24751)
-- Dependencies: 227
-- Data for Name: orders_copy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders_copy (order_id, copy_id) FROM stdin;
\.


--
-- TOC entry 3658 (class 0 OID 24822)
-- Dependencies: 229
-- Data for Name: purchases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchases (id, email, book_isbn, book_name, purchase_date) FROM stdin;
1	bye@gmail.com	075071435-2	The Fault in Our Stars	2024-12-02 19:12:11.400762
2	bye@gmail.com	075071435-2	The Fault in Our Stars	2024-12-02 19:12:35.536761
3	bye@gmail.com	040159971-X	The Princess Bride	2024-12-02 19:12:57.060959
4	nithinabburi@gmail.com	154830619-3	The Hunger Games	2024-12-02 22:10:21.778363
5	nithinnaksh@gmail.com	075071435-2	The Fault in Our Stars	2024-12-02 22:30:33.715703
6	have@g.com	063014273-4	The Book Thief	2024-12-02 22:39:29.984007
7	nithinabburi@gmail.com	075071435-2	The Fault in Our Stars	2024-12-03 12:00:55.807339
8	cwtt@gmail.com	095795420-4	The Picture of Dorian Gray	2024-12-03 12:04:26.763225
9	cwtt@gmail.com	063014273-4	The Book Thief	2024-12-03 17:11:29.288799
10	cwtt@gmail.com	304107594-6	The Shining	2024-12-03 17:12:01.427826
11	cwtt@gmail.com	660686815-7	The Road	2024-12-03 19:15:11.283425
12	hi@gmail.com	075071435-2	The Fault in Our Stars	2024-12-03 21:56:54.033606
13	cwtt@gmail.com	063014273-4	The Book Thief	2024-12-04 16:27:25.81141
14	gy@gmail.com	075071435-2	The Fault in Our Stars	2024-12-04 16:28:02.684739
15	slankir2@asu.edu	063014273-4	The Book Thief	2024-12-04 22:11:31.197564
16	cwtt@gmail.com	095795420-4	The Picture of Dorian Gray	2024-12-05 02:04:48.040168
17	cwtt@gmail.com	206829829-5	The Bell Jar	2024-12-06 00:42:34.651717
\.


--
-- TOC entry 3647 (class 0 OID 24691)
-- Dependencies: 218
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_account (email, name, password_hash) FROM stdin;
coulett0@smugmug.com	Christabel Oulett	425917baf507c4fcab36d11a0cd32dbb16a1a58ead6fcbc5656c56c4bbe0d4ca
ccherry1@topsy.com	Caroljean Cherry	9b648d5926b567a29c27ba7f0b89a603fe12d54772906cd1a7c58f6c24c712b6
emacquire2@cloudflare.com	Emmy Macquire	e5ab23554d79dcd8f3c4e4d246555f1e61f941b850ed36e9ef0f227cfe74577f
gsitford3@apple.com	George Sitford	eb3b8b04d907552d621d22da1ee8650bfb9cdf9d7e9e327a101b6bf7d6976557
asimounet5@imgur.com	Andromache Simounet	85b04b21bb3349359a0269a055449bfd9c59cf815a65f4ba77754ca6a7c51d27
srottcher6@cocolog-nifty.com	Sandye Rottcher	acef96d3137648e9db203d7ecb450898347f44090e913ae3dd217da49bca1417
mmozzetti7@sourceforge.net	Mommy Mozzetti	d866d6ebf45608df9121e8e21285f2b3da7e758166db3c09001785100ee24a7c
abirks8@eventbrite.com	Ave Birks	4c5e447de16b23c413a6d9d9a84b189aca84fdc963db944cfead32e13641dc07
oguilbert9@about.me	Owen Guilbert	593af0c7be52ba1fa44489f93624a53c08a1cee1068388edc2b62958121774f8
kdugalda@amazonaws.com	Keary Dugald	33f74beda1753ecd097b0b20ba06dcb4821d2600d15c28636792f846ff342cc6
ebourhillb@netvibes.com	Emogene Bourhill	cabe7ba9bd21c3f9a6f12d98cb2faa608500d4e9c1ce67d94521d1d8f4d278a1
welgramc@accuweather.com	Winston Elgram	b0afd1db40b1b7f69996359012e6ad9e10b85df56b8bc1da20b9b16dab14ec39
glightend@phoca.cz	Gerome Lighten	b1d044362a714b8e3eba40053b0467a46bff30bc309eb914538e819f714882ee
kfreiburgere@seesaa.net	Katleen Freiburger	4117404687c9ddefd51636d3ad3f44fde6694cdfd1aea0ea06e1209f0b2763ad
vmartignonif@livejournal.com	Vale Martignoni	95fb205b1b29bae6022440757ea5bf29e2a925ce8c06f79f9889cb93eb18fb23
rdafferng@huffingtonpost.com	Rene Daffern	713dc41af2252d31c95cca7b8c89561a6aba22b5da9b2f371b5fc86d4d056a81
glathwellh@washington.edu	Garv Lathwell	f3969ea64493e6b43b218b1761dfe96193dcfc5b3690ec5db853d4195a7d2d03
fchateri@e-recht24.de	Fidel Chater	5433019b4954d1102a66b9eeabbee5483b8f991f67e0fe613ba60fcba5f2c597
vgoodingej@stanford.edu	Viviyan Goodinge	ccadf0e35ee0331c564897a077ce2aad2f8095e51e34572043bd1c093196fbfd
gpeealessk@unesco.org	Gino Peealess	91913b78206c4b6cccfac36b2adcd6ee314eb356c974291d718bc835efde7e8f
cfoulstonel@sciencedaily.com	Cynthie Foulstone	4e72e49ced7507052fc6c863106a3459335a228d1344a112d438683f3c6303b4
mthurbym@domainmarket.com	Marylou Thurby	c414cbbf67c0a3121003c9e1b356b396002caba41c761f122cf117e3897a6916
tjedraszekn@loc.gov	Torrey Jedraszek	d43351007884afa710fe0c2126b99abe0ac643a8d108cf00f637de3697c70210
fburlingo@yale.edu	Farrell Burling	01f1772c6f9624928a3237a7e746f58f4585e26ad6e861da4554566b7c445c94
tferrieriop@rakuten.co.jp	Trisha Ferrierio	421b4244a77885afe1d8a7b8ac59aa69ea9b8353f2c0651908ef5b4e854561d6
ddudenieq@odnoklassniki.ru	Debbi Dudenie	19957f89ea31f2381581913f6008624925928075004d6a59fea4117a85312a85
tgorryr@flavors.me	Tierney Gorry	26ee4c59d67fdc4136fa79d9bedd432e4e68e62e51953fb4ac3dc3fdc77a2de6
lmarcinkowskis@archive.org	Lombard Marcinkowski	eb079ddbaa1459192682f610e3acef834ed1ac144ce35f376c89c4fc7348c004
mformiglit@accuweather.com	Marc Formigli	4dbfd02862d6f71729e061f1584ca56b8737da4b6e2f60a47748c8cff79b425f
bbusainu@themeforest.net	Berni Busain	46f7c2cbdaab63acb95c04eff5c6fb2aad008f5a21411508c0bd4114ea0a94c6
tbelchambersv@sohu.com	Terrijo Belchambers	88e6e5dcbff16b6fce9ea6a56932c2979c1a6c4482c6c6e0066216d48b609818
bbartrumw@amazon.de	Beck Bartrum	e1af5389afbf9c7567f9c43ef7f3e69d31dc392d8016bc143b0f45feeccbd842
nbrackenx@slashdot.org	Ninette Bracken	3e00e7f14a095f83f84ca7d5e14353c88b5c15ef5b9186e5dca7b92b36bf5533
omodeny@theguardian.com	Otis Moden	71d1ae250bd2dd8a1d503aed30b10566f6f9abbc8db0f37d6b69d3e0cad71843
tgrigoirez@engadget.com	Titus Grigoire	9725eaa34c40b001ff5b5c1928e88240222793ae6aedea385da95a8ecb2b3b0d
kkingswood10@aboutads.info	Karlotte Kingswood	120d9e960937d1e25f0074c59ac7042ddc34fd78d2f2ab852d49d296e36643b3
rcassella11@unc.edu	Redford Cassella	58118f7f826fa54d79da2d309188fd7434263745207967b4991531596566a03f
ahowgego12@yale.edu	Adolf Howgego	928fca3bb322fb0fa6b8c1c70a63d4735250f118e4605fb0b40f89ea37b3752f
khanhard13@is.gd	Kiel Hanhard	71c290aa76eb2b0927b8b4e6bf1d4ccd4944b93862aa33cdf6e9e6fd10f0e00e
sdadley14@livejournal.com	Saxe Dadley	0429d36942e4b9bcc3ec5eff2d95eb84f96a65faecbec452bd93d5152beb2505
lcraine15@dell.com	Levin Craine	58b1a0d9a62931a69ae0b56c0d8c1661a0ce98ab1e92a5ace322bbc9ddb10898
grosenfrucht16@shop-pro.jp	Gretchen Rosenfrucht	3e42e9fe360da303803395aa1f33039e5db65eb4698b80566ad75cb1caac1e42
epirelli17@abc.net.au	Elana Pirelli	cf480f6949ba5b336d45df9c772ea1cfca8169d59585337f21a55fdaca3ccf25
jbew18@cpanel.net	Jobina Bew	889363abcf3f71993b06f437bd4cc4ccc8a132b8f2b92401d793e85c97f4fb6d
kparr19@stumbleupon.com	Katerina Parr	2d425338170c64be4696442f1e7f47279bc87c4e8d0df51c25f51ffae2e4812f
hivashnyov1a@yolasite.com	Harlen Ivashnyov	c894c4c8fb21508d026a143c82e37387b15ddd5fcc6bdb9240ece4562e4fb452
pgrandham1b@imdb.com	Patin Grandham	1b98ff0eaabab987cf5f9b93bbf83658270d746f9e89482dcc178559fc5e892f
wde1c@qq.com	Welbie De Gogay	240e73d008cf570251bc4222dc9f4287505f8d1e31f5692f2b9cdfd8ebc7f83d
srobatham1d@unblog.fr	Storm Robatham	5c8a9429a77863f8b836ced631226e67e2fc7c2f2096be9ffc75a04731eac99b
dgadaud1e@sphinn.com	Donnie Gadaud	12bf97d22b6cb3119c8c251c725cf1b319676d1391b750c455643c63714aafa5
fbodechon1f@blog.com	Franky Bodechon	83dde98c0a9790241a1f76175bf1cc070a1ff5b92246e42aff27817c10512919
lcestard1g@time.com	Lammond Cestard	67a7d4875e05d58e872f9ebaa4b27fa6aab4e209a70da962ea9fb78035c321ea
fmanderson1h@shop-pro.jp	Felisha Manderson	f89b93fad29f8cdf4b248d9661111ba3f9d6c26d42c00187430bbc20197125f6
mgiacubo1i@elpais.com	Melva Giacubo	722d772aeb15be68fa99c2f3b75cfacb48a8092885d16f1c50578c4ab69981ce
mdenington1j@vkontakte.ru	Millisent Denington	83811b56683e329224af223ad31cd38376ad0d292ab11a4d6dbaea06c8a999c3
tbailiss1k@pcworld.com	Thekla Bailiss	8cfadc00bcfb71078332566f8412b824bf5a4a702be83713c42bdb74e11fab41
hde1l@mashable.com	Hilarius de Wilde	286d301f7168915c7c9302488ee855c77953f6fea4745f554f97aa9f669411d2
ssherwyn1m@ask.com	Sara-ann Sherwyn	5cbd8eda4ab4a78b55e1e1e2dc3ffb188c62ba6b64001b0bdd5fdc892d41af87
eandrzej1n@google.co.jp	Edythe Andrzej	85df130326c0a00e97d16ea03b5d6e0bbe6d294ac2c47e18ca550191c360e30f
astrode1o@imgur.com	Alphard Strode	7fd25a0451803149a2a6df1c23d6efc197a767f087a65628c5fdf264f97a9273
gschule1p@surveymonkey.com	Gertrud Schule	85402aaeced433205c8c7c8e27455b213d3c8c59ce8128a8611bbf3b7a665ae0
ddavidai1q@cpanel.net	Dodi Davidai	aba68b51a628a580d6c3849d0622fb3e0f61801555ea24883919a47dcf4900a0
ncatt1r@wired.com	Nerte Catt	a1e3a743d37897954ccda6e5ecc1cd703aae1c5608489aa1f6a30fc09031f44c
rdronsfield1s@yelp.com	Read Dronsfield	5d78cf92339ac5b9d27417c9d84e488af4aae3cebccf804835e3a8bc67972d4e
farne1t@histats.com	Farrand Arne	bbfb1eb0620f58fc8fdcb76b5c0056b793624ce8332a343510f387d358d5d5a1
aspraggon1u@ebay.co.uk	Atlanta Spraggon	19dc83d7674822e10bbba8713cbe6285a48b070b9bd2b14a11b4da4eca7d65f9
eblaes1v@usda.gov	Eustacia Blaes	db50fa9bb8071e5e4c29f33ee8afa19e9363d19019d8f04116ed763a1b355641
kbyram1w@nps.gov	Karrie Byram	b36a0aafd75b02508ea39fdae76161efcc977ec4bf84ddf1cbefc8d3bd3dea7d
achastelain1x@last.fm	Alain Chastelain	b631f903a2af5110d3692025296c913464b7a90592aa1f267c3d7c7c224eb454
wortell1y@mapy.cz	Windy Ortell	e94eb374c77df201b531adb60bcd0aab2cfe006a14b825645548550ac06845bd
lfaucherand1z@hatena.ne.jp	Lothaire Faucherand	ce0db6ab51cd2d4fd572e77844faceb1b0278afcc865d5312acc4fe0502fb017
bthorneloe20@webs.com	Brigg Thorneloe	c5f1be7483e78ff25245aa6b2cfdf008b9eb1c799fbbf65ffb5651a5e33d1f0b
sdyment21@51.la	Sheryl Dyment	963cbcacc9d2e0da5fbd14d456518c448c3b4d35041a4f63d7936d39066b8d4b
mrubke22@marriott.com	Marcela Rubke	8f7f5dd60ecaf9c4c91ac13a56f6447f63d5594926d0fe0a552f85709b7451a0
lhurcombe23@umich.edu	Lexine Hurcombe	fe2aeae2e662ebec0d2b6215f3d815ee071cd18eee3b954a1e5e9e47ae135429
mfilipiak24@discovery.com	Marika Filipiak	c690b8d4692928853107e473b1296ba7601379c7d4dfc3c08446bb13c58f48d7
pchastang25@indiatimes.com	Perceval Chastang	400244e69fbb164e8285be4a5e5c19c3c430d17fea16537b8b4dae5b68e20fd2
tdumbrall26@google.it	Tan Dumbrall	5c28988d13452c42fedc088eb29dd822240cfcdc1a68f6b6198494115a907859
molivello27@t-online.de	Mallory Olivello	387f855b6f1d9c1500a0ee41a6fd4786d6752eff12a59d2012b2dfcef5d1a5b2
jgundrey28@ow.ly	Jerrine Gundrey	b6f341df2f23b9bab07e759282ecbf0256613957fd7621bd780b8be9b57d5f08
ckunze29@t.co	Carrissa Kunze	b74cfce59dececc72f643f10a1fe1b40ca58a4ae44235290e43bddf42e7a3ef1
pfitzsimons2a@cisco.com	Pru Fitzsimons	a503acffe54a0f20a1fbe29628e7a3ecc578b5cf5d2e6ebd6f6c691fc3a8c7ab
bmeckiff2b@umn.edu	Bibbye Meckiff	35faba5da6162e0bfe44827243225a312f2d9df888b3af5520b7a2dc505d9960
nvankov2c@bravesites.com	Nikolai Vankov	256a880981d3add7d6c81d85f36a61f0912a8b2220598c0682efdcb2086d585f
kmckinn2d@goo.gl	Karry McKinn	134364c157adfa9ba221253d79a6553bc2452961435c09264279da2582b01d20
tpardue2e@stanford.edu	Tiffany Pardue	88ed5d2b595ff24c8575fa03aacdd8db553249e315bb602b1021951ba46a44d9
klanghorn2f@amazon.co.jp	Kylie Langhorn	95bcb669a643efe67ad01efe036c4264ac50f53d1ec196e68660fa7acc6b7d23
jondricek2g@census.gov	Joseito Ondricek	83b9ddbea62b25be7b869e43afb34c8864ad49f60df2332d273c855e6f976137
vfeeney2h@uol.com.br	Violetta Feeney	f0e1a127f211892a069390988fc59fab680bd61dcc08d4c74c318b2dd02cb405
cjosselsohn2i@newsvine.com	Cristi Josselsohn	d68a2379a61b80613ff3332b57aaceba61d93dcdf5e6b211713f4fe42e86ec7e
astenbridge2j@theatlantic.com	Alia Stenbridge	de5a09b0afa6c9677cf7a1b57b3b72161aff26fbe615ffa3b47923b6e801f148
aroberson2k@google.nl	Abramo Roberson	4e7c331d7e9a39087617729cde6e9f71503d077b0b8bf5497cb428f44e15cdeb
cendrizzi2l@discovery.com	Carola Endrizzi	31ca4d17cba81ddc2d7c3ee0a2427ef9895156009f976fbecd56f46cf50576a4
pmalins2m@google.co.jp	Padriac Malins	d18c6d656c9bec44c64c3b3b392a197945ec7a3bd44bda5bdd09a0b71ad5036d
gmazzey2n@archive.org	Galvan Mazzey	a424c1585b274d9dfd4e450df8056231df91eefb6981d37b3664a3518ea0557b
rcecchetelli2o@sourceforge.net	Ruggiero Cecchetelli	ee5ffca9f7051d1ad3d5b19db4234163dd4a1d68c4131a7f806885ac1881f442
eguillotin2p@nps.gov	Emile Guillotin	0d66c82aeb93fe18a64d69ff220bf04bcaa42afee07641f58492ef8884d1efcb
wbesset2q@sohu.com	Willamina Besset	1162ba680386b59e336a8f2f73be6bcccd6fa851b0ee8e0f9015bdf436cff79d
pjurczik2r@microsoft.com	Paula Jurczik	76cf6290463c4dcdee3400173022c293c2ba5819619db5a58c82164e3c56a688
kstranger4@bbb.org	NewName	0529bfc102e6dbff776d61e070b2b3091f3d12435e5cb2eb26192715a5071aa0
testuser@example.com	Test User	$2b$10$CvkAxE9f7jN0LUsz7fLBk.900X9E7qQkjN0oWQFfO9KtxILU.EqCe
nithinabburi@gmail.com	Nithin	$2b$10$vGot.LFFXib2FbguunJ24..7bCk8jprNexCWnQhEav62t4O0QUh8i
nabburi@asu.edu	Abburi	$2b$10$7kb9/jCI1DV1jSbY21Pi9ezcKR31ccwIIHD6FramkVltI/MgpZeTC
bgannava@asu.edu	Rishik	$2b$10$.V565e4JkJttj22k/lvHhuj2fK/n62/m3qEOiaYVIaCgaSQkc2TFy
nithin.abburi04@gmail.com	nithin	$2b$10$DQCCjpQV4uUoTTAuJp2fHu5T6ptGuTpLI6m6cqh0OUqoI/5qfIFEG
n@g.com	Nithin	$2b$10$gndd7sQmEFmJHKGtDzu3YOGKsWnYyUmrTiUfLrTRZdMi8ZdGBWrqW
bye@g.com	hi	$2b$10$gJx0eigusPvj5g28KmdBxuNifPGcjUIJkG3e4b/wrNFK3VLn8yxMK
revateesa1919@gmail.com	Revateesa	$2b$10$uRfl9bdg1hQI1VWlH/np.e1x0H7LnC6x/wfDAxMaUV6kBr/hXdLhG
hbye80305@gmail.com	hi	$2b$10$2CkuJ1frg6Mmha1wymaDwOttJmJf7OHceNsHtj8jP7HrMnofhoQ4G
bye@gmail.com	good	$2b$10$xSvCCth0wsUXPqN50uNCH.7gMQYQEaqWMFSNkDk156GZJXHL0iI5K
nithinnaksh@gmail.com	Nithin	$2b$10$6RUWPJEMQh9GJFQmk6VBAeU9ksm4Cufaz.fpgRtGVfdHuPBd4LXiq
have@g.com	had	$2b$10$3M/epa08eFoo6NRhWmJlW.EFzERww3vpKqd5NPTLeEZA5D.Ia9LHu
cwtt@gmail.com	checking without the tok	$2b$10$Pt/MUodDs.nhr5C2LphAe.oWuzo/HuA0/t.chlQKT7NAxMsBmR.Mm
hi@gmail.com	hi	$2b$10$5zc1nbK6SdwcsVKMsPcDV.lDwjibu9y3wY9W2UhOnTDJXfsKUr0EW
gy@gmail.com	gy	$2b$10$PYEGVOdkh1jY8ssTSlOJNOEnhC5tQ3ixz45rXq5EdRvGwwmtNmuAW
slankir2@asu.edu	Sri Ram	$2b$10$uvxV6jKeP33At35okCss7etDlTvsk0Dc0FIY2U.L8Gx.8L3SLZrsu
\.


--
-- TOC entry 3655 (class 0 OID 24736)
-- Dependencies: 226
-- Data for Name: written_by; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.written_by (isbn, author_id) FROM stdin;
208704344-2	1
577674073-8	2
708973808-6	3
331569357-9	4
096034064-5	5
490417166-7	6
125879241-9	7
435399461-1	8
779725567-9	9
154830619-3	10
436000431-1	11
226218219-1	12
303500591-5	13
891839219-2	14
743901110-4	15
075071435-2	16
222710781-2	17
225672602-9	18
304107594-6	19
431625063-9	20
495033656-8	21
134502056-2	22
660686815-7	23
294068275-5	24
095795420-4	25
461330545-4	26
206829829-5	27
269591809-7	28
145797554-8	29
506371457-9	30
101990666-9	31
452143153-4	32
318045442-3	33
778490071-6	34
779316129-7	35
301792926-4	36
063014273-4	37
449687655-8	38
724679144-2	39
040159971-X	40
319769295-0	41
190891590-0	42
269742664-7	43
179113873-X	44
699686500-X	45
681639813-0	46
446107995-3	47
740453190-X	48
324528178-1	49
268530109-7	50
\.


--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 219
-- Name: ORDER_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ORDER_order_id_seq"', 1, false);


--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 222
-- Name: author_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.author_author_id_seq', 1, false);


--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 224
-- Name: copy_copy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.copy_copy_id_seq', 1, false);


--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 228
-- Name: purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchases_id_seq', 17, true);


--
-- TOC entry 3485 (class 2606 OID 24704)
-- Name: ORDER ORDER_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORDER"
    ADD CONSTRAINT "ORDER_pkey" PRIMARY KEY (order_id);


--
-- TOC entry 3489 (class 2606 OID 24723)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);


--
-- TOC entry 3487 (class 2606 OID 24716)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (isbn);


--
-- TOC entry 3491 (class 2606 OID 24730)
-- Name: copy copy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.copy
    ADD CONSTRAINT copy_pkey PRIMARY KEY (copy_id);


--
-- TOC entry 3495 (class 2606 OID 24755)
-- Name: orders_copy orders_copy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_copy
    ADD CONSTRAINT orders_copy_pkey PRIMARY KEY (order_id, copy_id);


--
-- TOC entry 3497 (class 2606 OID 24830)
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (id);


--
-- TOC entry 3483 (class 2606 OID 24697)
-- Name: user_account user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (email);


--
-- TOC entry 3493 (class 2606 OID 24740)
-- Name: written_by written_by_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.written_by
    ADD CONSTRAINT written_by_pkey PRIMARY KEY (isbn, author_id);


--
-- TOC entry 3498 (class 2606 OID 24705)
-- Name: ORDER ORDER_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORDER"
    ADD CONSTRAINT "ORDER_email_fkey" FOREIGN KEY (email) REFERENCES public.user_account(email);


--
-- TOC entry 3499 (class 2606 OID 24731)
-- Name: copy copy_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.copy
    ADD CONSTRAINT copy_isbn_fkey FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- TOC entry 3502 (class 2606 OID 24761)
-- Name: orders_copy orders_copy_copy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_copy
    ADD CONSTRAINT orders_copy_copy_id_fkey FOREIGN KEY (copy_id) REFERENCES public.copy(copy_id);


--
-- TOC entry 3503 (class 2606 OID 24756)
-- Name: orders_copy orders_copy_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders_copy
    ADD CONSTRAINT orders_copy_order_id_fkey FOREIGN KEY (order_id) REFERENCES public."ORDER"(order_id);


--
-- TOC entry 3500 (class 2606 OID 24746)
-- Name: written_by written_by_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.written_by
    ADD CONSTRAINT written_by_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.author(author_id);


--
-- TOC entry 3501 (class 2606 OID 24741)
-- Name: written_by written_by_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.written_by
    ADD CONSTRAINT written_by_isbn_fkey FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE author; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.author TO nithin;


--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE book; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.book TO nithin;


--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE copy; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE public.copy TO nithin;


--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE purchases; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE public.purchases TO nithin;


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 228
-- Name: SEQUENCE purchases_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.purchases_id_seq TO nithin;


--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE user_account; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.user_account TO nithin;


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE written_by; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.written_by TO nithin;


-- Completed on 2024-12-06 11:25:24 MST

--
-- PostgreSQL database dump complete
--

