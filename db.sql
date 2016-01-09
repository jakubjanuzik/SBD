PGDMP     -    
    
    	         t            sbd    9.3.10    9.3.10 S    #           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            $           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            %           1262    16385    sbd    DATABASE     u   CREATE DATABASE sbd WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE sbd;
             kuba    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            &           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    6            '           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    6            �            3079    11789    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            (           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    187            �            1255    16694    update_updated_at_column()    FUNCTION     �   CREATE FUNCTION update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.updated_at = now();
   RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.update_updated_at_column();
       public       postgres    false    6    187            �            1259    16695    client_phones    TABLE     ~   CREATE TABLE client_phones (
    id integer NOT NULL,
    phone character varying NOT NULL,
    client_id integer NOT NULL
);
 !   DROP TABLE public.client_phones;
       public         postgres    false    6            �            1259    16701    client_phones_id_seq    SEQUENCE     v   CREATE SEQUENCE client_phones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.client_phones_id_seq;
       public       postgres    false    6    170            )           0    0    client_phones_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE client_phones_id_seq OWNED BY client_phones.id;
            public       postgres    false    171            �            1259    16703    clients    TABLE     �   CREATE TABLE clients (
    id integer NOT NULL,
    name character varying NOT NULL,
    surname character varying NOT NULL,
    email character varying NOT NULL
);
    DROP TABLE public.clients;
       public         postgres    false    6            �            1259    16709    clients_id_seq    SEQUENCE     p   CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.clients_id_seq;
       public       postgres    false    6    172            *           0    0    clients_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE clients_id_seq OWNED BY clients.id;
            public       postgres    false    173            �            1259    16711    order_products    TABLE     �   CREATE TABLE order_products (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    price double precision,
    quantity integer
);
 "   DROP TABLE public.order_products;
       public         postgres    false    6            �            1259    16714    order_products_id_seq    SEQUENCE     w   CREATE SEQUENCE order_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.order_products_id_seq;
       public       postgres    false    6    174            +           0    0    order_products_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE order_products_id_seq OWNED BY order_products.id;
            public       postgres    false    175            �            1259    16716    order_products_product_id_seq    SEQUENCE        CREATE SEQUENCE order_products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.order_products_product_id_seq;
       public       postgres    false    174    6            ,           0    0    order_products_product_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE order_products_product_id_seq OWNED BY order_products.product_id;
            public       postgres    false    176            �            1259    16808    order_statuses    TABLE     d   CREATE TABLE order_statuses (
    id bigint NOT NULL,
    status_name character varying NOT NULL
);
 "   DROP TABLE public.order_statuses;
       public         kuba    false    6            �            1259    16806    order_statuses_id_seq    SEQUENCE     w   CREATE SEQUENCE order_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.order_statuses_id_seq;
       public       kuba    false    186    6            -           0    0    order_statuses_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE order_statuses_id_seq OWNED BY order_statuses.id;
            public       kuba    false    185            �            1259    16718    orders    TABLE     �   CREATE TABLE orders (
    id bigint NOT NULL,
    client_id bigint NOT NULL,
    status_id bigint NOT NULL,
    user_id bigint NOT NULL
);
    DROP TABLE public.orders;
       public         postgres    false    6            �            1259    16721    orders_id_seq    SEQUENCE     o   CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public       postgres    false    6    177            .           0    0    orders_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE orders_id_seq OWNED BY orders.id;
            public       postgres    false    178            �            1259    16723    product    TABLE     >  CREATE TABLE product (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description character varying,
    price numeric,
    deleted boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.product;
       public         postgres    false    6            �            1259    16732    product_images    TABLE     e  CREATE TABLE product_images (
    id bigint NOT NULL,
    filename character varying,
    caption character varying,
    default_image boolean,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    product_id integer NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);
 "   DROP TABLE public.product_images;
       public         postgres    false    6            �            1259    16741    product_images_image_id_seq    SEQUENCE     }   CREATE SEQUENCE product_images_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.product_images_image_id_seq;
       public       postgres    false    180    6            /           0    0    product_images_image_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE product_images_image_id_seq OWNED BY product_images.id;
            public       postgres    false    181            �            1259    16743    product_product_id_seq    SEQUENCE     x   CREATE SEQUENCE product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.product_product_id_seq;
       public       postgres    false    179    6            0           0    0    product_product_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE product_product_id_seq OWNED BY product.id;
            public       postgres    false    182            �            1259    16745    users    TABLE     t   CREATE TABLE users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    password text NOT NULL
);
    DROP TABLE public.users;
       public         postgres    false    6            �            1259    16751    users_id_seq    SEQUENCE     n   CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       postgres    false    183    6            1           0    0    users_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE users_id_seq OWNED BY users.id;
            public       postgres    false    184            x           2604    16753    id    DEFAULT     f   ALTER TABLE ONLY client_phones ALTER COLUMN id SET DEFAULT nextval('client_phones_id_seq'::regclass);
 ?   ALTER TABLE public.client_phones ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    171    170            y           2604    16754    id    DEFAULT     Z   ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);
 9   ALTER TABLE public.clients ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    173    172            z           2604    16755    id    DEFAULT     h   ALTER TABLE ONLY order_products ALTER COLUMN id SET DEFAULT nextval('order_products_id_seq'::regclass);
 @   ALTER TABLE public.order_products ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    175    174            {           2604    16756 
   product_id    DEFAULT     x   ALTER TABLE ONLY order_products ALTER COLUMN product_id SET DEFAULT nextval('order_products_product_id_seq'::regclass);
 H   ALTER TABLE public.order_products ALTER COLUMN product_id DROP DEFAULT;
       public       postgres    false    176    174            �           2604    16811    id    DEFAULT     h   ALTER TABLE ONLY order_statuses ALTER COLUMN id SET DEFAULT nextval('order_statuses_id_seq'::regclass);
 @   ALTER TABLE public.order_statuses ALTER COLUMN id DROP DEFAULT;
       public       kuba    false    186    185    186            |           2604    16757    id    DEFAULT     X   ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    178    177            �           2604    16758    id    DEFAULT     b   ALTER TABLE ONLY product ALTER COLUMN id SET DEFAULT nextval('product_product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    182    179            �           2604    16759    id    DEFAULT     n   ALTER TABLE ONLY product_images ALTER COLUMN id SET DEFAULT nextval('product_images_image_id_seq'::regclass);
 @   ALTER TABLE public.product_images ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    181    180            �           2604    16760    id    DEFAULT     V   ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    184    183                      0    16695    client_phones 
   TABLE DATA               6   COPY client_phones (id, phone, client_id) FROM stdin;
    public       postgres    false    170   UV       2           0    0    client_phones_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('client_phones_id_seq', 375, true);
            public       postgres    false    171                      0    16703    clients 
   TABLE DATA               4   COPY clients (id, name, surname, email) FROM stdin;
    public       postgres    false    172   �V       3           0    0    clients_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('clients_id_seq', 9, true);
            public       postgres    false    173                      0    16711    order_products 
   TABLE DATA               L   COPY order_products (id, order_id, product_id, price, quantity) FROM stdin;
    public       postgres    false    174   �V       4           0    0    order_products_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('order_products_id_seq', 12, true);
            public       postgres    false    175            5           0    0    order_products_product_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('order_products_product_id_seq', 1, false);
            public       postgres    false    176                       0    16808    order_statuses 
   TABLE DATA               2   COPY order_statuses (id, status_name) FROM stdin;
    public       kuba    false    186   W       6           0    0    order_statuses_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('order_statuses_id_seq', 1, false);
            public       kuba    false    185                      0    16718    orders 
   TABLE DATA               <   COPY orders (id, client_id, status_id, user_id) FROM stdin;
    public       postgres    false    177   [W       7           0    0    orders_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('orders_id_seq', 5, true);
            public       postgres    false    178                      0    16723    product 
   TABLE DATA               Y   COPY product (id, name, description, price, deleted, created_at, updated_at) FROM stdin;
    public       postgres    false    179   �W                 0    16732    product_images 
   TABLE DATA               t   COPY product_images (id, filename, caption, default_image, created_at, updated_at, product_id, deleted) FROM stdin;
    public       postgres    false    180   �W       8           0    0    product_images_image_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('product_images_image_id_seq', 17, true);
            public       postgres    false    181            9           0    0    product_product_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('product_product_id_seq', 23, true);
            public       postgres    false    182                      0    16745    users 
   TABLE DATA               0   COPY users (id, username, password) FROM stdin;
    public       postgres    false    183   BX       :           0    0    users_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('users_id_seq', 1, true);
            public       postgres    false    184            �           2606    16762 	   client_id 
   CONSTRAINT     H   ALTER TABLE ONLY clients
    ADD CONSTRAINT client_id PRIMARY KEY (id);
 ;   ALTER TABLE ONLY public.clients DROP CONSTRAINT client_id;
       public         postgres    false    172    172            �           2606    16764    id 
   CONSTRAINT     ?   ALTER TABLE ONLY users
    ADD CONSTRAINT id PRIMARY KEY (id);
 2   ALTER TABLE ONLY public.users DROP CONSTRAINT id;
       public         postgres    false    183    183            �           2606    16766    image_id 
   CONSTRAINT     N   ALTER TABLE ONLY product_images
    ADD CONSTRAINT image_id PRIMARY KEY (id);
 A   ALTER TABLE ONLY public.product_images DROP CONSTRAINT image_id;
       public         postgres    false    180    180            �           2606    16768    order_id 
   CONSTRAINT     F   ALTER TABLE ONLY orders
    ADD CONSTRAINT order_id PRIMARY KEY (id);
 9   ALTER TABLE ONLY public.orders DROP CONSTRAINT order_id;
       public         postgres    false    177    177            �           2606    16770    order_product_id 
   CONSTRAINT     V   ALTER TABLE ONLY order_products
    ADD CONSTRAINT order_product_id PRIMARY KEY (id);
 I   ALTER TABLE ONLY public.order_products DROP CONSTRAINT order_product_id;
       public         postgres    false    174    174            �           2606    16772    phone_id 
   CONSTRAINT     M   ALTER TABLE ONLY client_phones
    ADD CONSTRAINT phone_id PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.client_phones DROP CONSTRAINT phone_id;
       public         postgres    false    170    170            �           2606    16774 
   product_id 
   CONSTRAINT     I   ALTER TABLE ONLY product
    ADD CONSTRAINT product_id PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.product DROP CONSTRAINT product_id;
       public         postgres    false    179    179            �           2606    16816 	   status_pk 
   CONSTRAINT     O   ALTER TABLE ONLY order_statuses
    ADD CONSTRAINT status_pk PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.order_statuses DROP CONSTRAINT status_pk;
       public         kuba    false    186    186            �           1259    16775    description    INDEX     ?   CREATE INDEX description ON product USING btree (description);
    DROP INDEX public.description;
       public         postgres    false    179            �           1259    16776    fki_client_id    INDEX     E   CREATE INDEX fki_client_id ON client_phones USING btree (client_id);
 !   DROP INDEX public.fki_client_id;
       public         postgres    false    170            �           1259    16827    fki_status_fk    INDEX     >   CREATE INDEX fki_status_fk ON orders USING btree (status_id);
 !   DROP INDEX public.fki_status_fk;
       public         postgres    false    177            �           1259    16833    fki_user_pk    INDEX     :   CREATE INDEX fki_user_pk ON orders USING btree (user_id);
    DROP INDEX public.fki_user_pk;
       public         postgres    false    177            �           1259    16777    name    INDEX     1   CREATE INDEX name ON product USING btree (name);
    DROP INDEX public.name;
       public         postgres    false    179            �           2620    16778    update_ab_changetimestamp    TRIGGER     �   CREATE TRIGGER update_ab_changetimestamp BEFORE UPDATE ON product_images FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();
 A   DROP TRIGGER update_ab_changetimestamp ON public.product_images;
       public       postgres    false    194    180            �           2620    16779    update_ab_changetimestamp    TRIGGER     }   CREATE TRIGGER update_ab_changetimestamp BEFORE UPDATE ON product FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();
 :   DROP TRIGGER update_ab_changetimestamp ON public.product;
       public       postgres    false    194    179            �           2606    16780 	   client_id    FK CONSTRAINT     �   ALTER TABLE ONLY client_phones
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES clients(id) ON UPDATE CASCADE ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.client_phones DROP CONSTRAINT client_id;
       public       postgres    false    1931    170    172            �           2606    16785 	   client_id    FK CONSTRAINT     e   ALTER TABLE ONLY orders
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES clients(id);
 :   ALTER TABLE ONLY public.orders DROP CONSTRAINT client_id;
       public       postgres    false    172    177    1931            �           2606    16790    order_id    FK CONSTRAINT     |   ALTER TABLE ONLY order_products
    ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.order_products DROP CONSTRAINT order_id;
       public       postgres    false    174    1937    177            �           2606    16795 
   product_id    FK CONSTRAINT     o   ALTER TABLE ONLY product_images
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES product(id);
 C   ALTER TABLE ONLY public.product_images DROP CONSTRAINT product_id;
       public       postgres    false    179    1941    180            �           2606    16800 
   product_id    FK CONSTRAINT     o   ALTER TABLE ONLY order_products
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES product(id);
 C   ALTER TABLE ONLY public.order_products DROP CONSTRAINT product_id;
       public       postgres    false    1941    174    179            �           2606    16822 	   status_fk    FK CONSTRAINT     l   ALTER TABLE ONLY orders
    ADD CONSTRAINT status_fk FOREIGN KEY (status_id) REFERENCES order_statuses(id);
 :   ALTER TABLE ONLY public.orders DROP CONSTRAINT status_fk;
       public       postgres    false    1947    186    177            �           2606    16828    user_pk    FK CONSTRAINT     _   ALTER TABLE ONLY orders
    ADD CONSTRAINT user_pk FOREIGN KEY (user_id) REFERENCES users(id);
 8   ALTER TABLE ONLY public.orders DROP CONSTRAINT user_pk;
       public       postgres    false    1945    183    177               "   x�367�4�054�0�4��267E���qqq ~VF         /   x����J�.MR�J�+�����Y �,�!=713G/9?�+F��� �k�         7   x�3�4�42�4�4�@0-9M@LC�24��AR����`9NC.C#$���� �<
/          >   x�3��K-�2�t��K�,�MM�2�tN�KN���M8=�
��ӋR���L9�S�J�b���� ٗ)            x�3��4�4�2�Ҧ@�H��qqq 6<�         :   x�32�I-.��FzF&�i�F�f����
V&�V&z��f��x��b���� �         `   x�}�1� �^��v�����ܻA`,�J�קO�r4|��2{��S�L�a��҇
:Z=��}��{�%0��M}�f
���Ug�1~Vf         4   x�3�,NJ�L��H15H64�L�4�072N�HM�H360�LLKL2����� x
�     