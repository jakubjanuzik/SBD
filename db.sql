-- Started on 2016-01-23 11:49:33 CET

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
-- TOC entry 2107 (class 0 OID 0)
-- Dependencies: 191
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 204 (class 1255 OID 16935)
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
-- TOC entry 206 (class 1255 OID 16936)
-- Name: sum_order(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sum_order(oid bigint) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE sum Decimal;
BEGIN
    SELECT SUM(price * quantity) INTO sum FROM order_products WHERE order_id=oid;
    RETURN sum;
END;
$$;


ALTER FUNCTION public.sum_order(oid bigint) OWNER TO postgres;

--
-- TOC entry 205 (class 1255 OID 16937)
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
-- TOC entry 170 (class 1259 OID 16938)
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
-- TOC entry 171 (class 1259 OID 16944)
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
-- TOC entry 2108 (class 0 OID 0)
-- Dependencies: 171
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuba
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- TOC entry 172 (class 1259 OID 16946)
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
-- TOC entry 173 (class 1259 OID 16952)
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
-- TOC entry 2109 (class 0 OID 0)
-- Dependencies: 173
-- Name: client_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuba
--

ALTER SEQUENCE client_addresses_id_seq OWNED BY client_addresses.id;


--
-- TOC entry 174 (class 1259 OID 16954)
-- Name: client_phones; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE client_phones (
    id integer NOT NULL,
    phone character varying NOT NULL,
    client_id integer NOT NULL
);


ALTER TABLE public.client_phones OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 16960)
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
-- TOC entry 2110 (class 0 OID 0)
-- Dependencies: 175
-- Name: client_phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE client_phones_id_seq OWNED BY client_phones.id;


--
-- TOC entry 176 (class 1259 OID 16962)
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
-- TOC entry 177 (class 1259 OID 16968)
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
-- TOC entry 2111 (class 0 OID 0)
-- Dependencies: 177
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- TOC entry 178 (class 1259 OID 16970)
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
-- TOC entry 179 (class 1259 OID 16973)
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
-- TOC entry 2112 (class 0 OID 0)
-- Dependencies: 179
-- Name: order_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE order_products_id_seq OWNED BY order_products.id;


--
-- TOC entry 180 (class 1259 OID 16975)
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
-- TOC entry 2113 (class 0 OID 0)
-- Dependencies: 180
-- Name: order_products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE order_products_product_id_seq OWNED BY order_products.product_id;


--
-- TOC entry 181 (class 1259 OID 16977)
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: kuba; Tablespace:
--

CREATE TABLE order_statuses (
    id bigint NOT NULL,
    status_name character varying NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO kuba;

--
-- TOC entry 182 (class 1259 OID 16983)
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
-- TOC entry 2114 (class 0 OID 0)
-- Dependencies: 182
-- Name: order_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuba
--

ALTER SEQUENCE order_statuses_id_seq OWNED BY order_statuses.id;


--
-- TOC entry 183 (class 1259 OID 16985)
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
-- TOC entry 184 (class 1259 OID 16988)
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
-- TOC entry 2115 (class 0 OID 0)
-- Dependencies: 184
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- TOC entry 185 (class 1259 OID 16990)
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
-- TOC entry 186 (class 1259 OID 16999)
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
-- TOC entry 2116 (class 0 OID 0)
-- Dependencies: 186
-- Name: product_images_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_images_image_id_seq OWNED BY product_images.id;


--
-- TOC entry 187 (class 1259 OID 17001)
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
-- TOC entry 188 (class 1259 OID 17010)
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
-- TOC entry 2117 (class 0 OID 0)
-- Dependencies: 188
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_product_id_seq OWNED BY products.id;


--
-- TOC entry 189 (class 1259 OID 17012)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 17018)
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
-- TOC entry 2118 (class 0 OID 0)
-- Dependencies: 190
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 1928 (class 2604 OID 17020)
-- Name: id; Type: DEFAULT; Schema: public; Owner: kuba
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- TOC entry 1929 (class 2604 OID 17021)
-- Name: id; Type: DEFAULT; Schema: public; Owner: kuba
--

ALTER TABLE ONLY client_addresses ALTER COLUMN id SET DEFAULT nextval('client_addresses_id_seq'::regclass);


--
-- TOC entry 1930 (class 2604 OID 17022)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY client_phones ALTER COLUMN id SET DEFAULT nextval('client_phones_id_seq'::regclass);


--
-- TOC entry 1931 (class 2604 OID 17023)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- TOC entry 1932 (class 2604 OID 17024)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products ALTER COLUMN id SET DEFAULT nextval('order_products_id_seq'::regclass);


--
-- TOC entry 1933 (class 2604 OID 17025)
-- Name: product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products ALTER COLUMN product_id SET DEFAULT nextval('order_products_product_id_seq'::regclass);


--
-- TOC entry 1934 (class 2604 OID 17026)
-- Name: id; Type: DEFAULT; Schema: public; Owner: kuba
--

ALTER TABLE ONLY order_statuses ALTER COLUMN id SET DEFAULT nextval('order_statuses_id_seq'::regclass);


--
-- TOC entry 1935 (class 2604 OID 17027)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- TOC entry 1939 (class 2604 OID 17028)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_images ALTER COLUMN id SET DEFAULT nextval('product_images_image_id_seq'::regclass);


--
-- TOC entry 1943 (class 2604 OID 17029)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('product_product_id_seq'::regclass);


--
-- TOC entry 1944 (class 2604 OID 17030)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 1946 (class 2606 OID 17032)
-- Name: address_pk; Type: CONSTRAINT; Schema: public; Owner: kuba; Tablespace:
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT address_pk PRIMARY KEY (id);


--
-- TOC entry 1948 (class 2606 OID 17034)
-- Name: client_addresses_pk; Type: CONSTRAINT; Schema: public; Owner: kuba; Tablespace:
--

ALTER TABLE ONLY client_addresses
    ADD CONSTRAINT client_addresses_pk PRIMARY KEY (id);


--
-- TOC entry 1953 (class 2606 OID 17036)
-- Name: client_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT client_id PRIMARY KEY (id);


--
-- TOC entry 1977 (class 2606 OID 17038)
-- Name: id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 1969 (class 2606 OID 17040)
-- Name: image_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT image_id PRIMARY KEY (id);


--
-- TOC entry 1967 (class 2606 OID 17042)
-- Name: order_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT order_id PRIMARY KEY (id);


--
-- TOC entry 1959 (class 2606 OID 17044)
-- Name: order_product_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT order_product_id PRIMARY KEY (id);


--
-- TOC entry 1951 (class 2606 OID 17046)
-- Name: phone_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY client_phones
    ADD CONSTRAINT phone_id PRIMARY KEY (id);


--
-- TOC entry 1973 (class 2606 OID 17048)
-- Name: product_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY products
    ADD CONSTRAINT product_id PRIMARY KEY (id);


--
-- TOC entry 1975 (class 2606 OID 17050)
-- Name: product_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY products
    ADD CONSTRAINT product_name_unique UNIQUE (name);


--
-- TOC entry 1961 (class 2606 OID 17115)
-- Name: status_name; Type: CONSTRAINT; Schema: public; Owner: kuba; Tablespace:
--

ALTER TABLE ONLY order_statuses
    ADD CONSTRAINT status_name UNIQUE (status_name);


--
-- TOC entry 1963 (class 2606 OID 17052)
-- Name: status_pk; Type: CONSTRAINT; Schema: public; Owner: kuba; Tablespace:
--

ALTER TABLE ONLY order_statuses
    ADD CONSTRAINT status_pk PRIMARY KEY (id);


--
-- TOC entry 1957 (class 2606 OID 17054)
-- Name: surname_name_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT surname_name_email_unique UNIQUE (name, surname, email);


--
-- TOC entry 1981 (class 2606 OID 17056)
-- Name: username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT username_unique UNIQUE (username);


--
-- TOC entry 1970 (class 1259 OID 17057)
-- Name: description; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX description ON products USING btree (description);


--
-- TOC entry 1954 (class 1259 OID 17058)
-- Name: email_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX email_index ON clients USING btree (email);


--
-- TOC entry 1949 (class 1259 OID 17059)
-- Name: fki_client_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX fki_client_id ON client_phones USING btree (client_id);


--
-- TOC entry 1964 (class 1259 OID 17060)
-- Name: fki_status_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX fki_status_fk ON orders USING btree (status_id);


--
-- TOC entry 1965 (class 1259 OID 17061)
-- Name: fki_user_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX fki_user_pk ON orders USING btree (user_id);


--
-- TOC entry 1971 (class 1259 OID 17062)
-- Name: name; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX name ON products USING btree (name);


--
-- TOC entry 1955 (class 1259 OID 17063)
-- Name: name_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX name_index ON clients USING btree (name);


--
-- TOC entry 1978 (class 1259 OID 17064)
-- Name: password_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX password_index ON users USING btree (password);


--
-- TOC entry 1979 (class 1259 OID 17065)
-- Name: username; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX username ON users USING btree (username);


--
-- TOC entry 1991 (class 2620 OID 17066)
-- Name: update_ab_changetimestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_ab_changetimestamp BEFORE UPDATE ON product_images FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


--
-- TOC entry 1992 (class 2620 OID 17067)
-- Name: update_ab_changetimestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_ab_changetimestamp BEFORE UPDATE ON products FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


--
-- TOC entry 1982 (class 2606 OID 17068)
-- Name: client_addresses_address_pk; Type: FK CONSTRAINT; Schema: public; Owner: kuba
--

ALTER TABLE ONLY client_addresses
    ADD CONSTRAINT client_addresses_address_pk FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- TOC entry 1983 (class 2606 OID 17073)
-- Name: client_addresses_client_pk; Type: FK CONSTRAINT; Schema: public; Owner: kuba
--

ALTER TABLE ONLY client_addresses
    ADD CONSTRAINT client_addresses_client_pk FOREIGN KEY (client_id) REFERENCES clients(id);


--
-- TOC entry 1984 (class 2606 OID 17078)
-- Name: client_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY client_phones
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES clients(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1987 (class 2606 OID 17083)
-- Name: client_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES clients(id);


--
-- TOC entry 1985 (class 2606 OID 17088)
-- Name: order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE;


--
-- TOC entry 1990 (class 2606 OID 17093)
-- Name: product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES products(id);


--
-- TOC entry 1986 (class 2606 OID 17098)
-- Name: product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_products
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES products(id);


--
-- TOC entry 1988 (class 2606 OID 17103)
-- Name: status_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT status_fk FOREIGN KEY (status_id) REFERENCES order_statuses(id);


--
-- TOC entry 1989 (class 2606 OID 17108)
-- Name: user_pk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT user_pk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- TOC entry 2106 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


INSERT INTO users (username, password)
values ('sbd', 'b98d50c159a938723d8eb8f3039afab2');


INSERT INTO order_statuses (id, status_name)
values (1, 'New');

INSERT INTO order_statuses (id, status_name)
values (2, 'Cancelled');

INSERT INTO order_statuses (id, status_name)
values (3, 'Confirmed');
