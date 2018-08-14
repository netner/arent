--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Ubuntu 10.4-0ubuntu0.18.04)
-- Dumped by pg_dump version 10.4 (Ubuntu 10.4-0ubuntu0.18.04)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_links; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.access_links (
    id integer NOT NULL,
    role_id integer,
    rule_id integer
);


ALTER TABLE public.access_links OWNER TO "www-data";

--
-- Name: AccessLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."AccessLinks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AccessLinks_id_seq" OWNER TO "www-data";

--
-- Name: AccessLinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."AccessLinks_id_seq" OWNED BY public.access_links.id;


--
-- Name: contact_phones; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.contact_phones (
    id integer NOT NULL,
    customer_id integer,
    phone_num integer
);


ALTER TABLE public.contact_phones OWNER TO "www-data";

--
-- Name: ContactPhones_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ContactPhones_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ContactPhones_id_seq" OWNER TO "www-data";

--
-- Name: ContactPhones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ContactPhones_id_seq" OWNED BY public.contact_phones.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    full_name character varying(255),
    passport_ser character varying(10),
    passport_num character varying(10),
    passport_issue_by character varying(255),
    passport_issue_date date,
    description text,
    ra_building_id integer,
    ra_flat character varying(255),
    aor_building_id integer,
    aor_flat character varying(10),
    birth_date date
);


ALTER TABLE public.customers OWNER TO "www-data";

--
-- Name: Customers_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."Customers_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Customers_id_seq" OWNER TO "www-data";

--
-- Name: Customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."Customers_id_seq" OWNED BY public.customers.id;


--
-- Name: offices; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.offices (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.offices OWNER TO "www-data";

--
-- Name: Offices_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."Offices_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Offices_id_seq" OWNER TO "www-data";

--
-- Name: Offices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."Offices_id_seq" OWNED BY public.offices.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(60),
    password character varying(60),
    email character varying(100),
    role_id integer,
    office_id integer,
    auth_key character varying(100),
    access_token character varying(100)
);


ALTER TABLE public."user" OWNER TO "www-data";

--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Users_id_seq" OWNER TO "www-data";

--
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."Users_id_seq" OWNED BY public."user".id;


--
-- Name: vehicles_f_rent; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.vehicles_f_rent (
    id integer NOT NULL,
    vmodel_id integer,
    ser_num character varying(100),
    reg_num character varying(100),
    year_manufacture date,
    description text,
    actual boolean DEFAULT false,
    pph numeric(9,2) DEFAULT 0
);


ALTER TABLE public.vehicles_f_rent OWNER TO "www-data";

--
-- Name: VehiclesFRent_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."VehiclesFRent_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."VehiclesFRent_id_seq" OWNER TO "www-data";

--
-- Name: VehiclesFRent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."VehiclesFRent_id_seq" OWNED BY public.vehicles_f_rent.id;


--
-- Name: rents; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.rents (
    id integer NOT NULL,
    manager_id integer,
    vfr_id integer,
    customer_id integer,
    start_date date,
    end_date date,
    stop_date date
);


ALTER TABLE public.rents OWNER TO "www-data";

--
-- Name: history; Type: VIEW; Schema: public; Owner: www-data
--

CREATE VIEW public.history AS
 SELECT rents.vfr_id AS _vid,
    rents.start_date AS _start_date,
    rents.end_date AS _end_date,
    rents.stop_date AS _stop_date,
    customers.full_name AS _customer_name,
    "user".username AS _manager_name,
    "user".id AS _manager_id
   FROM public.rents,
    public."user",
    public.customers
  WHERE ((rents.customer_id = customers.id) AND (rents.manager_id = "user".id))
  ORDER BY rents.start_date;


ALTER TABLE public.history OWNER TO "www-data";

--
-- Name: rents_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public.rents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rents_id_seq OWNER TO "www-data";

--
-- Name: rents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public.rents_id_seq OWNED BY public.rents.id;


--
-- Name: sl_access_rules; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.sl_access_rules (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.sl_access_rules OWNER TO "www-data";

--
-- Name: sl_AccessRules_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."sl_AccessRules_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."sl_AccessRules_id_seq" OWNER TO "www-data";

--
-- Name: sl_AccessRules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."sl_AccessRules_id_seq" OWNED BY public.sl_access_rules.id;


--
-- Name: ul_vehicle_brands; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.ul_vehicle_brands (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.ul_vehicle_brands OWNER TO "www-data";

--
-- Name: ul_vehicle_models; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.ul_vehicle_models (
    id integer NOT NULL,
    name character varying(100),
    vbrand_id integer,
    vtype_id integer
);


ALTER TABLE public.ul_vehicle_models OWNER TO "www-data";

--
-- Name: ul_vehicle_types; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.ul_vehicle_types (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.ul_vehicle_types OWNER TO "www-data";

--
-- Name: vehicles; Type: VIEW; Schema: public; Owner: www-data
--

CREATE VIEW public.vehicles AS
 SELECT vt.name AS _type,
    vb.name AS _brand,
    vm.name AS _model,
    vfr.reg_num AS _rnum,
    vfr.year_manufacture AS _yman,
    vfr.pph AS _pph,
    vfr.actual AS _actual,
    vfr.id AS _id
   FROM public.vehicles_f_rent vfr,
    public.ul_vehicle_brands vb,
    public.ul_vehicle_models vm,
    public.ul_vehicle_types vt
  WHERE ((vfr.vmodel_id = vm.id) AND (vm.vbrand_id = vb.id) AND (vm.vtype_id = vt.id));


ALTER TABLE public.vehicles OWNER TO "www-data";

--
-- Name: statistic; Type: VIEW; Schema: public; Owner: www-data
--

CREATE VIEW public.statistic AS
 SELECT vehicles._brand AS brand_,
    offices.name AS office_,
    avg(( SELECT (date_part('epoch'::text, age((history._end_date)::timestamp with time zone, (history._start_date)::timestamp with time zone)) / (3600)::double precision))) AS rent_time
   FROM public.history,
    public."user",
    public.offices,
    public.vehicles
  WHERE ((history._vid = vehicles._id) AND (history._manager_id = "user".id) AND ("user".office_id = offices.id))
  GROUP BY offices.name, vehicles._brand
  ORDER BY offices.name;


ALTER TABLE public.statistic OWNER TO "www-data";

--
-- Name: ul_buildings; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.ul_buildings (
    id integer NOT NULL,
    street_id integer,
    name character varying(10)
);


ALTER TABLE public.ul_buildings OWNER TO "www-data";

--
-- Name: ul_Buildings_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ul_Buildings_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ul_Buildings_id_seq" OWNER TO "www-data";

--
-- Name: ul_Buildings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ul_Buildings_id_seq" OWNED BY public.ul_buildings.id;


--
-- Name: ul_countries; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.ul_countries (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.ul_countries OWNER TO "www-data";

--
-- Name: ul_Countries_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ul_Countries_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ul_Countries_id_seq" OWNER TO "www-data";

--
-- Name: ul_Countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ul_Countries_id_seq" OWNED BY public.ul_countries.id;


--
-- Name: ul_loc_types; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.ul_loc_types (
    id integer NOT NULL,
    name character varying(60)
);


ALTER TABLE public.ul_loc_types OWNER TO "www-data";

--
-- Name: ul_LocTypes_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ul_LocTypes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ul_LocTypes_id_seq" OWNER TO "www-data";

--
-- Name: ul_LocTypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ul_LocTypes_id_seq" OWNED BY public.ul_loc_types.id;


--
-- Name: ul_localities; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.ul_localities (
    id integer NOT NULL,
    ltype_id integer,
    country_id integer,
    name character varying(100)
);


ALTER TABLE public.ul_localities OWNER TO "www-data";

--
-- Name: ul_Localities_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ul_Localities_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ul_Localities_id_seq" OWNER TO "www-data";

--
-- Name: ul_Localities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ul_Localities_id_seq" OWNED BY public.ul_localities.id;


--
-- Name: ul_street_types; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.ul_street_types (
    id integer NOT NULL,
    name character varying(60)
);


ALTER TABLE public.ul_street_types OWNER TO "www-data";

--
-- Name: ul_StreetTypes_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ul_StreetTypes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ul_StreetTypes_id_seq" OWNER TO "www-data";

--
-- Name: ul_StreetTypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ul_StreetTypes_id_seq" OWNED BY public.ul_street_types.id;


--
-- Name: ul_streets; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.ul_streets (
    id integer NOT NULL,
    stype_id integer,
    name character varying(60),
    local_id integer
);


ALTER TABLE public.ul_streets OWNER TO "www-data";

--
-- Name: ul_Streets_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ul_Streets_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ul_Streets_id_seq" OWNER TO "www-data";

--
-- Name: ul_Streets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ul_Streets_id_seq" OWNED BY public.ul_streets.id;


--
-- Name: ul_user_roles; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE public.ul_user_roles (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.ul_user_roles OWNER TO "www-data";

--
-- Name: ul_UserRoles_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ul_UserRoles_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ul_UserRoles_id_seq" OWNER TO "www-data";

--
-- Name: ul_UserRoles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ul_UserRoles_id_seq" OWNED BY public.ul_user_roles.id;


--
-- Name: ul_VehicleBrands_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ul_VehicleBrands_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ul_VehicleBrands_id_seq" OWNER TO "www-data";

--
-- Name: ul_VehicleBrands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ul_VehicleBrands_id_seq" OWNED BY public.ul_vehicle_brands.id;


--
-- Name: ul_VehicleTypes_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ul_VehicleTypes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ul_VehicleTypes_id_seq" OWNER TO "www-data";

--
-- Name: ul_VehicleTypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ul_VehicleTypes_id_seq" OWNED BY public.ul_vehicle_types.id;


--
-- Name: ul_VehileModels_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE public."ul_VehileModels_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ul_VehileModels_id_seq" OWNER TO "www-data";

--
-- Name: ul_VehileModels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public."ul_VehileModels_id_seq" OWNED BY public.ul_vehicle_models.id;


--
-- Name: access_links id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.access_links ALTER COLUMN id SET DEFAULT nextval('public."AccessLinks_id_seq"'::regclass);


--
-- Name: contact_phones id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.contact_phones ALTER COLUMN id SET DEFAULT nextval('public."ContactPhones_id_seq"'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public."Customers_id_seq"'::regclass);


--
-- Name: offices id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.offices ALTER COLUMN id SET DEFAULT nextval('public."Offices_id_seq"'::regclass);


--
-- Name: rents id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.rents ALTER COLUMN id SET DEFAULT nextval('public.rents_id_seq'::regclass);


--
-- Name: sl_access_rules id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sl_access_rules ALTER COLUMN id SET DEFAULT nextval('public."sl_AccessRules_id_seq"'::regclass);


--
-- Name: ul_buildings id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_buildings ALTER COLUMN id SET DEFAULT nextval('public."ul_Buildings_id_seq"'::regclass);


--
-- Name: ul_countries id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_countries ALTER COLUMN id SET DEFAULT nextval('public."ul_Countries_id_seq"'::regclass);


--
-- Name: ul_loc_types id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_loc_types ALTER COLUMN id SET DEFAULT nextval('public."ul_LocTypes_id_seq"'::regclass);


--
-- Name: ul_localities id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_localities ALTER COLUMN id SET DEFAULT nextval('public."ul_Localities_id_seq"'::regclass);


--
-- Name: ul_street_types id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_street_types ALTER COLUMN id SET DEFAULT nextval('public."ul_StreetTypes_id_seq"'::regclass);


--
-- Name: ul_streets id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_streets ALTER COLUMN id SET DEFAULT nextval('public."ul_Streets_id_seq"'::regclass);


--
-- Name: ul_user_roles id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_user_roles ALTER COLUMN id SET DEFAULT nextval('public."ul_UserRoles_id_seq"'::regclass);


--
-- Name: ul_vehicle_brands id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_vehicle_brands ALTER COLUMN id SET DEFAULT nextval('public."ul_VehicleBrands_id_seq"'::regclass);


--
-- Name: ul_vehicle_models id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_vehicle_models ALTER COLUMN id SET DEFAULT nextval('public."ul_VehileModels_id_seq"'::regclass);


--
-- Name: ul_vehicle_types id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_vehicle_types ALTER COLUMN id SET DEFAULT nextval('public."ul_VehicleTypes_id_seq"'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);


--
-- Name: vehicles_f_rent id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.vehicles_f_rent ALTER COLUMN id SET DEFAULT nextval('public."VehiclesFRent_id_seq"'::regclass);


--
-- Name: access_links AccessLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.access_links
    ADD CONSTRAINT "AccessLinks_pkey" PRIMARY KEY (id);


--
-- Name: contact_phones ContactPhones_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.contact_phones
    ADD CONSTRAINT "ContactPhones_pkey" PRIMARY KEY (id);


--
-- Name: customers Customers_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT "Customers_pkey" PRIMARY KEY (id);


--
-- Name: offices Offices_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.offices
    ADD CONSTRAINT "Offices_pkey" PRIMARY KEY (id);


--
-- Name: offices Offices_u0; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.offices
    ADD CONSTRAINT "Offices_u0" UNIQUE (name);


--
-- Name: user Users_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: user Users_u0; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "Users_u0" UNIQUE (username);


--
-- Name: user Users_u1; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "Users_u1" UNIQUE (email);


--
-- Name: vehicles_f_rent VehiclesFRent_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.vehicles_f_rent
    ADD CONSTRAINT "VehiclesFRent_pkey" PRIMARY KEY (id);


--
-- Name: rents rents_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.rents
    ADD CONSTRAINT rents_pkey PRIMARY KEY (id);


--
-- Name: sl_access_rules sl_AccessRules_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sl_access_rules
    ADD CONSTRAINT "sl_AccessRules_pkey" PRIMARY KEY (id);


--
-- Name: sl_access_rules sl_AccessRules_u0; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sl_access_rules
    ADD CONSTRAINT "sl_AccessRules_u0" UNIQUE (name);


--
-- Name: ul_countries ul_Countries_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_countries
    ADD CONSTRAINT "ul_Countries_pkey" PRIMARY KEY (id);


--
-- Name: ul_countries ul_Countries_u0; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_countries
    ADD CONSTRAINT "ul_Countries_u0" UNIQUE (name);


--
-- Name: ul_loc_types ul_LocTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_loc_types
    ADD CONSTRAINT "ul_LocTypes_pkey" PRIMARY KEY (id);


--
-- Name: ul_loc_types ul_LocTypes_u0; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_loc_types
    ADD CONSTRAINT "ul_LocTypes_u0" UNIQUE (name);


--
-- Name: ul_localities ul_Localities_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_localities
    ADD CONSTRAINT "ul_Localities_pkey" PRIMARY KEY (id);


--
-- Name: ul_street_types ul_StreetTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_street_types
    ADD CONSTRAINT "ul_StreetTypes_pkey" PRIMARY KEY (id);


--
-- Name: ul_street_types ul_StreetTypes_u0; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_street_types
    ADD CONSTRAINT "ul_StreetTypes_u0" UNIQUE (name);


--
-- Name: ul_streets ul_Streets_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_streets
    ADD CONSTRAINT "ul_Streets_pkey" PRIMARY KEY (id);


--
-- Name: ul_user_roles ul_UserRoles_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_user_roles
    ADD CONSTRAINT "ul_UserRoles_pkey" PRIMARY KEY (id);


--
-- Name: ul_user_roles ul_UserRoles_u0; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_user_roles
    ADD CONSTRAINT "ul_UserRoles_u0" UNIQUE (name);


--
-- Name: ul_vehicle_brands ul_VehicleBrands_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_vehicle_brands
    ADD CONSTRAINT "ul_VehicleBrands_pkey" PRIMARY KEY (id);


--
-- Name: ul_vehicle_brands ul_VehicleBrands_u0; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_vehicle_brands
    ADD CONSTRAINT "ul_VehicleBrands_u0" UNIQUE (name);


--
-- Name: ul_vehicle_types ul_VehicleTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_vehicle_types
    ADD CONSTRAINT "ul_VehicleTypes_pkey" PRIMARY KEY (id);


--
-- Name: ul_vehicle_types ul_VehicleTypes_u0; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_vehicle_types
    ADD CONSTRAINT "ul_VehicleTypes_u0" UNIQUE (name);


--
-- Name: ul_vehicle_models ul_VehileModels_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_vehicle_models
    ADD CONSTRAINT "ul_VehileModels_pkey" PRIMARY KEY (id);


--
-- Name: AccessLinks_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "AccessLinks_in0" ON public.access_links USING btree (id);


--
-- Name: ContactPhones_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ContactPhones_in0" ON public.contact_phones USING btree (id);


--
-- Name: Customers_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "Customers_in0" ON public.customers USING btree (id);


--
-- Name: Offices_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "Offices_in0" ON public.offices USING btree (id);


--
-- Name: Rents_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "Rents_in0" ON public.rents USING btree (id);


--
-- Name: Users_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "Users_in0" ON public."user" USING btree (id);


--
-- Name: VehiclesFRent_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "VehiclesFRent_in0" ON public.vehicles_f_rent USING btree (id);


--
-- Name: sl_AccessRules_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "sl_AccessRules_in0" ON public.sl_access_rules USING btree (id);


--
-- Name: ul_Buildings_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ul_Buildings_in0" ON public.ul_buildings USING btree (id);


--
-- Name: ul_Countries_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ul_Countries_in0" ON public.ul_countries USING btree (id);


--
-- Name: ul_LocTypes_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ul_LocTypes_in0" ON public.ul_loc_types USING btree (id);


--
-- Name: ul_Localities_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ul_Localities_in0" ON public.ul_localities USING btree (id);


--
-- Name: ul_StreetTypes_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ul_StreetTypes_in0" ON public.ul_street_types USING btree (id);


--
-- Name: ul_Streets_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ul_Streets_in0" ON public.ul_streets USING btree (id);


--
-- Name: ul_UserRoles_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ul_UserRoles_in0" ON public.ul_user_roles USING btree (id);


--
-- Name: ul_VehicleBrands_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ul_VehicleBrands_in0" ON public.ul_vehicle_brands USING btree (id);


--
-- Name: ul_VehicleModels_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ul_VehicleModels_in0" ON public.ul_vehicle_models USING btree (id);


--
-- Name: ul_VehicleTypes_in0; Type: INDEX; Schema: public; Owner: www-data
--

CREATE UNIQUE INDEX "ul_VehicleTypes_in0" ON public.ul_vehicle_types USING btree (id);


--
-- Name: access_links AccessLinks_fk0; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.access_links
    ADD CONSTRAINT "AccessLinks_fk0" FOREIGN KEY (role_id) REFERENCES public.ul_user_roles(id);


--
-- Name: access_links AccessLinks_fk1; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.access_links
    ADD CONSTRAINT "AccessLinks_fk1" FOREIGN KEY (rule_id) REFERENCES public.sl_access_rules(id);


--
-- Name: contact_phones ContactPhones_fk0; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.contact_phones
    ADD CONSTRAINT "ContactPhones_fk0" FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: customers Customers_fk0; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT "Customers_fk0" FOREIGN KEY (ra_building_id) REFERENCES public.ul_buildings(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: customers Customers_fk1; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT "Customers_fk1" FOREIGN KEY (aor_building_id) REFERENCES public.ul_buildings(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rents Rents_fk0; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.rents
    ADD CONSTRAINT "Rents_fk0" FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rents Rents_fk1; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.rents
    ADD CONSTRAINT "Rents_fk1" FOREIGN KEY (manager_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rents Rents_fk2; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.rents
    ADD CONSTRAINT "Rents_fk2" FOREIGN KEY (vfr_id) REFERENCES public.vehicles_f_rent(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user Users_fk0; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "Users_fk0" FOREIGN KEY (role_id) REFERENCES public.ul_user_roles(id);


--
-- Name: user Users_fk1; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "Users_fk1" FOREIGN KEY (office_id) REFERENCES public.offices(id);


--
-- Name: vehicles_f_rent VehiclesFRent_fk0; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.vehicles_f_rent
    ADD CONSTRAINT "VehiclesFRent_fk0" FOREIGN KEY (vmodel_id) REFERENCES public.ul_vehicle_models(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ul_buildings ul_Buildings_fk0; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_buildings
    ADD CONSTRAINT "ul_Buildings_fk0" FOREIGN KEY (street_id) REFERENCES public.ul_streets(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ul_localities ul_Localities_fk0; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_localities
    ADD CONSTRAINT "ul_Localities_fk0" FOREIGN KEY (ltype_id) REFERENCES public.ul_loc_types(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ul_localities ul_Localities_fk1; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_localities
    ADD CONSTRAINT "ul_Localities_fk1" FOREIGN KEY (country_id) REFERENCES public.ul_countries(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ul_streets ul_Streets_fk0; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_streets
    ADD CONSTRAINT "ul_Streets_fk0" FOREIGN KEY (stype_id) REFERENCES public.ul_street_types(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ul_streets ul_Streets_fk1; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_streets
    ADD CONSTRAINT "ul_Streets_fk1" FOREIGN KEY (local_id) REFERENCES public.ul_localities(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ul_vehicle_models ul_VehicleModels_fk0; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_vehicle_models
    ADD CONSTRAINT "ul_VehicleModels_fk0" FOREIGN KEY (vbrand_id) REFERENCES public.ul_vehicle_brands(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ul_vehicle_models ul_VehicleModels_fk1; Type: FK CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ul_vehicle_models
    ADD CONSTRAINT "ul_VehicleModels_fk1" FOREIGN KEY (vtype_id) REFERENCES public.ul_vehicle_types(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

