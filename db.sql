--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.10
-- Dumped by pg_dump version 9.3.10
-- Started on 2016-01-18 21:28:13 CET

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
-- TOC entry 2103 (class 0 OID 0)
-- Dependencies: 191
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 198 (class 1255 OID 16694)
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
-- TOC entry 188 (class 1259 OID 16836)
-- Name: addresses; Type: TABLE; Schema: public; Owner: kuba; Tablespace: 
--

CREATE TABLE addresses (
    id bigint NOT NULL,
    country character varying NOT NULL,
    street character varying NOT NULL,
    city character varying NOT NULL
);


ALTER TABLE public.addresses OWNER TO kuba;

--
-- TOC entry 187 (class 1259 OID 16834)
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: kuba
--

CREATE SEQUENCE addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.addresses_id_seq OWNER TO kuba;

--
-- TOC entry 2104 (class 0 OID 0)
-- Dependencies: 187
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuba
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- TOC entry 190 (class 1259 OID 16870)
-- Name: client_addresses; Type: TABLE; Schema: public; Owner: kuba; Tablespace: 
--

CREATE TABLE client_addresses (
    id bigint NOT NULL,
    client_id bigint NOT NULL,
    address_id bigint NOT NULL,
    type character varying NOT NULL
);


ALTER TABLE public.client_addresses OWNER TO kuba;

--
-- TOC entry 189 (class 1259 OID 16868)
-- Name: client_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: kuba
--

CREATE SEQUENCE client_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_addresses_id_seq OWNER TO kuba;

--
-- TOC entry 2105 (class 0 OID 0)
-- Dependencies: 189
-- Name: client_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuba
--

ALTER SEQUENCE client_addresses_id_seq OWNED BY client_addresses.id;


--
-- TOC entry 170 (class 1259 OID 16695)
-- Name: client_phones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE client_phones (
    id integer NOT NULL,
    phone character varying NOT NULL,
    client_id integer NOT NULL
);


ALTER TABLE public.client_phones OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 16701)
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
-- TOC entry 2106 (class 0 OID 0)
-- Dependencies: 171
-- Name: client_phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE client_phones_id_seq OWNED BY client_phones.id;


--
-- TOC entry 172 (class 1259 OID 16703)
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
-- TOC entry 173 (class 1259 OID 16709)
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
-- TOC entry 2107 (class 0 OID 0)
-- Dependencies: 173
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- TOC entry 174 (class 1259 OID 16711)
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
-- TOC entry 175 (class 1259 OID 16714)
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
-- TOC entry 2108 (class 0 OID 0)
-- Dependencies: 175
-- Name: order_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE order_products_id_seq OWNED BY order_products.id;


--
-- TOC entry 176 (class 1259 OID 16716)
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
-- TOC entry 2109 (class 0 OID 0)
-- Dependencies: 176
-- Name: order_products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE order_products_product_id_seq OWNED BY order_products.product_id;


--
-- TOC entry 186 (class 1259 OID 16808)
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: kuba; Tablespace: 
--

CREATE TABLE order_statuses (
    id bigint NOT NULL,
    status_name character varying NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO kuba;

--
-- TOC entry 185 (class 1259 OID 16806)
-- Name: order_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: kuba
--

CREATE SEQUENCE order_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_statuses_id_seq OWNER TO kuba;

--
-- TOC entry 2110 (class 0 OID 0)
-- Dependencies: 185
-- Name: order_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuba
--

ALTER SEQUENCE order_statuses_id_seq OWNED BY order_statuses.id;


--
-- TOC entry 177 (class 1259 OID 16718)
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
-- TOC entry 178 (class 1259 OID 16721)
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
-- TOC entry 2111 (class 0 OID 0)
-- Dependencies: 178
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- TOC entry 180 (class 1259 OID 16732)
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
-- TOC entry 181 (class 1259 OID 16741)
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
-- TOC entry 2112 (class 0 OID 0)
-- Dependencies: 181
-- Name: product_images_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_images_image_id_seq OWNED BY product_images.id;


--
-- TOC entry 179 (class 1259 OID 16723)
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
-- TOC entry 182 (class 1259 OID 16743)
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
-- TOC entry 2113 (class 0 OID 0)
-- Dependencies: 182
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_product_id_seq OWNED BY products.id;


--
-- TOC entry 183 (class 1259 OID 16745)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 16751)
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
-- TOC entry 2114 (class 0 OID 0)
-- Dependencies: 184
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 1941 (class 2604 OID 16839)
-- Name: id; Type: DEFAULT; Schema: public; Owner: kuba
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- TOC entry 1942 (class 2604 OID 16873)
-- Name: id; Type: DEFAULT; Schema: public; Owner: kuba
--

ALTER TABLE ONLY client_addresses ALTER COLUMN id SET DEFAULT nextval('client_addresses_id_seq'::regclass);


--
-- TOC entry 1926 (class 2604 OID 16753)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY client_phones ALTER COLUMN id SET DEFAULT nextval('client_phones_id_seq'::regclass);


--
-- TOC entry 1927 (class 2604 OID 16754)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- TOC entry 1928 (class 2604 OID 16755)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products ALTER COLUMN id SET DEFAULT nextval('order_products_id_seq'::regclass);


--
-- TOC entry 1929 (class 2604 OID 16756)
-- Name: product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products ALTER COLUMN product_id SET DEFAULT nextval('order_products_product_id_seq'::regclass);


--
-- TOC entry 1940 (class 2604 OID 16811)
-- Name: id; Type: DEFAULT; Schema: public; Owner: kuba
--

ALTER TABLE ONLY order_statuses ALTER COLUMN id SET DEFAULT nextval('order_statuses_id_seq'::regclass);


--
-- TOC entry 1930 (class 2604 OID 16757)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- TOC entry 1938 (class 2604 OID 16759)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_images ALTER COLUMN id SET DEFAULT nextval('product_images_image_id_seq'::regclass);


--
-- TOC entry 1934 (class 2604 OID 16758)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('product_product_id_seq'::regclass);


--
-- TOC entry 1939 (class 2604 OID 16760)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 1975 (class 2606 OID 16844)
-- Name: address_pk; Type: CONSTRAINT; Schema: public; Owner: kuba; Tablespace: 
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT address_pk PRIMARY KEY (id);


--
-- TOC entry 1977 (class 2606 OID 16878)
-- Name: client_addresses_pk; Type: CONSTRAINT; Schema: public; Owner: kuba; Tablespace: 
--

ALTER TABLE ONLY client_addresses
    ADD CONSTRAINT client_addresses_pk PRIMARY KEY (id);


--
-- TOC entry 1947 (class 2606 OID 16762)
-- Name: client_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT client_id PRIMARY KEY (id);


--
-- TOC entry 1967 (class 2606 OID 16764)
-- Name: id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 1965 (class 2606 OID 16766)
-- Name: image_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT image_id PRIMARY KEY (id);


--
-- TOC entry 1957 (class 2606 OID 16768)
-- Name: order_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT order_id PRIMARY KEY (id);


--
-- TOC entry 1953 (class 2606 OID 16770)
-- Name: order_product_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT order_product_id PRIMARY KEY (id);


--
-- TOC entry 1945 (class 2606 OID 16772)
-- Name: phone_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY client_phones
    ADD CONSTRAINT phone_id PRIMARY KEY (id);


--
-- TOC entry 1961 (class 2606 OID 16774)
-- Name: product_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT product_id PRIMARY KEY (id);


--
-- TOC entry 1963 (class 2606 OID 16921)
-- Name: product_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT product_name_unique UNIQUE (name);


--
-- TOC entry 1973 (class 2606 OID 16816)
-- Name: status_pk; Type: CONSTRAINT; Schema: public; Owner: kuba; Tablespace: 
--

ALTER TABLE ONLY order_statuses
    ADD CONSTRAINT status_pk PRIMARY KEY (id);


--
-- TOC entry 1951 (class 2606 OID 16917)
-- Name: surname_name_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT surname_name_email_unique UNIQUE (name, surname, email);


--
-- TOC entry 1971 (class 2606 OID 16919)
-- Name: username_password_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT username_password_unique UNIQUE (username, password);


--
-- TOC entry 1958 (class 1259 OID 16775)
-- Name: description; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX description ON products USING btree (description);


--
-- TOC entry 1948 (class 1259 OID 16922)
-- Name: email_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX email_index ON clients USING btree (email);


--
-- TOC entry 1943 (class 1259 OID 16776)
-- Name: fki_client_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_client_id ON client_phones USING btree (client_id);


--
-- TOC entry 1954 (class 1259 OID 16827)
-- Name: fki_status_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_status_fk ON orders USING btree (status_id);


--
-- TOC entry 1955 (class 1259 OID 16833)
-- Name: fki_user_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_user_pk ON orders USING btree (user_id);


--
-- TOC entry 1959 (class 1259 OID 16777)
-- Name: name; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX name ON products USING btree (name);


--
-- TOC entry 1949 (class 1259 OID 16889)
-- Name: name_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX name_index ON clients USING btree (name);


--
-- TOC entry 1968 (class 1259 OID 16924)
-- Name: password_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX password_index ON users USING btree (password);


--
-- TOC entry 1969 (class 1259 OID 16923)
-- Name: username; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX username ON users USING btree (username);


--
-- TOC entry 1988 (class 2620 OID 16778)
-- Name: update_ab_changetimestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_ab_changetimestamp BEFORE UPDATE ON product_images FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


--
-- TOC entry 1987 (class 2620 OID 16779)
-- Name: update_ab_changetimestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_ab_changetimestamp BEFORE UPDATE ON products FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


--
-- TOC entry 1986 (class 2606 OID 16884)
-- Name: client_addresses_address_pk; Type: FK CONSTRAINT; Schema: public; Owner: kuba
--

ALTER TABLE ONLY client_addresses
    ADD CONSTRAINT client_addresses_address_pk FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- TOC entry 1985 (class 2606 OID 16879)
-- Name: client_addresses_client_pk; Type: FK CONSTRAINT; Schema: public; Owner: kuba
--

ALTER TABLE ONLY client_addresses
    ADD CONSTRAINT client_addresses_client_pk FOREIGN KEY (client_id) REFERENCES clients(id);


--
-- TOC entry 1978 (class 2606 OID 16780)
-- Name: client_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY client_phones
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES clients(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1981 (class 2606 OID 16785)
-- Name: client_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES clients(id);


--
-- TOC entry 1979 (class 2606 OID 16790)
-- Name: order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE;


--
-- TOC entry 1984 (class 2606 OID 16795)
-- Name: product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES products(id);


--
-- TOC entry 1980 (class 2606 OID 16800)
-- Name: product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES products(id);


--
-- TOC entry 1982 (class 2606 OID 16822)
-- Name: status_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT status_fk FOREIGN KEY (status_id) REFERENCES order_statuses(id);


--
-- TOC entry 1983 (class 2606 OID 16828)
-- Name: user_pk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT user_pk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- TOC entry 2102 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-01-18 21:28:13 CET

--
-- PostgreSQL database dump complete
--

