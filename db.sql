--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.10
-- Dumped by pg_dump version 9.3.10
-- Started on 2016-01-08 19:11:26 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 185 (class 3079 OID 11789)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2072 (class 0 OID 0)
-- Dependencies: 185
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 192 (class 1255 OID 32792)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.updated_at = now();
   RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 179 (class 1259 OID 41056)
-- Name: client_phones; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE client_phones (
    id integer NOT NULL,
    phone character varying NOT NULL,
    client_id integer NOT NULL
);


ALTER TABLE public.client_phones OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 41054)
-- Name: client_phones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE client_phones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_phones_id_seq OWNER TO postgres;

--
-- TOC entry 2073 (class 0 OID 0)
-- Dependencies: 178
-- Name: client_phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE client_phones_id_seq OWNED BY client_phones.id;


--
-- TOC entry 177 (class 1259 OID 41045)
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE clients (
    id integer NOT NULL,
    name character varying NOT NULL,
    surname character varying NOT NULL,
    email character varying NOT NULL
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 41043)
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_id_seq OWNER TO postgres;

--
-- TOC entry 2074 (class 0 OID 0)
-- Dependencies: 176
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- TOC entry 184 (class 1259 OID 57441)
-- Name: order_products; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE order_products (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    price double precision,
    quantity integer
);


ALTER TABLE public.order_products OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 57437)
-- Name: order_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE order_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_products_id_seq OWNER TO postgres;

--
-- TOC entry 2075 (class 0 OID 0)
-- Dependencies: 182
-- Name: order_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE order_products_id_seq OWNED BY order_products.id;


--
-- TOC entry 183 (class 1259 OID 57439)
-- Name: order_products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE order_products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_products_product_id_seq OWNER TO postgres;

--
-- TOC entry 2076 (class 0 OID 0)
-- Dependencies: 183
-- Name: order_products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE order_products_product_id_seq OWNED BY order_products.product_id;


--
-- TOC entry 181 (class 1259 OID 57426)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE orders (
    id bigint NOT NULL,
    client_id bigint NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 57424)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 180
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- TOC entry 173 (class 1259 OID 32770)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE product (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description character varying,
    price numeric,
    deleted boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 32781)
-- Name: product_images; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE product_images (
    id bigint NOT NULL,
    filename character varying,
    caption character varying,
    default_image boolean,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    product_id integer NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.product_images OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 32779)
-- Name: product_images_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_images_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_images_image_id_seq OWNER TO postgres;

--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 174
-- Name: product_images_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_images_image_id_seq OWNED BY product_images.id;


--
-- TOC entry 172 (class 1259 OID 32768)
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_product_id_seq OWNER TO postgres;

--
-- TOC entry 2079 (class 0 OID 0)
-- Dependencies: 172
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_product_id_seq OWNED BY product.id;


--
-- TOC entry 171 (class 1259 OID 24586)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 24584)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 170
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 1915 (class 2604 OID 41085)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY client_phones ALTER COLUMN id SET DEFAULT nextval('client_phones_id_seq'::regclass);


--
-- TOC entry 1914 (class 2604 OID 41070)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- TOC entry 1917 (class 2604 OID 57444)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products ALTER COLUMN id SET DEFAULT nextval('order_products_id_seq'::regclass);


--
-- TOC entry 1918 (class 2604 OID 57445)
-- Name: product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products ALTER COLUMN product_id SET DEFAULT nextval('order_products_product_id_seq'::regclass);


--
-- TOC entry 1916 (class 2604 OID 57429)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- TOC entry 1906 (class 2604 OID 32773)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product ALTER COLUMN id SET DEFAULT nextval('product_product_id_seq'::regclass);


--
-- TOC entry 1910 (class 2604 OID 32784)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_images ALTER COLUMN id SET DEFAULT nextval('product_images_image_id_seq'::regclass);


--
-- TOC entry 1905 (class 2604 OID 24589)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 2059 (class 0 OID 41056)
-- Dependencies: 179
-- Data for Name: client_phones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY client_phones (id, phone, client_id) FROM stdin;
369 123335  7
370 1234456 7
372 567567  8
373 5675    8
\.


--
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 178
-- Name: client_phones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('client_phones_id_seq', 373, true);


--
-- TOC entry 2057 (class 0 OID 41045)
-- Dependencies: 177
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY clients (id, name, surname, email) FROM stdin;
1   Damiian Blejwas damian.freedoom@gmail.com
2   Damiian Blejwas damian.freedoom@gmail.com
3   Damiian Blejwas damian.freedoom@gmail.com
4   Damiian Blejwas damian.freedoom@gmail.com
7   Patryk  Blejwas damian.freedoom@gmail.com
8   --  "   damian.freedoom@gmail.com
\.


--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 176
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('clients_id_seq', 8, true);


--
-- TOC entry 2064 (class 0 OID 57441)
-- Dependencies: 184
-- Data for Name: order_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY order_products (id, order_id, product_id, price, quantity) FROM stdin;
\.


--
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 182
-- Name: order_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('order_products_id_seq', 1, false);


--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 183
-- Name: order_products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('order_products_product_id_seq', 1, false);


--
-- TOC entry 2061 (class 0 OID 57426)
-- Dependencies: 181
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY orders (id, client_id) FROM stdin;
\.


--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 180
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orders_id_seq', 1, false);


--
-- TOC entry 2053 (class 0 OID 32770)
-- Dependencies: 173
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY product (id, name, description, price, deleted, created_at, updated_at) FROM stdin;
19  asd asd 32.23   t   2015-12-28 20:09:49.277218  2015-12-28 20:46:54.64834
18  asd asd 32.23   t   2015-12-28 19:58:12.576863  2015-12-28 20:46:55.927457
20  asdadfgh    asd 32.23   t   2015-12-28 20:10:36.692279  2015-12-28 20:46:56.448578
21  asdadfghasd2345623  asd 32.23   t   2015-12-28 20:10:44.069639  2015-12-28 20:46:56.913034
17  asd asd 32.23   t   2015-12-28 19:11:35.336003  2015-12-28 20:46:57.933195
16  asd asd3    32.23   f   2015-12-28 18:50:36.825085  2015-12-28 20:47:06.116549
22  Deska   Jest to bardzo ładna deska\r\nA tutaj tekst po enterze  99.99   f   2016-01-06 22:26:25.935935  2016-01-06 22:26:25.935935
\.


--
-- TOC entry 2055 (class 0 OID 32781)
-- Dependencies: 175
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY product_images (id, filename, caption, default_image, created_at, updated_at, product_id, deleted) FROM stdin;
7   972114f7619e7f7b82d600f046c561af-PNG_transparency_demonstration_1.png   PNG_transparency_demonstration_1.png    \N  2015-12-28 18:10:54.459425  2015-12-28 18:10:54.459425  16  f
8   d1be2f8a402efc2c533778c207be6b71-mini.jpg   mini.jpg    \N  2015-12-28 19:11:35.344659  2015-12-28 19:57:13.729688  17  t
9   5a6799d7ef5623fc98388d8242389501-mini.jpg   mini.jpg    \N  2015-12-28 19:58:12.588479  2015-12-28 19:58:12.588479  18  f
10  de17d43cc2fef5fc3a4b3aa4ea798f5d-PNG_transparency_demonstration_1.png   PNG_transparency_demonstration_1.png    \N  2015-12-28 19:58:12.600781  2015-12-28 19:58:12.600781  18  f
11  2d12c1b14b1db3a595677b31730802c8-       \N  2015-12-28 20:09:49.286908  2015-12-28 20:09:49.286908  19  f
12  b31882213b17d09018c5f3235de166dc-       \N  2015-12-28 20:10:36.738993  2015-12-28 20:10:36.738993  20  f
14  96d4215e5acfdb72ce2ae86039668706-mini.jpg   mini.jpg    \N  2015-12-28 20:35:27.883202  2015-12-28 20:35:27.883202  21  f
13  15957fc7412d6f8f9372af98d5fe806c-       \N  2015-12-28 20:10:44.112145  2015-12-28 20:35:30.193671  21  t
15  6b4e91e217425f84f7613aef72fefbb0-PNG_transparency_demonstration_1.png   PNG_transparency_demonstration_1.png    \N  2015-12-28 20:47:06.124808  2015-12-28 20:47:10.439133  16  t
16  2bdc16ed70bba47a159ad87977ef21a8-mini.jpg   mini.jpg    \N  2016-01-06 22:26:25.940912  2016-01-06 22:26:25.940912  22  f
\.


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 174
-- Name: product_images_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_images_image_id_seq', 16, true);


--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 172
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_product_id_seq', 22, true);


--
-- TOC entry 2051 (class 0 OID 24586)
-- Dependencies: 171
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, username, password) FROM stdin;
1   sbd b98d50c159a938723d8eb8f3039afab2
\.


--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 170
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- TOC entry 1928 (class 2606 OID 41072)
-- Name: client_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT client_id PRIMARY KEY (id);


--
-- TOC entry 1920 (class 2606 OID 24591)
-- Name: id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 1926 (class 2606 OID 32791)
-- Name: image_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT image_id PRIMARY KEY (id);


--
-- TOC entry 1933 (class 2606 OID 57431)
-- Name: order_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT order_id PRIMARY KEY (id);


--
-- TOC entry 1935 (class 2606 OID 57447)
-- Name: order_product_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT order_product_id PRIMARY KEY (id);


--
-- TOC entry 1931 (class 2606 OID 41087)
-- Name: phone_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY client_phones
    ADD CONSTRAINT phone_id PRIMARY KEY (id);


--
-- TOC entry 1924 (class 2606 OID 32778)
-- Name: product_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_id PRIMARY KEY (id);


--
-- TOC entry 1921 (class 1259 OID 32799)
-- Name: description; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX description ON product USING btree (description);


--
-- TOC entry 1929 (class 1259 OID 49236)
-- Name: fki_client_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX fki_client_id ON client_phones USING btree (client_id);


--
-- TOC entry 1922 (class 1259 OID 32800)
-- Name: name; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX name ON product USING btree (name);


--
-- TOC entry 1942 (class 2620 OID 32793)
-- Name: update_ab_changetimestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_ab_changetimestamp BEFORE UPDATE ON product_images FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


--
-- TOC entry 1941 (class 2620 OID 32833)
-- Name: update_ab_changetimestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_ab_changetimestamp BEFORE UPDATE ON product FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


--
-- TOC entry 1937 (class 2606 OID 49237)
-- Name: client_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY client_phones
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES clients(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1938 (class 2606 OID 57432)
-- Name: client_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES clients(id);


--
-- TOC entry 1940 (class 2606 OID 57453)
-- Name: order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE;


--
-- TOC entry 1936 (class 2606 OID 32794)
-- Name: product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES product(id);


--
-- TOC entry 1939 (class 2606 OID 57448)
-- Name: product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES product(id);


--
-- TOC entry 2071 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-01-08 19:11:26 CET

--
-- PostgreSQL database dump complete
--

