PGDMP                          {            postgres    15.2    15.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    5    postgres    DATABASE        CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE postgres;
                postgres    false                       0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3345                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false                       0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            ?            1259    16489    endereco    TABLE     ?   CREATE TABLE public.endereco (
    idendereco bigint NOT NULL,
    idpessoa bigint NOT NULL,
    dscep character varying(15)
);
    DROP TABLE public.endereco;
       public         heap    postgres    false            ?            1259    16488    endereco_idendereco_seq    SEQUENCE     ?   CREATE SEQUENCE public.endereco_idendereco_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.endereco_idendereco_seq;
       public          postgres    false    218                       0    0    endereco_idendereco_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.endereco_idendereco_seq OWNED BY public.endereco.idendereco;
          public          postgres    false    217            ?            1259    16500    endereco_integracao    TABLE       CREATE TABLE public.endereco_integracao (
    idendereco bigint NOT NULL,
    dsuf character varying(50),
    nmcidade character varying(100),
    nmbairro character varying(50),
    nmlogradouro character varying(100),
    dscomplemento character varying(100)
);
 '   DROP TABLE public.endereco_integracao;
       public         heap    postgres    false            ?            1259    16482    pessoa    TABLE       CREATE TABLE public.pessoa (
    idpessoa bigint NOT NULL,
    flnatureza smallint NOT NULL,
    dsdocumento character varying(20) NOT NULL,
    nmprimeiro character varying(100) NOT NULL,
    nmsegundo character varying(100) NOT NULL,
    dtregistro date
);
    DROP TABLE public.pessoa;
       public         heap    postgres    false            ?            1259    16481    pessoa_idpessoa_seq    SEQUENCE     |   CREATE SEQUENCE public.pessoa_idpessoa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.pessoa_idpessoa_seq;
       public          postgres    false    216                       0    0    pessoa_idpessoa_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.pessoa_idpessoa_seq OWNED BY public.pessoa.idpessoa;
          public          postgres    false    215            p           2604    16492    endereco idendereco    DEFAULT     z   ALTER TABLE ONLY public.endereco ALTER COLUMN idendereco SET DEFAULT nextval('public.endereco_idendereco_seq'::regclass);
 B   ALTER TABLE public.endereco ALTER COLUMN idendereco DROP DEFAULT;
       public          postgres    false    218    217    218            o           2604    16485    pessoa idpessoa    DEFAULT     r   ALTER TABLE ONLY public.pessoa ALTER COLUMN idpessoa SET DEFAULT nextval('public.pessoa_idpessoa_seq'::regclass);
 >   ALTER TABLE public.pessoa ALTER COLUMN idpessoa DROP DEFAULT;
       public          postgres    false    216    215    216            
          0    16489    endereco 
   TABLE DATA           ?   COPY public.endereco (idendereco, idpessoa, dscep) FROM stdin;
    public          postgres    false    218   ?                 0    16500    endereco_integracao 
   TABLE DATA           p   COPY public.endereco_integracao (idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscomplemento) FROM stdin;
    public          postgres    false    219   P                 0    16482    pessoa 
   TABLE DATA           f   COPY public.pessoa (idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro) FROM stdin;
    public          postgres    false    216   m                  0    0    endereco_idendereco_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.endereco_idendereco_seq', 1, false);
          public          postgres    false    217                       0    0    pessoa_idpessoa_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.pessoa_idpessoa_seq', 1, true);
          public          postgres    false    215            v           2606    16504 *   endereco_integracao endereco_integracao_pk 
   CONSTRAINT     p   ALTER TABLE ONLY public.endereco_integracao
    ADD CONSTRAINT endereco_integracao_pk PRIMARY KEY (idendereco);
 T   ALTER TABLE ONLY public.endereco_integracao DROP CONSTRAINT endereco_integracao_pk;
       public            postgres    false    219            t           2606    16494    endereco endereco_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pk PRIMARY KEY (idendereco);
 >   ALTER TABLE ONLY public.endereco DROP CONSTRAINT endereco_pk;
       public            postgres    false    218            r           2606    16487    pessoa pessoa_pk 
   CONSTRAINT     T   ALTER TABLE ONLY public.pessoa
    ADD CONSTRAINT pessoa_pk PRIMARY KEY (idpessoa);
 :   ALTER TABLE ONLY public.pessoa DROP CONSTRAINT pessoa_pk;
       public            postgres    false    216            w           2606    16495    endereco endereco_fk_pessoa    FK CONSTRAINT     ?   ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_fk_pessoa FOREIGN KEY (idpessoa) REFERENCES public.pessoa(idpessoa) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.endereco DROP CONSTRAINT endereco_fk_pessoa;
       public          postgres    false    218    3186    216            x           2606    16505 2   endereco_integracao enderecointegracao_fk_endereco    FK CONSTRAINT     ?   ALTER TABLE ONLY public.endereco_integracao
    ADD CONSTRAINT enderecointegracao_fk_endereco FOREIGN KEY (idendereco) REFERENCES public.endereco(idendereco) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.endereco_integracao DROP CONSTRAINT enderecointegracao_fk_endereco;
       public          postgres    false    219    218    3188            
   E   x?M˹?0?(??݋???ʨ?.؅?V?$v?L??ñ?
??+?&&?B???5z???????            x?????? ? ?         \   x?3?4?r?pu	??t??M?LI?4202?50?5??2?4 ?{?n>6	?
cNc??`Wl?&\\?<??ɛp?A??w???qqq ?)>m     