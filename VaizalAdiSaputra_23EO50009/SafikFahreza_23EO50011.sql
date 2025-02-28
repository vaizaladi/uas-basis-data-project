PGDMP                       }            uas    17.0    17.0 +               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    33241    uas    DATABASE     ~   CREATE DATABASE uas WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE uas;
                     postgres    false            �            1259    33242    orders    TABLE     �  CREATE TABLE public.orders (
    id character varying(100) NOT NULL,
    seller_id character varying(100) NOT NULL,
    seller_name character varying(100) NOT NULL,
    buyer_id character varying(100) NOT NULL,
    buyer_name character varying(100) NOT NULL,
    shipping_name character varying(100) NOT NULL,
    shipping_address character varying(500) NOT NULL,
    shipping_phone character varying(25) NOT NULL,
    logistic_id character varying(100) NOT NULL,
    logistic_name character varying(100) NOT NULL,
    payment_method_id character varying(100) NOT NULL,
    payment_method_name character varying(100) NOT NULL,
    total_quantity integer NOT NULL,
    total_weight integer NOT NULL,
    total_product_amount bigint NOT NULL,
    total_shipping_cost bigint NOT NULL,
    total_shopping_amount bigint NOT NULL,
    service_charge bigint NOT NULL,
    total_amount bigint NOT NULL
);
    DROP TABLE public.orders;
       public         heap r       postgres    false                        0    0    TABLE orders    ACL     f   GRANT ALL ON TABLE public.orders TO superuser_role;
GRANT SELECT ON TABLE public.orders TO user_role;
          public               postgres    false    217            �            1259    33281    products    TABLE     �   CREATE TABLE public.products (
    product_id integer NOT NULL,
    product_name character varying(100) NOT NULL,
    price numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    CONSTRAINT products_stock_check CHECK ((stock >= 0))
);
    DROP TABLE public.products;
       public         heap r       postgres    false            !           0    0    TABLE products    ACL     �   GRANT ALL ON TABLE public.products TO superuser_role;
GRANT INSERT,UPDATE ON TABLE public.products TO admin_role;
GRANT SELECT ON TABLE public.products TO user_role;
          public               postgres    false    221            �            1259    33280    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.products_product_id_seq;
       public               postgres    false    221            "           0    0    products_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;
          public               postgres    false    220            �            1259    33297    transaction_details    TABLE       CREATE TABLE public.transaction_details (
    detail_id integer NOT NULL,
    transaction_id integer,
    product_id integer,
    quantity integer NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    CONSTRAINT transaction_details_quantity_check CHECK ((quantity > 0))
);
 '   DROP TABLE public.transaction_details;
       public         heap r       postgres    false            #           0    0    TABLE transaction_details    ACL     �   GRANT ALL ON TABLE public.transaction_details TO superuser_role;
GRANT INSERT,UPDATE ON TABLE public.transaction_details TO admin_role;
GRANT SELECT ON TABLE public.transaction_details TO user_role;
          public               postgres    false    225            �            1259    33296 !   transaction_details_detail_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transaction_details_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.transaction_details_detail_id_seq;
       public               postgres    false    225            $           0    0 !   transaction_details_detail_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.transaction_details_detail_id_seq OWNED BY public.transaction_details.detail_id;
          public               postgres    false    224            �            1259    33289    transactions    TABLE     �   CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cashier_name character varying(50) NOT NULL
);
     DROP TABLE public.transactions;
       public         heap r       postgres    false            %           0    0    TABLE transactions    ACL     �   GRANT ALL ON TABLE public.transactions TO superuser_role;
GRANT INSERT,UPDATE ON TABLE public.transactions TO admin_role;
GRANT SELECT ON TABLE public.transactions TO user_role;
          public               postgres    false    223            �            1259    33288    transactions_transaction_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.transactions_transaction_id_seq;
       public               postgres    false    223            &           0    0    transactions_transaction_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;
          public               postgres    false    222            �            1259    33271    users    TABLE     g  CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['superuser'::character varying, 'admin'::character varying, 'user'::character varying])::text[])))
);
    DROP TABLE public.users;
       public         heap r       postgres    false            '           0    0    TABLE users    ACL     d   GRANT ALL ON TABLE public.users TO superuser_role;
GRANT SELECT ON TABLE public.users TO user_role;
          public               postgres    false    219            �            1259    33270    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public               postgres    false    219            (           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public               postgres    false    218            k           2604    33284    products product_id    DEFAULT     z   ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 B   ALTER TABLE public.products ALTER COLUMN product_id DROP DEFAULT;
       public               postgres    false    221    220    221            n           2604    33300    transaction_details detail_id    DEFAULT     �   ALTER TABLE ONLY public.transaction_details ALTER COLUMN detail_id SET DEFAULT nextval('public.transaction_details_detail_id_seq'::regclass);
 L   ALTER TABLE public.transaction_details ALTER COLUMN detail_id DROP DEFAULT;
       public               postgres    false    224    225    225            l           2604    33292    transactions transaction_id    DEFAULT     �   ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);
 J   ALTER TABLE public.transactions ALTER COLUMN transaction_id DROP DEFAULT;
       public               postgres    false    222    223    223            j           2604    33274    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               postgres    false    219    218    219                      0    33242    orders 
   TABLE DATA           E  COPY public.orders (id, seller_id, seller_name, buyer_id, buyer_name, shipping_name, shipping_address, shipping_phone, logistic_id, logistic_name, payment_method_id, payment_method_name, total_quantity, total_weight, total_product_amount, total_shipping_cost, total_shopping_amount, service_charge, total_amount) FROM stdin;
    public               postgres    false    217   �7                 0    33281    products 
   TABLE DATA           J   COPY public.products (product_id, product_name, price, stock) FROM stdin;
    public               postgres    false    221   8                 0    33297    transaction_details 
   TABLE DATA           h   COPY public.transaction_details (detail_id, transaction_id, product_id, quantity, subtotal) FROM stdin;
    public               postgres    false    225   _8                 0    33289    transactions 
   TABLE DATA           V   COPY public.transactions (transaction_id, transaction_date, cashier_name) FROM stdin;
    public               postgres    false    223   �8                 0    33271    users 
   TABLE DATA           B   COPY public.users (user_id, username, password, role) FROM stdin;
    public               postgres    false    219   �8       )           0    0    products_product_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.products_product_id_seq', 3, true);
          public               postgres    false    220            *           0    0 !   transaction_details_detail_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.transaction_details_detail_id_seq', 4, true);
          public               postgres    false    224            +           0    0    transactions_transaction_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 2, true);
          public               postgres    false    222            ,           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 5, true);
          public               postgres    false    218            s           2606    33248    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public                 postgres    false    217            y           2606    33287    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public                 postgres    false    221            }           2606    33303 ,   transaction_details transaction_details_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.transaction_details
    ADD CONSTRAINT transaction_details_pkey PRIMARY KEY (detail_id);
 V   ALTER TABLE ONLY public.transaction_details DROP CONSTRAINT transaction_details_pkey;
       public                 postgres    false    225            {           2606    33295    transactions transactions_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public                 postgres    false    223            u           2606    33277    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    219            w           2606    33279    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public                 postgres    false    219            ~           2606    33309 7   transaction_details transaction_details_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction_details
    ADD CONSTRAINT transaction_details_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);
 a   ALTER TABLE ONLY public.transaction_details DROP CONSTRAINT transaction_details_product_id_fkey;
       public               postgres    false    225    4729    221                       2606    33304 ;   transaction_details transaction_details_transaction_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction_details
    ADD CONSTRAINT transaction_details_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.transactions(transaction_id) ON DELETE CASCADE;
 e   ALTER TABLE ONLY public.transaction_details DROP CONSTRAINT transaction_details_transaction_id_fkey;
       public               postgres    false    223    4731    225                  x������ � �         =   x�3�H��4200�30 �\Ɯ�E�ũE���A �e��_������i
Uki����� ��         1   x�3�4B#NC �30�2sM�@�1��B�&`���P�=... m�
*         7   x�3�4202�50�50W04�2��24�336��4�t��LN�2§�)?�+F��� ��         =   x�3�,.-H-JL����,H,..�/J142���qq�eQ��B\Ɯ �2`=1z\\\ ���     