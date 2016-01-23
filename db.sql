
-- Database: "SBD"

DROP DATABASE "SBD";

CREATE DATABASE "SBD"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'pl_PL.UTF-8'
       LC_CTYPE = 'pl_PL.UTF-8'
       CONNECTION LIMIT = -1;


--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.10
-- Dumped by pg_dump version 9.3.10
-- Started on 2016-01-19 19:33:40 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 191 (class 3079 OID 11789)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2125 (class 0 OID 0)
-- Dependencies: 191
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 205 (class 1255 OID 57778)
-- Name: delete_product(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION delete_product(product_id bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE products SET deleted=TRUE WHERE id=product_id;
END;
$$;


ALTER FUNCTION public.delete_product(product_id bigint) OWNER TO postgres;

--
-- TOC entry 206 (class 1255 OID 57788)
-- Name: sum_order(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sum_order(oid bigint) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE sum Decimal;
BEGIN
    SELECT SUM(price) INTO sum FROM order_products WHERE order_id=oid;
    RETURN sum;
END;
$$;


ALTER FUNCTION public.sum_order(oid bigint) OWNER TO postgres;

--
-- TOC entry 198 (class 1255 OID 57601)
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
-- TOC entry 170 (class 1259 OID 57602)
-- Name: addresses; Type: TABLE; Schema: public; Owner: damian; Tablespace:
--

CREATE TABLE addresses (
    id bigint NOT NULL,
    country character varying NOT NULL,
    street character varying NOT NULL,
    city character varying NOT NULL
);


ALTER TABLE public.addresses OWNER TO damian;

--
-- TOC entry 171 (class 1259 OID 57608)
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: damian
--

CREATE SEQUENCE addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.addresses_id_seq OWNER TO damian;

--
-- TOC entry 2126 (class 0 OID 0)
-- Dependencies: 171
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: damian
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- TOC entry 172 (class 1259 OID 57610)
-- Name: client_addresses; Type: TABLE; Schema: public; Owner: damian; Tablespace:
--

CREATE TABLE client_addresses (
    id bigint NOT NULL,
    client_id bigint NOT NULL,
    address_id bigint NOT NULL,
    type character varying NOT NULL
);


ALTER TABLE public.client_addresses OWNER TO damian;

--
-- TOC entry 173 (class 1259 OID 57616)
-- Name: client_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: damian
--

CREATE SEQUENCE client_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_addresses_id_seq OWNER TO damian;

--
-- TOC entry 2127 (class 0 OID 0)
-- Dependencies: 173
-- Name: client_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: damian
--

ALTER SEQUENCE client_addresses_id_seq OWNED BY client_addresses.id;


--
-- TOC entry 174 (class 1259 OID 57618)
-- Name: client_phones; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE client_phones (
    id integer NOT NULL,
    phone character varying NOT NULL,
    client_id integer NOT NULL
);


ALTER TABLE public.client_phones OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 57624)
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
-- TOC entry 2128 (class 0 OID 0)
-- Dependencies: 175
-- Name: client_phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE client_phones_id_seq OWNED BY client_phones.id;


--
-- TOC entry 176 (class 1259 OID 57626)
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
-- TOC entry 177 (class 1259 OID 57632)
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
-- TOC entry 2129 (class 0 OID 0)
-- Dependencies: 177
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- TOC entry 178 (class 1259 OID 57634)
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
-- TOC entry 179 (class 1259 OID 57637)
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
-- TOC entry 2130 (class 0 OID 0)
-- Dependencies: 179
-- Name: order_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE order_products_id_seq OWNED BY order_products.id;


--
-- TOC entry 180 (class 1259 OID 57639)
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
-- TOC entry 2131 (class 0 OID 0)
-- Dependencies: 180
-- Name: order_products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE order_products_product_id_seq OWNED BY order_products.product_id;


--
-- TOC entry 181 (class 1259 OID 57641)
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: damian; Tablespace:
--

CREATE TABLE order_statuses (
    id bigint NOT NULL,
    status_name character varying NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO damian;

--
-- TOC entry 182 (class 1259 OID 57647)
-- Name: order_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: damian
--

CREATE SEQUENCE order_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_statuses_id_seq OWNER TO damian;

--
-- TOC entry 2132 (class 0 OID 0)
-- Dependencies: 182
-- Name: order_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: damian
--

ALTER SEQUENCE order_statuses_id_seq OWNED BY order_statuses.id;


--
-- TOC entry 183 (class 1259 OID 57649)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE orders (
    id bigint NOT NULL,
    client_id bigint NOT NULL,
    status_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 57652)
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
-- TOC entry 2133 (class 0 OID 0)
-- Dependencies: 184
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- TOC entry 185 (class 1259 OID 57654)
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
-- TOC entry 186 (class 1259 OID 57663)
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
-- TOC entry 2134 (class 0 OID 0)
-- Dependencies: 186
-- Name: product_images_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_images_image_id_seq OWNED BY product_images.id;


--
-- TOC entry 187 (class 1259 OID 57665)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE products (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description character varying,
    price numeric,
    deleted boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 57674)
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
-- TOC entry 2135 (class 0 OID 0)
-- Dependencies: 188
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_product_id_seq OWNED BY products.id;


--
-- TOC entry 189 (class 1259 OID 57676)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 57682)
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
-- TOC entry 2136 (class 0 OID 0)
-- Dependencies: 190
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 1928 (class 2604 OID 57684)
-- Name: id; Type: DEFAULT; Schema: public; Owner: damian
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- TOC entry 1929 (class 2604 OID 57685)
-- Name: id; Type: DEFAULT; Schema: public; Owner: damian
--

ALTER TABLE ONLY client_addresses ALTER COLUMN id SET DEFAULT nextval('client_addresses_id_seq'::regclass);


--
-- TOC entry 1930 (class 2604 OID 57686)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY client_phones ALTER COLUMN id SET DEFAULT nextval('client_phones_id_seq'::regclass);


--
-- TOC entry 1931 (class 2604 OID 57687)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- TOC entry 1932 (class 2604 OID 57688)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products ALTER COLUMN id SET DEFAULT nextval('order_products_id_seq'::regclass);


--
-- TOC entry 1933 (class 2604 OID 57689)
-- Name: product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products ALTER COLUMN product_id SET DEFAULT nextval('order_products_product_id_seq'::regclass);


--
-- TOC entry 1934 (class 2604 OID 57690)
-- Name: id; Type: DEFAULT; Schema: public; Owner: damian
--

ALTER TABLE ONLY order_statuses ALTER COLUMN id SET DEFAULT nextval('order_statuses_id_seq'::regclass);


--
-- TOC entry 1935 (class 2604 OID 57691)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- TOC entry 1939 (class 2604 OID 57692)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_images ALTER COLUMN id SET DEFAULT nextval('product_images_image_id_seq'::regclass);


--
-- TOC entry 1943 (class 2604 OID 57693)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('product_product_id_seq'::regclass);


--
-- TOC entry 1944 (class 2604 OID 57694)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 2098 (class 0 OID 57602)
-- Dependencies: 170
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: damian
--

--
-- TOC entry 2137 (class 0 OID 0)
-- Dependencies: 171
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: damian
--

SELECT pg_catalog.setval('addresses_id_seq', 4, true);


--
-- TOC entry 2100 (class 0 OID 57610)
-- Dependencies: 172
-- Data for Name: client_addresses; Type: TABLE DATA; Schema: public; Owner: damian
--


--
-- TOC entry 2138 (class 0 OID 0)
-- Dependencies: 173
-- Name: client_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: damian
--

SELECT pg_catalog.setval('client_addresses_id_seq', 4, true);


--
-- TOC entry 2102 (class 0 OID 57618)
-- Dependencies: 174
-- Data for Name: client_phones; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 2139 (class 0 OID 0)
-- Dependencies: 175
-- Name: client_phones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('client_phones_id_seq', 2, true);


--
-- TOC entry 2104 (class 0 OID 57626)
-- Dependencies: 176
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2140 (class 0 OID 0)
-- Dependencies: 177
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('clients_id_seq', 3, true);


--
-- TOC entry 2106 (class 0 OID 57634)
-- Dependencies: 178
-- Data for Name: order_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- TOC entry 2141 (class 0 OID 0)
-- Dependencies: 179
-- Name: order_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('order_products_id_seq', 4, true);


--
-- TOC entry 2142 (class 0 OID 0)
-- Dependencies: 180
-- Name: order_products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('order_products_product_id_seq', 1, false);


--
-- TOC entry 2109 (class 0 OID 57641)
-- Dependencies: 181
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: damian
--


--
-- TOC entry 2143 (class 0 OID 0)
-- Dependencies: 182
-- Name: order_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: damian
--

SELECT pg_catalog.setval('order_statuses_id_seq', 1, true);


--
-- TOC entry 2111 (class 0 OID 57649)
-- Dependencies: 183
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 2144 (class 0 OID 0)
-- Dependencies: 184
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orders_id_seq', 2, true);


--
-- TOC entry 2113 (class 0 OID 57654)
-- Dependencies: 185
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- TOC entry 2145 (class 0 OID 0)
-- Dependencies: 186
-- Name: product_images_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_images_image_id_seq', 2, true);


--
-- TOC entry 2146 (class 0 OID 0)
-- Dependencies: 188
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_product_id_seq', 2, true);


--
-- TOC entry 2115 (class 0 OID 57665)
-- Dependencies: 187
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 2117 (class 0 OID 57676)
-- Dependencies: 189
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 2147 (class 0 OID 0)
-- Dependencies: 190
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 8, true);


--
-- TOC entry 1946 (class 2606 OID 57696)
-- Name: address_pk; Type: CONSTRAINT; Schema: public; Owner: damian; Tablespace:
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT address_pk PRIMARY KEY (id);


--
-- TOC entry 1948 (class 2606 OID 57698)
-- Name: client_addresses_pk; Type: CONSTRAINT; Schema: public; Owner: damian; Tablespace:
--

ALTER TABLE ONLY client_addresses
    ADD CONSTRAINT client_addresses_pk PRIMARY KEY (id);


--
-- TOC entry 1953 (class 2606 OID 57700)
-- Name: client_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT client_id PRIMARY KEY (id);


--
-- TOC entry 1975 (class 2606 OID 57702)
-- Name: id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 1967 (class 2606 OID 57704)
-- Name: image_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT image_id PRIMARY KEY (id);


--
-- TOC entry 1965 (class 2606 OID 57706)
-- Name: order_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT order_id PRIMARY KEY (id);


--
-- TOC entry 1959 (class 2606 OID 57708)
-- Name: order_product_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT order_product_id PRIMARY KEY (id);


--
-- TOC entry 1951 (class 2606 OID 57710)
-- Name: phone_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY client_phones
    ADD CONSTRAINT phone_id PRIMARY KEY (id);


--
-- TOC entry 1971 (class 2606 OID 57712)
-- Name: product_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY products
    ADD CONSTRAINT product_id PRIMARY KEY (id);


--
-- TOC entry 1973 (class 2606 OID 57714)
-- Name: product_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY products
    ADD CONSTRAINT product_name_unique UNIQUE (name);


--
-- TOC entry 1961 (class 2606 OID 57716)
-- Name: status_pk; Type: CONSTRAINT; Schema: public; Owner: damian; Tablespace:
--

ALTER TABLE ONLY order_statuses
    ADD CONSTRAINT status_pk PRIMARY KEY (id);


--
-- TOC entry 1957 (class 2606 OID 57718)
-- Name: surname_name_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT surname_name_email_unique UNIQUE (name, surname, email);


--
-- TOC entry 1979 (class 2606 OID 57790)
-- Name: username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT username_unique UNIQUE (username);


--
-- TOC entry 1968 (class 1259 OID 57721)
-- Name: description; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX description ON products USING btree (description);


--
-- TOC entry 1954 (class 1259 OID 57722)
-- Name: email_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX email_index ON clients USING btree (email);


--
-- TOC entry 1949 (class 1259 OID 57723)
-- Name: fki_client_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX fki_client_id ON client_phones USING btree (client_id);


--
-- TOC entry 1962 (class 1259 OID 57724)
-- Name: fki_status_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX fki_status_fk ON orders USING btree (status_id);


--
-- TOC entry 1963 (class 1259 OID 57725)
-- Name: fki_user_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX fki_user_pk ON orders USING btree (user_id);


--
-- TOC entry 1969 (class 1259 OID 57726)
-- Name: name; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX name ON products USING btree (name);


--
-- TOC entry 1955 (class 1259 OID 57727)
-- Name: name_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX name_index ON clients USING btree (name);


--
-- TOC entry 1976 (class 1259 OID 57728)
-- Name: password_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX password_index ON users USING btree (password);


--
-- TOC entry 1977 (class 1259 OID 57729)
-- Name: username; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX username ON users USING btree (username);


--
-- TOC entry 1989 (class 2620 OID 57730)
-- Name: update_ab_changetimestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_ab_changetimestamp BEFORE UPDATE ON product_images FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


--
-- TOC entry 1990 (class 2620 OID 57731)
-- Name: update_ab_changetimestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_ab_changetimestamp BEFORE UPDATE ON products FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


--
-- TOC entry 1980 (class 2606 OID 57732)
-- Name: client_addresses_address_pk; Type: FK CONSTRAINT; Schema: public; Owner: damian
--

ALTER TABLE ONLY client_addresses
    ADD CONSTRAINT client_addresses_address_pk FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- TOC entry 1981 (class 2606 OID 57737)
-- Name: client_addresses_client_pk; Type: FK CONSTRAINT; Schema: public; Owner: damian
--

ALTER TABLE ONLY client_addresses
    ADD CONSTRAINT client_addresses_client_pk FOREIGN KEY (client_id) REFERENCES clients(id);


--
-- TOC entry 1982 (class 2606 OID 57742)
-- Name: client_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY client_phones
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES clients(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1985 (class 2606 OID 57747)
-- Name: client_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES clients(id);


--
-- TOC entry 1983 (class 2606 OID 57752)
-- Name: order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE;


--
-- TOC entry 1988 (class 2606 OID 57757)
-- Name: product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES products(id);


--
-- TOC entry 1984 (class 2606 OID 57762)
-- Name: product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES products(id);


--
-- TOC entry 1986 (class 2606 OID 57767)
-- Name: status_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT status_fk FOREIGN KEY (status_id) REFERENCES order_statuses(id);


--
-- TOC entry 1987 (class 2606 OID 57772)
-- Name: user_pk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT user_pk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- TOC entry 2124 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
