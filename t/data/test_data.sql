--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.tissue DROP CONSTRAINT tissue_organism_fkey;
ALTER TABLE ONLY public.sequencing_run DROP CONSTRAINT sequencing_run_sequencing_type_fkey;
ALTER TABLE ONLY public.sequencing_run DROP CONSTRAINT sequencing_run_sequencing_sample_fkey;
ALTER TABLE ONLY public.sequencing_run DROP CONSTRAINT sequencing_run_sequencing_centre_fkey;
ALTER TABLE ONLY public.sequencing_run DROP CONSTRAINT sequencing_run_quality_fkey;
ALTER TABLE ONLY public.sequencing_run DROP CONSTRAINT sequencing_run_initial_pipeprocess_fkey;
ALTER TABLE ONLY public.sequencing_run DROP CONSTRAINT sequencing_run_initial_pipedata_fkey;
ALTER TABLE ONLY public.pub DROP CONSTRAINT pub_type_id_fkey;
ALTER TABLE ONLY public.pub_dbxref DROP CONSTRAINT pub_dbxref_pub_id_fkey;
ALTER TABLE ONLY public.pub_dbxref DROP CONSTRAINT pub_dbxref_dbxref_id_fkey;
ALTER TABLE ONLY public.process_conf DROP CONSTRAINT process_conf_type_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_process_conf_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_format_type_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_ecotype_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_content_type_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_biosample_type_fkey;
ALTER TABLE ONLY public.pipeproject DROP CONSTRAINT pipeproject_owner_fkey;
ALTER TABLE ONLY public.pipeproject DROP CONSTRAINT pipeproject_funder_fkey;
ALTER TABLE ONLY public.pipeprocess DROP CONSTRAINT pipeprocess_status_fkey;
ALTER TABLE ONLY public.pipeprocess_pub DROP CONSTRAINT pipeprocess_pub_pub_fk;
ALTER TABLE ONLY public.pipeprocess_pub DROP CONSTRAINT pipeprocess_pub_pipeprocess_fk;
ALTER TABLE ONLY public.pipeprocess DROP CONSTRAINT pipeprocess_process_conf_fkey;
ALTER TABLE ONLY public.pipeprocess_in_pipedata DROP CONSTRAINT pipeprocess_in_pipedata_pipeprocess_fkey;
ALTER TABLE ONLY public.pipeprocess_in_pipedata DROP CONSTRAINT pipeprocess_in_pipedata_pipedata_fkey;
ALTER TABLE ONLY public.pipedata_property DROP CONSTRAINT pipedata_property_type_fkey;
ALTER TABLE ONLY public.pipedata_property DROP CONSTRAINT pipedata_property_pipedata_fkey;
ALTER TABLE ONLY public.pipedata DROP CONSTRAINT pipedata_generating_pipeprocess_fkey;
ALTER TABLE ONLY public.pipedata DROP CONSTRAINT pipedata_format_type_fkey;
ALTER TABLE ONLY public.pipedata DROP CONSTRAINT pipedata_content_type_fkey;
ALTER TABLE ONLY public.person DROP CONSTRAINT person_role_fkey;
ALTER TABLE ONLY public.person DROP CONSTRAINT person_organisation_fkey;
ALTER TABLE ONLY public.organism_dbxref DROP CONSTRAINT organism_dbxref_organism_id_fkey;
ALTER TABLE ONLY public.organism_dbxref DROP CONSTRAINT organism_dbxref_dbxref_id_fkey;
ALTER TABLE ONLY public.library DROP CONSTRAINT library_sequencing_sample_fkey;
ALTER TABLE ONLY public.library DROP CONSTRAINT library_library_type_fkey;
ALTER TABLE ONLY public.library DROP CONSTRAINT library_biosample_fkey;
ALTER TABLE ONLY public.library DROP CONSTRAINT library_barcode_fkey;
ALTER TABLE ONLY public.library DROP CONSTRAINT library_adaptor_fkey;
ALTER TABLE ONLY public.ecotype DROP CONSTRAINT ecotype_organism_fkey;
ALTER TABLE ONLY public.dbxref DROP CONSTRAINT dbxref_db_id_fkey;
ALTER TABLE ONLY public.cvterm DROP CONSTRAINT cvterm_dbxref_id_fkey;
ALTER TABLE ONLY public.cvterm_dbxref DROP CONSTRAINT cvterm_dbxref_dbxref_id_fkey;
ALTER TABLE ONLY public.cvterm_dbxref DROP CONSTRAINT cvterm_dbxref_cvterm_id_fkey;
ALTER TABLE ONLY public.cvterm DROP CONSTRAINT cvterm_cv_id_fkey;
ALTER TABLE ONLY public.biosample DROP CONSTRAINT biosample_treatment_type_fkey;
ALTER TABLE ONLY public.biosample DROP CONSTRAINT biosample_tissue_fkey;
ALTER TABLE ONLY public.biosample DROP CONSTRAINT biosample_protocol_fkey;
ALTER TABLE ONLY public.biosample DROP CONSTRAINT biosample_processing_requirement_fkey;
ALTER TABLE ONLY public.biosample_pipeproject DROP CONSTRAINT biosample_pipeproject_pipeproject_fkey;
ALTER TABLE ONLY public.biosample_pipeproject DROP CONSTRAINT biosample_pipeproject_biosample_fkey;
ALTER TABLE ONLY public.biosample_pipedata DROP CONSTRAINT biosample_pipedata_pipedata_fkey;
ALTER TABLE ONLY public.biosample_pipedata DROP CONSTRAINT biosample_pipedata_biosample_fkey;
ALTER TABLE ONLY public.biosample DROP CONSTRAINT biosample_molecule_type_fkey;
ALTER TABLE ONLY public.biosample DROP CONSTRAINT biosample_fractionation_type_fkey;
ALTER TABLE ONLY public.biosample_ecotype DROP CONSTRAINT biosample_ecotype_ecotype_fkey;
ALTER TABLE ONLY public.biosample_ecotype DROP CONSTRAINT biosample_ecotype_biosample_fkey;
ALTER TABLE ONLY public.biosample_dbxref DROP CONSTRAINT biosample_dbxref_dbxref_fk;
ALTER TABLE ONLY public.biosample_dbxref DROP CONSTRAINT biosample_dbxref_biosample_fk;
ALTER TABLE ONLY public.biosample DROP CONSTRAINT biosample_biosample_type_fkey;
ALTER TABLE ONLY public.barcode_set DROP CONSTRAINT barcode_set_position_in_read_fkey;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_barcode_set_fkey;
DROP INDEX public.pub_idx1;
DROP INDEX public.pub_dbxref_idx2;
DROP INDEX public.pub_dbxref_idx1;
DROP INDEX public.organism_dbxref_idx2;
DROP INDEX public.organism_dbxref_idx1;
DROP INDEX public.dbxref_idx3;
DROP INDEX public.dbxref_idx2;
DROP INDEX public.dbxref_idx1;
DROP INDEX public.cvterm_idx3;
DROP INDEX public.cvterm_idx2;
DROP INDEX public.cvterm_idx1;
DROP INDEX public.cvterm_dbxref_idx2;
DROP INDEX public.cvterm_dbxref_idx1;
ALTER TABLE ONLY public.tissue DROP CONSTRAINT tissue_id_pk;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_identifier_key;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_id_pk;
ALTER TABLE ONLY public.sequencing_sample DROP CONSTRAINT sequencing_sample_name_key;
ALTER TABLE ONLY public.sequencing_sample DROP CONSTRAINT sequencing_sample_id_pk;
ALTER TABLE ONLY public.sequencing_run DROP CONSTRAINT sequencing_run_identifier_key;
ALTER TABLE ONLY public.sequencing_run DROP CONSTRAINT sequencing_run_id_pk;
ALTER TABLE ONLY public.pub DROP CONSTRAINT pub_pkey;
ALTER TABLE ONLY public.pub_dbxref DROP CONSTRAINT pub_dbxref_pkey;
ALTER TABLE ONLY public.pub_dbxref DROP CONSTRAINT pub_dbxref_c1;
ALTER TABLE ONLY public.pub DROP CONSTRAINT pub_c1;
ALTER TABLE ONLY public.protocol DROP CONSTRAINT protocol_name_key;
ALTER TABLE ONLY public.protocol DROP CONSTRAINT protocol_id_pk;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_id_pk;
ALTER TABLE ONLY public.process_conf DROP CONSTRAINT process_conf_id_pk;
ALTER TABLE ONLY public.pipeproject DROP CONSTRAINT pipeproject_id_pk;
ALTER TABLE ONLY public.pipeprocess_pub DROP CONSTRAINT pipeprocess_pub_id_pk;
ALTER TABLE ONLY public.pipeprocess_in_pipedata DROP CONSTRAINT pipeprocess_in_pk_constraint;
ALTER TABLE ONLY public.pipeprocess_in_pipedata DROP CONSTRAINT pipeprocess_in_pipedata_id_pk;
ALTER TABLE ONLY public.pipeprocess DROP CONSTRAINT pipeprocess_id_pk;
ALTER TABLE ONLY public.pipedata_property DROP CONSTRAINT pipedata_property_id_pk;
ALTER TABLE ONLY public.pipedata DROP CONSTRAINT pipedata_id_pk;
ALTER TABLE ONLY public.pipedata DROP CONSTRAINT pipedata_file_name_key;
ALTER TABLE ONLY public.person DROP CONSTRAINT person_username_key;
ALTER TABLE ONLY public.person DROP CONSTRAINT person_id_pk;
ALTER TABLE ONLY public.person DROP CONSTRAINT person_full_name_constraint;
ALTER TABLE ONLY public.organism DROP CONSTRAINT organism_pkey;
ALTER TABLE ONLY public.organism_dbxref DROP CONSTRAINT organism_dbxref_pkey;
ALTER TABLE ONLY public.organism_dbxref DROP CONSTRAINT organism_dbxref_c1;
ALTER TABLE ONLY public.organism DROP CONSTRAINT organism_c1;
ALTER TABLE ONLY public.organisation DROP CONSTRAINT organisation_id_pk;
ALTER TABLE ONLY public.library DROP CONSTRAINT library_name_key;
ALTER TABLE ONLY public.library DROP CONSTRAINT library_id_pk;
ALTER TABLE ONLY public.ecotype DROP CONSTRAINT ecotype_id_pk;
ALTER TABLE ONLY public.dbxref DROP CONSTRAINT dbxref_pkey;
ALTER TABLE ONLY public.dbxref DROP CONSTRAINT dbxref_c1;
ALTER TABLE ONLY public.db DROP CONSTRAINT db_pkey;
ALTER TABLE ONLY public.db DROP CONSTRAINT db_c1;
ALTER TABLE ONLY public.cvterm DROP CONSTRAINT cvterm_pkey;
ALTER TABLE ONLY public.cvterm_dbxref DROP CONSTRAINT cvterm_dbxref_pkey;
ALTER TABLE ONLY public.cvterm_dbxref DROP CONSTRAINT cvterm_dbxref_c1;
ALTER TABLE ONLY public.cvterm DROP CONSTRAINT cvterm_c2;
ALTER TABLE ONLY public.cvterm DROP CONSTRAINT cvterm_c1;
ALTER TABLE ONLY public.cv DROP CONSTRAINT cv_pkey;
ALTER TABLE ONLY public.cv DROP CONSTRAINT cv_c1;
ALTER TABLE ONLY public.biosample_pipeproject DROP CONSTRAINT biosample_pipeproject_id_pk;
ALTER TABLE ONLY public.biosample_pipeproject DROP CONSTRAINT biosample_pipeproject_constraint;
ALTER TABLE ONLY public.biosample_pipedata DROP CONSTRAINT biosample_pipedata_id_pk;
ALTER TABLE ONLY public.biosample DROP CONSTRAINT biosample_name_key;
ALTER TABLE ONLY public.biosample DROP CONSTRAINT biosample_id_pk;
ALTER TABLE ONLY public.biosample_ecotype DROP CONSTRAINT biosample_ecotype_id_pk;
ALTER TABLE ONLY public.biosample_ecotype DROP CONSTRAINT biosample_ecotype_constraint;
ALTER TABLE ONLY public.barcode_set DROP CONSTRAINT barcode_set_name_key;
ALTER TABLE ONLY public.barcode_set DROP CONSTRAINT barcode_set_id_pk;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_identifier_constraint;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_id_pk;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_code_constraint;
ALTER TABLE public.tissue ALTER COLUMN tissue_id DROP DEFAULT;
ALTER TABLE public.sequencingrun ALTER COLUMN sequencingrun_id DROP DEFAULT;
ALTER TABLE public.sequencing_sample ALTER COLUMN sequencing_sample_id DROP DEFAULT;
ALTER TABLE public.sequencing_run ALTER COLUMN sequencing_run_id DROP DEFAULT;
ALTER TABLE public.pub_dbxref ALTER COLUMN pub_dbxref_id DROP DEFAULT;
ALTER TABLE public.pub ALTER COLUMN pub_id DROP DEFAULT;
ALTER TABLE public.protocol ALTER COLUMN protocol_id DROP DEFAULT;
ALTER TABLE public.process_conf_input ALTER COLUMN process_conf_input_id DROP DEFAULT;
ALTER TABLE public.process_conf ALTER COLUMN process_conf_id DROP DEFAULT;
ALTER TABLE public.pipeproject ALTER COLUMN pipeproject_id DROP DEFAULT;
ALTER TABLE public.pipeprocess_pub ALTER COLUMN pipeprocess_pub_id DROP DEFAULT;
ALTER TABLE public.pipeprocess_in_pipedata ALTER COLUMN pipeprocess_in_pipedata_id DROP DEFAULT;
ALTER TABLE public.pipeprocess ALTER COLUMN pipeprocess_id DROP DEFAULT;
ALTER TABLE public.pipedata_property ALTER COLUMN pipedata_property_id DROP DEFAULT;
ALTER TABLE public.pipedata ALTER COLUMN pipedata_id DROP DEFAULT;
ALTER TABLE public.person ALTER COLUMN person_id DROP DEFAULT;
ALTER TABLE public.organism_dbxref ALTER COLUMN organism_dbxref_id DROP DEFAULT;
ALTER TABLE public.organism ALTER COLUMN organism_id DROP DEFAULT;
ALTER TABLE public.organisation ALTER COLUMN organisation_id DROP DEFAULT;
ALTER TABLE public.library ALTER COLUMN library_id DROP DEFAULT;
ALTER TABLE public.ecotype ALTER COLUMN ecotype_id DROP DEFAULT;
ALTER TABLE public.dbxref ALTER COLUMN dbxref_id DROP DEFAULT;
ALTER TABLE public.db ALTER COLUMN db_id DROP DEFAULT;
ALTER TABLE public.cvterm_dbxref ALTER COLUMN cvterm_dbxref_id DROP DEFAULT;
ALTER TABLE public.cvterm ALTER COLUMN cvterm_id DROP DEFAULT;
ALTER TABLE public.cv ALTER COLUMN cv_id DROP DEFAULT;
ALTER TABLE public.biosample_pipeproject ALTER COLUMN biosample_pipeproject_id DROP DEFAULT;
ALTER TABLE public.biosample_pipedata ALTER COLUMN biosample_pipedata_id DROP DEFAULT;
ALTER TABLE public.biosample_ecotype ALTER COLUMN biosample_ecotype_id DROP DEFAULT;
ALTER TABLE public.biosample ALTER COLUMN biosample_id DROP DEFAULT;
ALTER TABLE public.barcode_set ALTER COLUMN barcode_set_id DROP DEFAULT;
ALTER TABLE public.barcode ALTER COLUMN barcode_id DROP DEFAULT;
DROP SEQUENCE public.tissue_tissue_id_seq;
DROP TABLE public.tissue;
DROP SEQUENCE public.sequencingrun_sequencingrun_id_seq;
DROP TABLE public.sequencingrun;
DROP SEQUENCE public.sequencing_sample_sequencing_sample_id_seq;
DROP TABLE public.sequencing_sample;
DROP SEQUENCE public.sequencing_run_sequencing_run_id_seq;
DROP TABLE public.sequencing_run;
DROP SEQUENCE public.pub_pub_id_seq;
DROP SEQUENCE public.pub_dbxref_pub_dbxref_id_seq;
DROP TABLE public.pub_dbxref;
DROP TABLE public.pub;
DROP SEQUENCE public.protocol_protocol_id_seq;
DROP TABLE public.protocol;
DROP SEQUENCE public.process_conf_process_conf_id_seq;
DROP SEQUENCE public.process_conf_input_process_conf_input_id_seq;
DROP TABLE public.process_conf_input;
DROP TABLE public.process_conf;
DROP SEQUENCE public.pipeproject_pipeproject_id_seq;
DROP TABLE public.pipeproject;
DROP SEQUENCE public.pipeprocess_pub_pipeprocess_pub_id_seq;
DROP TABLE public.pipeprocess_pub;
DROP SEQUENCE public.pipeprocess_pipeprocess_id_seq;
DROP SEQUENCE public.pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq;
DROP TABLE public.pipeprocess_in_pipedata;
DROP TABLE public.pipeprocess;
DROP SEQUENCE public.pipedata_property_pipedata_property_id_seq;
DROP TABLE public.pipedata_property;
DROP SEQUENCE public.pipedata_pipedata_id_seq;
DROP TABLE public.pipedata;
DROP SEQUENCE public.person_person_id_seq;
DROP TABLE public.person;
DROP SEQUENCE public.organism_organism_id_seq;
DROP SEQUENCE public.organism_dbxref_organism_dbxref_id_seq;
DROP TABLE public.organism_dbxref;
DROP TABLE public.organism;
DROP SEQUENCE public.organisation_organisation_id_seq;
DROP TABLE public.organisation;
DROP SEQUENCE public.library_library_id_seq;
DROP TABLE public.library;
DROP SEQUENCE public.ecotype_ecotype_id_seq;
DROP TABLE public.ecotype;
DROP SEQUENCE public.dbxref_dbxref_id_seq;
DROP TABLE public.dbxref;
DROP SEQUENCE public.db_db_id_seq;
DROP TABLE public.db;
DROP SEQUENCE public.cvterm_dbxref_cvterm_dbxref_id_seq;
DROP TABLE public.cvterm_dbxref;
DROP SEQUENCE public.cvterm_cvterm_id_seq;
DROP TABLE public.cvterm;
DROP SEQUENCE public.cv_cv_id_seq;
DROP TABLE public.cv;
DROP SEQUENCE public.biosample_pipeproject_biosample_pipeproject_id_seq;
DROP TABLE public.biosample_pipeproject;
DROP SEQUENCE public.biosample_pipedata_biosample_pipedata_id_seq;
DROP TABLE public.biosample_pipedata;
DROP SEQUENCE public.biosample_ecotype_biosample_ecotype_id_seq;
DROP TABLE public.biosample_ecotype;
DROP TABLE public.biosample_dbxref;
DROP SEQUENCE public.biosample_biosample_id_seq;
DROP TABLE public.biosample;
DROP SEQUENCE public.barcode_set_barcode_set_id_seq;
DROP TABLE public.barcode_set;
DROP SEQUENCE public.barcode_barcode_id_seq;
DROP TABLE public.barcode;
DROP FUNCTION public.bioseg_sel(internal, oid, internal, integer);
DROP FUNCTION public.bioseg_joinsel(internal, oid, internal, smallint);
DROP FUNCTION public.bioseg_gist_picksplit(internal, internal);
DROP FUNCTION public.bioseg_gist_penalty(internal, internal, internal);
DROP FUNCTION public.bioseg_gist_decompress(internal);
DROP FUNCTION public.bioseg_gist_compress(internal);
DROP FUNCTION public.bioseg_contsel(internal, oid, internal, integer);
DROP FUNCTION public.bioseg_contjoinsel(internal, oid, internal, smallint);
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET search_path = public, pg_catalog;

--
-- Name: bioseg_contjoinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_contjoinsel(internal, oid, internal, smallint) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_contjoinsel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_contjoinsel(internal, oid, internal, smallint) OWNER TO postgres;

--
-- Name: bioseg_contsel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_contsel(internal, oid, internal, integer) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_contsel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_contsel(internal, oid, internal, integer) OWNER TO postgres;

--
-- Name: bioseg_gist_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_compress(internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_compress(internal) OWNER TO postgres;

--
-- Name: bioseg_gist_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_decompress(internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_decompress(internal) OWNER TO postgres;

--
-- Name: bioseg_gist_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_gist_penalty(internal, internal, internal) OWNER TO postgres;

--
-- Name: bioseg_gist_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_picksplit(internal, internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_picksplit(internal, internal) OWNER TO postgres;

--
-- Name: bioseg_joinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_joinsel(internal, oid, internal, smallint) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_joinsel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_joinsel(internal, oid, internal, smallint) OWNER TO postgres;

--
-- Name: bioseg_sel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_sel(internal, oid, internal, integer) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_sel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_sel(internal, oid, internal, integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: barcode; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE barcode (
    barcode_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    identifier text NOT NULL,
    barcode_set integer NOT NULL,
    code text NOT NULL
);


ALTER TABLE public.barcode OWNER TO kmr44;

--
-- Name: barcode_barcode_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE barcode_barcode_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.barcode_barcode_id_seq OWNER TO kmr44;

--
-- Name: barcode_barcode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE barcode_barcode_id_seq OWNED BY barcode.barcode_id;


--
-- Name: barcode_barcode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('barcode_barcode_id_seq', 90, true);


--
-- Name: barcode_set; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE barcode_set (
    barcode_set_id integer NOT NULL,
    position_in_read integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.barcode_set OWNER TO kmr44;

--
-- Name: barcode_set_barcode_set_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE barcode_set_barcode_set_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.barcode_set_barcode_set_id_seq OWNER TO kmr44;

--
-- Name: barcode_set_barcode_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE barcode_set_barcode_set_id_seq OWNED BY barcode_set.barcode_set_id;


--
-- Name: barcode_set_barcode_set_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('barcode_set_barcode_set_id_seq', 3, true);


--
-- Name: biosample; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE biosample (
    biosample_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    genotype text,
    description text NOT NULL,
    protocol integer NOT NULL,
    biosample_type integer NOT NULL,
    molecule_type integer NOT NULL,
    treatment_type integer,
    fractionation_type integer,
    processing_requirement integer NOT NULL,
    tissue integer
);


ALTER TABLE public.biosample OWNER TO kmr44;

--
-- Name: biosample_biosample_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE biosample_biosample_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.biosample_biosample_id_seq OWNER TO kmr44;

--
-- Name: biosample_biosample_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE biosample_biosample_id_seq OWNED BY biosample.biosample_id;


--
-- Name: biosample_biosample_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('biosample_biosample_id_seq', 4, true);


--
-- Name: biosample_dbxref; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE biosample_dbxref (
    biosample_dbxref_id integer NOT NULL,
    biosample_id integer NOT NULL,
    dbxref_id integer NOT NULL
);


ALTER TABLE public.biosample_dbxref OWNER TO kmr44;

--
-- Name: biosample_ecotype; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE biosample_ecotype (
    biosample_ecotype_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    biosample integer NOT NULL,
    ecotype integer NOT NULL
);


ALTER TABLE public.biosample_ecotype OWNER TO kmr44;

--
-- Name: biosample_ecotype_biosample_ecotype_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE biosample_ecotype_biosample_ecotype_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.biosample_ecotype_biosample_ecotype_id_seq OWNER TO kmr44;

--
-- Name: biosample_ecotype_biosample_ecotype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE biosample_ecotype_biosample_ecotype_id_seq OWNED BY biosample_ecotype.biosample_ecotype_id;


--
-- Name: biosample_ecotype_biosample_ecotype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('biosample_ecotype_biosample_ecotype_id_seq', 4, true);


--
-- Name: biosample_pipedata; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE biosample_pipedata (
    biosample_pipedata_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    biosample integer NOT NULL,
    pipedata integer NOT NULL
);


ALTER TABLE public.biosample_pipedata OWNER TO kmr44;

--
-- Name: biosample_pipedata_biosample_pipedata_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE biosample_pipedata_biosample_pipedata_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.biosample_pipedata_biosample_pipedata_id_seq OWNER TO kmr44;

--
-- Name: biosample_pipedata_biosample_pipedata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE biosample_pipedata_biosample_pipedata_id_seq OWNED BY biosample_pipedata.biosample_pipedata_id;


--
-- Name: biosample_pipedata_biosample_pipedata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('biosample_pipedata_biosample_pipedata_id_seq', 4, true);


--
-- Name: biosample_pipeproject; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE biosample_pipeproject (
    biosample_pipeproject_id integer NOT NULL,
    biosample integer NOT NULL,
    pipeproject integer NOT NULL
);


ALTER TABLE public.biosample_pipeproject OWNER TO kmr44;

--
-- Name: biosample_pipeproject_biosample_pipeproject_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE biosample_pipeproject_biosample_pipeproject_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.biosample_pipeproject_biosample_pipeproject_id_seq OWNER TO kmr44;

--
-- Name: biosample_pipeproject_biosample_pipeproject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE biosample_pipeproject_biosample_pipeproject_id_seq OWNED BY biosample_pipeproject.biosample_pipeproject_id;


--
-- Name: biosample_pipeproject_biosample_pipeproject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('biosample_pipeproject_biosample_pipeproject_id_seq', 4, true);


--
-- Name: cv; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE cv (
    cv_id integer NOT NULL,
    name character varying(255) NOT NULL,
    definition text
);


ALTER TABLE public.cv OWNER TO kmr44;

--
-- Name: TABLE cv; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE cv IS 'A controlled vocabulary or ontology. A cv is
composed of cvterms (AKA terms, classes, types, universals - relations
and properties are also stored in cvterm) and the relationships
between them.';


--
-- Name: COLUMN cv.name; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN cv.name IS 'The name of the ontology. This
corresponds to the obo-format -namespace-. cv names uniquely identify
the cv. In OBO file format, the cv.name is known as the namespace.';


--
-- Name: COLUMN cv.definition; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN cv.definition IS 'A text description of the criteria for
membership of this ontology.';


--
-- Name: cv_cv_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE cv_cv_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cv_cv_id_seq OWNER TO kmr44;

--
-- Name: cv_cv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE cv_cv_id_seq OWNED BY cv.cv_id;


--
-- Name: cv_cv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('cv_cv_id_seq', 17, true);


--
-- Name: cvterm; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE cvterm (
    cvterm_id integer NOT NULL,
    cv_id integer NOT NULL,
    name character varying(1024) NOT NULL,
    definition text,
    dbxref_id integer NOT NULL,
    is_obsolete integer DEFAULT 0 NOT NULL,
    is_relationshiptype integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.cvterm OWNER TO kmr44;

--
-- Name: TABLE cvterm; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE cvterm IS 'A term, class, universal or type within an
ontology or controlled vocabulary.  This table is also used for
relations and properties. cvterms constitute nodes in the graph
defined by the collection of cvterms and cvterm_relationships.';


--
-- Name: COLUMN cvterm.cv_id; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN cvterm.cv_id IS 'The cv or ontology or namespace to which
this cvterm belongs.';


--
-- Name: COLUMN cvterm.name; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN cvterm.name IS 'A concise human-readable name or
label for the cvterm. Uniquely identifies a cvterm within a cv.';


--
-- Name: COLUMN cvterm.definition; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN cvterm.definition IS 'A human-readable text
definition.';


--
-- Name: COLUMN cvterm.dbxref_id; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN cvterm.dbxref_id IS 'Primary identifier dbxref - The
unique global OBO identifier for this cvterm.  Note that a cvterm may
have multiple secondary dbxrefs - see also table: cvterm_dbxref.';


--
-- Name: COLUMN cvterm.is_obsolete; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN cvterm.is_obsolete IS 'Boolean 0=false,1=true; see
GO documentation for details of obsoletion. Note that two terms with
different primary dbxrefs may exist if one is obsolete.';


--
-- Name: COLUMN cvterm.is_relationshiptype; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN cvterm.is_relationshiptype IS 'Boolean
0=false,1=true relations or relationship types (also known as Typedefs
in OBO format, or as properties or slots) form a cv/ontology in
themselves. We use this flag to indicate whether this cvterm is an
actual term/class/universal or a relation. Relations may be drawn from
the OBO Relations ontology, but are not exclusively drawn from there.';


--
-- Name: cvterm_cvterm_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE cvterm_cvterm_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cvterm_cvterm_id_seq OWNER TO kmr44;

--
-- Name: cvterm_cvterm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE cvterm_cvterm_id_seq OWNED BY cvterm.cvterm_id;


--
-- Name: cvterm_cvterm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('cvterm_cvterm_id_seq', 94, true);


--
-- Name: cvterm_dbxref; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE cvterm_dbxref (
    cvterm_dbxref_id integer NOT NULL,
    cvterm_id integer NOT NULL,
    dbxref_id integer NOT NULL,
    is_for_definition integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.cvterm_dbxref OWNER TO kmr44;

--
-- Name: TABLE cvterm_dbxref; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE cvterm_dbxref IS 'In addition to the primary
identifier (cvterm.dbxref_id) a cvterm can have zero or more secondary
identifiers/dbxrefs, which may refer to records in external
databases. The exact semantics of cvterm_dbxref are not fixed. For
example: the dbxref could be a pubmed ID that is pertinent to the
cvterm, or it could be an equivalent or similar term in another
ontology. For example, GO cvterms are typically linked to InterPro
IDs, even though the nature of the relationship between them is
largely one of statistical association. The dbxref may be have data
records attached in the same database instance, or it could be a
"hanging" dbxref pointing to some external database. NOTE: If the
desired objective is to link two cvterms together, and the nature of
the relation is known and holds for all instances of the subject
cvterm then consider instead using cvterm_relationship together with a
well-defined relation.';


--
-- Name: COLUMN cvterm_dbxref.is_for_definition; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN cvterm_dbxref.is_for_definition IS 'A
cvterm.definition should be supported by one or more references. If
this column is true, the dbxref is not for a term in an external database -
it is a dbxref for provenance information for the definition.';


--
-- Name: cvterm_dbxref_cvterm_dbxref_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE cvterm_dbxref_cvterm_dbxref_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cvterm_dbxref_cvterm_dbxref_id_seq OWNER TO kmr44;

--
-- Name: cvterm_dbxref_cvterm_dbxref_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE cvterm_dbxref_cvterm_dbxref_id_seq OWNED BY cvterm_dbxref.cvterm_dbxref_id;


--
-- Name: cvterm_dbxref_cvterm_dbxref_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('cvterm_dbxref_cvterm_dbxref_id_seq', 1, false);


--
-- Name: db; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE db (
    db_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    urlprefix character varying(255),
    url character varying(255)
);


ALTER TABLE public.db OWNER TO kmr44;

--
-- Name: TABLE db; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE db IS 'A database authority. Typical databases in
bioinformatics are FlyBase, GO, UniProt, NCBI, MGI, etc. The authority
is generally known by this shortened form, which is unique within the
bioinformatics and biomedical realm.  To Do - add support for URIs,
URNs (e.g. LSIDs). We can do this by treating the URL as a URI -
however, some applications may expect this to be resolvable - to be
decided.';


--
-- Name: db_db_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE db_db_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.db_db_id_seq OWNER TO kmr44;

--
-- Name: db_db_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE db_db_id_seq OWNED BY db.db_id;


--
-- Name: db_db_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('db_db_id_seq', 1, true);


--
-- Name: dbxref; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE dbxref (
    dbxref_id integer NOT NULL,
    db_id integer NOT NULL,
    accession character varying(255) NOT NULL,
    version character varying(255) DEFAULT ''::character varying NOT NULL,
    description text
);


ALTER TABLE public.dbxref OWNER TO kmr44;

--
-- Name: TABLE dbxref; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE dbxref IS 'A unique, global, public, stable identifier. Not necessarily an external reference - can reference data items inside the particular chado instance being used. Typically a row in a table can be uniquely identified with a primary identifier (called dbxref_id); a table may also have secondary identifiers (in a linking table <T>_dbxref). A dbxref is generally written as <DB>:<ACCESSION> or as <DB>:<ACCESSION>:<VERSION>.';


--
-- Name: COLUMN dbxref.accession; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN dbxref.accession IS 'The local part of the identifier. Guaranteed by the db authority to be unique for that db.';


--
-- Name: dbxref_dbxref_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE dbxref_dbxref_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.dbxref_dbxref_id_seq OWNER TO kmr44;

--
-- Name: dbxref_dbxref_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE dbxref_dbxref_id_seq OWNED BY dbxref.dbxref_id;


--
-- Name: dbxref_dbxref_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('dbxref_dbxref_id_seq', 94, true);


--
-- Name: ecotype; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE ecotype (
    ecotype_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    organism integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.ecotype OWNER TO kmr44;

--
-- Name: ecotype_ecotype_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE ecotype_ecotype_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.ecotype_ecotype_id_seq OWNER TO kmr44;

--
-- Name: ecotype_ecotype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE ecotype_ecotype_id_seq OWNED BY ecotype.ecotype_id;


--
-- Name: ecotype_ecotype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('ecotype_ecotype_id_seq', 27, true);


--
-- Name: library; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE library (
    library_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    description text,
    library_type integer NOT NULL,
    biosample integer NOT NULL,
    sequencing_sample integer,
    adaptor integer NOT NULL,
    barcode integer
);


ALTER TABLE public.library OWNER TO kmr44;

--
-- Name: library_library_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE library_library_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.library_library_id_seq OWNER TO kmr44;

--
-- Name: library_library_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE library_library_id_seq OWNED BY library.library_id;


--
-- Name: library_library_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('library_library_id_seq', 4, true);


--
-- Name: organisation; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE organisation (
    organisation_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE public.organisation OWNER TO kmr44;

--
-- Name: organisation_organisation_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE organisation_organisation_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organisation_organisation_id_seq OWNER TO kmr44;

--
-- Name: organisation_organisation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE organisation_organisation_id_seq OWNED BY organisation.organisation_id;


--
-- Name: organisation_organisation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('organisation_organisation_id_seq', 7, true);


--
-- Name: organism; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE organism (
    organism_id integer NOT NULL,
    abbreviation character varying(255),
    genus character varying(255) NOT NULL,
    species character varying(255) NOT NULL,
    common_name character varying(255),
    comment text
);


ALTER TABLE public.organism OWNER TO kmr44;

--
-- Name: TABLE organism; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE organism IS 'The organismal taxonomic
classification. Note that phylogenies are represented using the
phylogeny module, and taxonomies can be represented using the cvterm
module or the phylogeny module.';


--
-- Name: COLUMN organism.species; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN organism.species IS 'A type of organism is always
uniquely identified by genus and species. When mapping from the NCBI
taxonomy names.dmp file, this column must be used where it
is present, as the common_name column is not always unique (e.g. environmental
samples). If a particular strain or subspecies is to be represented,
this is appended onto the species name. Follows standard NCBI taxonomy
pattern.';


--
-- Name: organism_dbxref; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE organism_dbxref (
    organism_dbxref_id integer NOT NULL,
    organism_id integer NOT NULL,
    dbxref_id integer NOT NULL
);


ALTER TABLE public.organism_dbxref OWNER TO kmr44;

--
-- Name: organism_dbxref_organism_dbxref_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE organism_dbxref_organism_dbxref_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organism_dbxref_organism_dbxref_id_seq OWNER TO kmr44;

--
-- Name: organism_dbxref_organism_dbxref_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE organism_dbxref_organism_dbxref_id_seq OWNED BY organism_dbxref.organism_dbxref_id;


--
-- Name: organism_dbxref_organism_dbxref_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('organism_dbxref_organism_dbxref_id_seq', 1, false);


--
-- Name: organism_organism_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE organism_organism_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organism_organism_id_seq OWNER TO kmr44;

--
-- Name: organism_organism_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE organism_organism_id_seq OWNED BY organism.organism_id;


--
-- Name: organism_organism_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('organism_organism_id_seq', 18, true);


--
-- Name: person; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE person (
    person_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    username text NOT NULL,
    password text,
    role integer NOT NULL,
    organisation integer NOT NULL
);


ALTER TABLE public.person OWNER TO kmr44;

--
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE person_person_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.person_person_id_seq OWNER TO kmr44;

--
-- Name: person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE person_person_id_seq OWNED BY person.person_id;


--
-- Name: person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('person_person_id_seq', 23, true);


--
-- Name: pipedata; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipedata (
    pipedata_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    format_type integer NOT NULL,
    content_type integer NOT NULL,
    file_name text NOT NULL,
    file_length bigint NOT NULL,
    generating_pipeprocess integer
);


ALTER TABLE public.pipedata OWNER TO kmr44;

--
-- Name: pipedata_pipedata_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pipedata_pipedata_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pipedata_pipedata_id_seq OWNER TO kmr44;

--
-- Name: pipedata_pipedata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pipedata_pipedata_id_seq OWNED BY pipedata.pipedata_id;


--
-- Name: pipedata_pipedata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pipedata_pipedata_id_seq', 2, true);


--
-- Name: pipedata_property; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipedata_property (
    pipedata_property_id integer NOT NULL,
    pipedata integer NOT NULL,
    type integer NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.pipedata_property OWNER TO kmr44;

--
-- Name: pipedata_property_pipedata_property_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pipedata_property_pipedata_property_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pipedata_property_pipedata_property_id_seq OWNER TO kmr44;

--
-- Name: pipedata_property_pipedata_property_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pipedata_property_pipedata_property_id_seq OWNED BY pipedata_property.pipedata_property_id;


--
-- Name: pipedata_property_pipedata_property_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pipedata_property_pipedata_property_id_seq', 1, false);


--
-- Name: pipeprocess; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipeprocess (
    pipeprocess_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    description text NOT NULL,
    process_conf integer NOT NULL,
    status integer NOT NULL,
    job_identifier text,
    time_queued timestamp without time zone,
    time_started timestamp without time zone,
    time_finished timestamp without time zone
);


ALTER TABLE public.pipeprocess OWNER TO kmr44;

--
-- Name: pipeprocess_in_pipedata; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipeprocess_in_pipedata (
    pipeprocess_in_pipedata_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    pipeprocess integer,
    pipedata integer
);


ALTER TABLE public.pipeprocess_in_pipedata OWNER TO kmr44;

--
-- Name: TABLE pipeprocess_in_pipedata; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE pipeprocess_in_pipedata IS 'Join table containing the input pipedatas for a pipeprocess';


--
-- Name: pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq OWNER TO kmr44;

--
-- Name: pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq OWNED BY pipeprocess_in_pipedata.pipeprocess_in_pipedata_id;


--
-- Name: pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq', 1, false);


--
-- Name: pipeprocess_pipeprocess_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pipeprocess_pipeprocess_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pipeprocess_pipeprocess_id_seq OWNER TO kmr44;

--
-- Name: pipeprocess_pipeprocess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pipeprocess_pipeprocess_id_seq OWNED BY pipeprocess.pipeprocess_id;


--
-- Name: pipeprocess_pipeprocess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pipeprocess_pipeprocess_id_seq', 2, true);


--
-- Name: pipeprocess_pub; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipeprocess_pub (
    pipeprocess_pub_id integer NOT NULL,
    pipeprocess_id integer NOT NULL,
    pub_id integer NOT NULL
);


ALTER TABLE public.pipeprocess_pub OWNER TO kmr44;

--
-- Name: pipeprocess_pub_pipeprocess_pub_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pipeprocess_pub_pipeprocess_pub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pipeprocess_pub_pipeprocess_pub_id_seq OWNER TO kmr44;

--
-- Name: pipeprocess_pub_pipeprocess_pub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pipeprocess_pub_pipeprocess_pub_id_seq OWNED BY pipeprocess_pub.pipeprocess_pub_id;


--
-- Name: pipeprocess_pub_pipeprocess_pub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pipeprocess_pub_pipeprocess_pub_id_seq', 1, false);


--
-- Name: pipeproject; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipeproject (
    pipeproject_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    owner integer NOT NULL,
    funder integer
);


ALTER TABLE public.pipeproject OWNER TO kmr44;

--
-- Name: pipeproject_pipeproject_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pipeproject_pipeproject_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pipeproject_pipeproject_id_seq OWNER TO kmr44;

--
-- Name: pipeproject_pipeproject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pipeproject_pipeproject_id_seq OWNED BY pipeproject.pipeproject_id;


--
-- Name: pipeproject_pipeproject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pipeproject_pipeproject_id_seq', 2, true);


--
-- Name: process_conf; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE process_conf (
    process_conf_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    runable_name text,
    detail text,
    type integer NOT NULL
);


ALTER TABLE public.process_conf OWNER TO kmr44;

--
-- Name: process_conf_input; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE process_conf_input (
    process_conf_input_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    process_conf integer NOT NULL,
    format_type integer,
    content_type integer,
    ecotype integer,
    biosample_type integer
);


ALTER TABLE public.process_conf_input OWNER TO kmr44;

--
-- Name: process_conf_input_process_conf_input_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE process_conf_input_process_conf_input_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.process_conf_input_process_conf_input_id_seq OWNER TO kmr44;

--
-- Name: process_conf_input_process_conf_input_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE process_conf_input_process_conf_input_id_seq OWNED BY process_conf_input.process_conf_input_id;


--
-- Name: process_conf_input_process_conf_input_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('process_conf_input_process_conf_input_id_seq', 48, true);


--
-- Name: process_conf_process_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE process_conf_process_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.process_conf_process_conf_id_seq OWNER TO kmr44;

--
-- Name: process_conf_process_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE process_conf_process_conf_id_seq OWNED BY process_conf.process_conf_id;


--
-- Name: process_conf_process_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('process_conf_process_conf_id_seq', 1, false);


--
-- Name: protocol; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE protocol (
    protocol_id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.protocol OWNER TO kmr44;

--
-- Name: protocol_protocol_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE protocol_protocol_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.protocol_protocol_id_seq OWNER TO kmr44;

--
-- Name: protocol_protocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE protocol_protocol_id_seq OWNED BY protocol.protocol_id;


--
-- Name: protocol_protocol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('protocol_protocol_id_seq', 1, true);


--
-- Name: pub; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pub (
    pub_id integer NOT NULL,
    title text,
    volumetitle text,
    volume character varying(255),
    series_name character varying(255),
    issue character varying(255),
    pyear character varying(255),
    pages character varying(255),
    miniref character varying(255),
    uniquename text NOT NULL,
    type_id integer NOT NULL,
    is_obsolete boolean DEFAULT false,
    publisher character varying(255),
    pubplace character varying(255)
);


ALTER TABLE public.pub OWNER TO kmr44;

--
-- Name: TABLE pub; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE pub IS 'A documented provenance artefact - publications,
documents, personal communication.';


--
-- Name: COLUMN pub.title; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN pub.title IS 'Descriptive general heading.';


--
-- Name: COLUMN pub.volumetitle; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN pub.volumetitle IS 'Title of part if one of a series.';


--
-- Name: COLUMN pub.series_name; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN pub.series_name IS 'Full name of (journal) series.';


--
-- Name: COLUMN pub.pages; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN pub.pages IS 'Page number range[s], e.g. 457--459, viii + 664pp, lv--lvii.';


--
-- Name: COLUMN pub.type_id; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON COLUMN pub.type_id IS 'The type of the publication (book, journal, poem, graffiti, etc). Uses pub cv.';


--
-- Name: pub_dbxref; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pub_dbxref (
    pub_dbxref_id integer NOT NULL,
    pub_id integer NOT NULL,
    dbxref_id integer NOT NULL,
    is_current boolean DEFAULT true NOT NULL
);


ALTER TABLE public.pub_dbxref OWNER TO kmr44;

--
-- Name: TABLE pub_dbxref; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE pub_dbxref IS 'Handle links to repositories,
e.g. Pubmed, Biosis, zoorec, OCLC, Medline, ISSN, coden...';


--
-- Name: pub_dbxref_pub_dbxref_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pub_dbxref_pub_dbxref_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pub_dbxref_pub_dbxref_id_seq OWNER TO kmr44;

--
-- Name: pub_dbxref_pub_dbxref_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pub_dbxref_pub_dbxref_id_seq OWNED BY pub_dbxref.pub_dbxref_id;


--
-- Name: pub_dbxref_pub_dbxref_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pub_dbxref_pub_dbxref_id_seq', 1, false);


--
-- Name: pub_pub_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pub_pub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pub_pub_id_seq OWNER TO kmr44;

--
-- Name: pub_pub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pub_pub_id_seq OWNED BY pub.pub_id;


--
-- Name: pub_pub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pub_pub_id_seq', 1, false);


--
-- Name: sequencing_run; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sequencing_run (
    sequencing_run_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    identifier text NOT NULL,
    sequencing_sample integer NOT NULL,
    initial_pipedata integer,
    sequencing_centre integer NOT NULL,
    initial_pipeprocess integer,
    submission_date date,
    run_date date,
    data_received_date date,
    quality integer NOT NULL,
    sequencing_type integer NOT NULL,
    CONSTRAINT sequencing_run_check CHECK (CASE WHEN (run_date IS NULL) THEN (data_received_date IS NULL) ELSE true END)
);


ALTER TABLE public.sequencing_run OWNER TO kmr44;

--
-- Name: sequencing_run_sequencing_run_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sequencing_run_sequencing_run_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sequencing_run_sequencing_run_id_seq OWNER TO kmr44;

--
-- Name: sequencing_run_sequencing_run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sequencing_run_sequencing_run_id_seq OWNED BY sequencing_run.sequencing_run_id;


--
-- Name: sequencing_run_sequencing_run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sequencing_run_sequencing_run_id_seq', 2, true);


--
-- Name: sequencing_sample; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sequencing_sample (
    sequencing_sample_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.sequencing_sample OWNER TO kmr44;

--
-- Name: sequencing_sample_sequencing_sample_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sequencing_sample_sequencing_sample_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sequencing_sample_sequencing_sample_id_seq OWNER TO kmr44;

--
-- Name: sequencing_sample_sequencing_sample_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sequencing_sample_sequencing_sample_id_seq OWNED BY sequencing_sample.sequencing_sample_id;


--
-- Name: sequencing_sample_sequencing_sample_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sequencing_sample_sequencing_sample_id_seq', 2, true);


--
-- Name: sequencingrun; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sequencingrun (
    sequencingrun_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    identifier text NOT NULL,
    sequencing_sample integer NOT NULL,
    initial_pipedata integer,
    sequencing_centre integer NOT NULL,
    initial_pipeprocess integer,
    submission_date date,
    run_date date,
    data_received_date date,
    quality integer NOT NULL,
    sequencing_type integer NOT NULL,
    CONSTRAINT sequencingrun_check CHECK (CASE WHEN (run_date IS NULL) THEN (data_received_date IS NULL) ELSE true END)
);


ALTER TABLE public.sequencingrun OWNER TO kmr44;

--
-- Name: sequencingrun_sequencingrun_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sequencingrun_sequencingrun_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sequencingrun_sequencingrun_id_seq OWNER TO kmr44;

--
-- Name: sequencingrun_sequencingrun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sequencingrun_sequencingrun_id_seq OWNED BY sequencingrun.sequencingrun_id;


--
-- Name: sequencingrun_sequencingrun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sequencingrun_sequencingrun_id_seq', 8, true);


--
-- Name: tissue; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE tissue (
    tissue_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    organism integer NOT NULL,
    description text
);


ALTER TABLE public.tissue OWNER TO kmr44;

--
-- Name: tissue_tissue_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE tissue_tissue_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tissue_tissue_id_seq OWNER TO kmr44;

--
-- Name: tissue_tissue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE tissue_tissue_id_seq OWNED BY tissue.tissue_id;


--
-- Name: tissue_tissue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('tissue_tissue_id_seq', 28, true);


--
-- Name: barcode_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE barcode ALTER COLUMN barcode_id SET DEFAULT nextval('barcode_barcode_id_seq'::regclass);


--
-- Name: barcode_set_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE barcode_set ALTER COLUMN barcode_set_id SET DEFAULT nextval('barcode_set_barcode_set_id_seq'::regclass);


--
-- Name: biosample_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE biosample ALTER COLUMN biosample_id SET DEFAULT nextval('biosample_biosample_id_seq'::regclass);


--
-- Name: biosample_ecotype_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE biosample_ecotype ALTER COLUMN biosample_ecotype_id SET DEFAULT nextval('biosample_ecotype_biosample_ecotype_id_seq'::regclass);


--
-- Name: biosample_pipedata_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE biosample_pipedata ALTER COLUMN biosample_pipedata_id SET DEFAULT nextval('biosample_pipedata_biosample_pipedata_id_seq'::regclass);


--
-- Name: biosample_pipeproject_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE biosample_pipeproject ALTER COLUMN biosample_pipeproject_id SET DEFAULT nextval('biosample_pipeproject_biosample_pipeproject_id_seq'::regclass);


--
-- Name: cv_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE cv ALTER COLUMN cv_id SET DEFAULT nextval('cv_cv_id_seq'::regclass);


--
-- Name: cvterm_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE cvterm ALTER COLUMN cvterm_id SET DEFAULT nextval('cvterm_cvterm_id_seq'::regclass);


--
-- Name: cvterm_dbxref_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE cvterm_dbxref ALTER COLUMN cvterm_dbxref_id SET DEFAULT nextval('cvterm_dbxref_cvterm_dbxref_id_seq'::regclass);


--
-- Name: db_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE db ALTER COLUMN db_id SET DEFAULT nextval('db_db_id_seq'::regclass);


--
-- Name: dbxref_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE dbxref ALTER COLUMN dbxref_id SET DEFAULT nextval('dbxref_dbxref_id_seq'::regclass);


--
-- Name: ecotype_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE ecotype ALTER COLUMN ecotype_id SET DEFAULT nextval('ecotype_ecotype_id_seq'::regclass);


--
-- Name: library_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE library ALTER COLUMN library_id SET DEFAULT nextval('library_library_id_seq'::regclass);


--
-- Name: organisation_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE organisation ALTER COLUMN organisation_id SET DEFAULT nextval('organisation_organisation_id_seq'::regclass);


--
-- Name: organism_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE organism ALTER COLUMN organism_id SET DEFAULT nextval('organism_organism_id_seq'::regclass);


--
-- Name: organism_dbxref_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE organism_dbxref ALTER COLUMN organism_dbxref_id SET DEFAULT nextval('organism_dbxref_organism_dbxref_id_seq'::regclass);


--
-- Name: person_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE person ALTER COLUMN person_id SET DEFAULT nextval('person_person_id_seq'::regclass);


--
-- Name: pipedata_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pipedata ALTER COLUMN pipedata_id SET DEFAULT nextval('pipedata_pipedata_id_seq'::regclass);


--
-- Name: pipedata_property_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pipedata_property ALTER COLUMN pipedata_property_id SET DEFAULT nextval('pipedata_property_pipedata_property_id_seq'::regclass);


--
-- Name: pipeprocess_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pipeprocess ALTER COLUMN pipeprocess_id SET DEFAULT nextval('pipeprocess_pipeprocess_id_seq'::regclass);


--
-- Name: pipeprocess_in_pipedata_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pipeprocess_in_pipedata ALTER COLUMN pipeprocess_in_pipedata_id SET DEFAULT nextval('pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq'::regclass);


--
-- Name: pipeprocess_pub_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pipeprocess_pub ALTER COLUMN pipeprocess_pub_id SET DEFAULT nextval('pipeprocess_pub_pipeprocess_pub_id_seq'::regclass);


--
-- Name: pipeproject_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pipeproject ALTER COLUMN pipeproject_id SET DEFAULT nextval('pipeproject_pipeproject_id_seq'::regclass);


--
-- Name: process_conf_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE process_conf ALTER COLUMN process_conf_id SET DEFAULT nextval('process_conf_process_conf_id_seq'::regclass);


--
-- Name: process_conf_input_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE process_conf_input ALTER COLUMN process_conf_input_id SET DEFAULT nextval('process_conf_input_process_conf_input_id_seq'::regclass);


--
-- Name: protocol_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE protocol ALTER COLUMN protocol_id SET DEFAULT nextval('protocol_protocol_id_seq'::regclass);


--
-- Name: pub_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pub ALTER COLUMN pub_id SET DEFAULT nextval('pub_pub_id_seq'::regclass);


--
-- Name: pub_dbxref_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pub_dbxref ALTER COLUMN pub_dbxref_id SET DEFAULT nextval('pub_dbxref_pub_dbxref_id_seq'::regclass);


--
-- Name: sequencing_run_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sequencing_run ALTER COLUMN sequencing_run_id SET DEFAULT nextval('sequencing_run_sequencing_run_id_seq'::regclass);


--
-- Name: sequencing_sample_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sequencing_sample ALTER COLUMN sequencing_sample_id SET DEFAULT nextval('sequencing_sample_sequencing_sample_id_seq'::regclass);


--
-- Name: sequencingrun_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sequencingrun ALTER COLUMN sequencingrun_id SET DEFAULT nextval('sequencingrun_sequencingrun_id_seq'::regclass);


--
-- Name: tissue_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE tissue ALTER COLUMN tissue_id SET DEFAULT nextval('tissue_tissue_id_seq'::regclass);


--
-- Data for Name: barcode; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY barcode (barcode_id, created_stamp, identifier, barcode_set, code) FROM stdin;
1	2010-01-18 12:22:53.127764	A	1	TACCT
2	2010-01-18 12:22:53.127764	B	1	TACGA
3	2010-01-18 12:22:53.127764	C	1	TAGCA
4	2010-01-18 12:22:53.127764	D	1	TAGGT
5	2010-01-18 12:22:53.127764	E	1	TCAAG
6	2010-01-18 12:22:53.127764	F	1	TCATC
7	2010-01-18 12:22:53.127764	G	1	TCTAC
8	2010-01-18 12:22:53.127764	H	1	TCTTG
9	2010-01-18 12:22:53.127764	I	1	TGAAC
10	2010-01-18 12:22:53.127764	J	1	TGTTG
11	2010-01-18 12:22:53.127764	K	1	TGTTC
12	2010-01-18 12:22:53.127764	A	2	AAAT
13	2010-01-18 12:22:53.127764	B	2	ATCT
14	2010-01-18 12:22:53.127764	C	2	AGGT
15	2010-01-18 12:22:53.127764	D	2	ACTT
16	2010-01-18 12:22:53.127764	E	2	TACT
17	2010-01-18 12:22:53.127764	F	2	TTGT
18	2010-01-18 12:22:53.127764	G	2	TGTT
19	2010-01-18 12:22:53.127764	H	2	TCAT
20	2010-01-18 12:22:53.127764	I	2	GAGT
21	2010-01-18 12:22:53.127764	J	2	GTTT
22	2010-01-18 12:22:53.127764	K	2	GGAT
23	2010-01-18 12:22:53.127764	L	2	GCCT
24	2010-01-18 12:22:53.127764	M	2	CATT
25	2010-01-18 12:22:53.127764	N	2	CTAT
26	2010-01-18 12:22:53.127764	O	2	CGCT
27	2010-01-18 12:22:53.127764	P	2	CCGT
28	2010-01-18 12:22:53.127764	A	3	CGTGA
29	2010-01-18 12:22:53.127764	A1	3	ACGCA
30	2010-01-18 12:22:53.127764	A2	3	TGCTC
31	2010-01-18 12:22:53.127764	B	3	GTCGA
32	2010-01-18 12:22:53.127764	B1	3	GCGCG
33	2010-01-18 12:22:53.127764	B2	3	CTCTA
34	2010-01-18 12:22:53.127764	C	3	AGCGC
35	2010-01-18 12:22:53.127764	C1	3	ATGCG
36	2010-01-18 12:22:53.127764	C2	3	GTCTC
37	2010-01-18 12:22:53.127764	D	3	TATGA
38	2010-01-18 12:22:53.127764	D1	3	GTGCA
39	2010-01-18 12:22:53.127764	D2	3	CAGTG
40	2010-01-18 12:22:53.127764	E	3	CACAG
41	2010-01-18 12:22:53.127764	E1	3	GATCG
42	2010-01-18 12:22:53.127764	E2	3	TAGTA
43	2010-01-18 12:22:53.127764	F	3	TGCAG
44	2010-01-18 12:22:53.127764	F1	3	TCTCA
45	2010-01-18 12:22:53.127764	F2	3	ACGTG
46	2010-01-18 12:22:53.127764	G	3	CTCAC
47	2010-01-18 12:22:53.127764	G1	3	AGTCG
48	2010-01-18 12:22:53.127764	G2	3	GCGTA
49	2010-01-18 12:22:53.127764	H	3	GTCAG
50	2010-01-18 12:22:53.127764	H1	3	GCAGC
51	2010-01-18 12:22:53.127764	H2	3	TCGTC
52	2010-01-18 12:22:53.127764	I	3	TAGAC
53	2010-01-18 12:22:53.127764	I1	3	AGAGA
54	2010-01-18 12:22:53.127764	I2	3	ATGTA
55	2010-01-18 12:22:53.127764	J	3	GCGAC
56	2010-01-18 12:22:53.127764	J1	3	CGAGC
57	2010-01-18 12:22:53.127764	J2	3	CTGTC
58	2010-01-18 12:22:53.127764	K	3	TCGAG
59	2010-01-18 12:22:53.127764	K1	3	ATAGC
60	2010-01-18 12:22:53.127764	K2	3	GTGTG
61	2010-01-18 12:22:53.127764	L	3	ATGAC
62	2010-01-18 12:22:53.127764	L1	3	CACGA
63	2010-01-18 12:22:53.127764	M	3	CTGAG
64	2010-01-18 12:22:53.127764	M1	3	GACGC
65	2010-01-18 12:22:53.127764	N	3	GATAC
66	2010-01-18 12:22:53.127764	N1	3	TGCGA
67	2010-01-18 12:22:53.127764	O	3	TATAG
68	2010-01-18 12:22:53.127764	O1	3	GCTGA
69	2010-01-18 12:22:53.127764	P	3	GCTAG
70	2010-01-18 12:22:53.127764	P1	3	TCTGC
71	2010-01-18 12:22:53.127764	Q	3	AGTAC
72	2010-01-18 12:22:53.127764	Q1	3	ACATA
73	2010-01-18 12:22:53.127764	R	3	CGTAG
74	2010-01-18 12:22:53.127764	R1	3	GCATG
75	2010-01-18 12:22:53.127764	S	3	ACACG
76	2010-01-18 12:22:53.127764	S1	3	AGATC
77	2010-01-18 12:22:53.127764	T	3	GCACA
78	2010-01-18 12:22:53.127764	T1	3	CGATG
79	2010-01-18 12:22:53.127764	U	3	CGACA
80	2010-01-18 12:22:53.127764	U1	3	TGATA
81	2010-01-18 12:22:53.127764	V	3	TGACG
82	2010-01-18 12:22:53.127764	V1	3	ATATG
83	2010-01-18 12:22:53.127764	W	3	ATACA
84	2010-01-18 12:22:53.127764	W1	3	GTATA
85	2010-01-18 12:22:53.127764	X	3	GTACG
86	2010-01-18 12:22:53.127764	X1	3	CACTC
87	2010-01-18 12:22:53.127764	Y	3	CAGCA
88	2010-01-18 12:22:53.127764	Y1	3	GACTG
89	2010-01-18 12:22:53.127764	Z	3	TAGCG
90	2010-01-18 12:22:53.127764	Z1	3	AGCTG
\.


--
-- Data for Name: barcode_set; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY barcode_set (barcode_set_id, position_in_read, name) FROM stdin;
1	19	DCB small RNA barcode set
2	20	Dmitry's barcode set
3	20	Natasha's barcode set
\.


--
-- Data for Name: biosample; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY biosample (biosample_id, created_stamp, name, genotype, description, protocol, biosample_type, molecule_type, treatment_type, fractionation_type, processing_requirement, tissue) FROM stdin;
1	2010-01-18 12:22:54.897095	SL234_B	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP  - barcode B	1	27	61	\N	\N	21	\N
2	2010-01-18 12:22:54.897095	SL234_C	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP  - barcode C	1	27	61	\N	\N	21	\N
3	2010-01-18 12:22:54.897095	SL234_F	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP  - barcode F	1	27	61	\N	\N	21	\N
4	2010-01-18 12:22:54.897095	SL285_B	\N	ChIP - H3K9Me1 - barcode B	1	23	60	\N	\N	21	\N
\.


--
-- Data for Name: biosample_dbxref; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY biosample_dbxref (biosample_dbxref_id, biosample_id, dbxref_id) FROM stdin;
\.


--
-- Data for Name: biosample_ecotype; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY biosample_ecotype (biosample_ecotype_id, created_stamp, biosample, ecotype) FROM stdin;
1	2010-01-18 12:22:54.897095	1	1
2	2010-01-18 12:22:54.897095	2	1
3	2010-01-18 12:22:54.897095	3	1
4	2010-01-18 12:22:54.897095	4	7
\.


--
-- Data for Name: biosample_pipedata; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY biosample_pipedata (biosample_pipedata_id, created_stamp, biosample, pipedata) FROM stdin;
1	2010-01-18 12:22:54.897095	1	1
2	2010-01-18 12:22:54.897095	2	1
3	2010-01-18 12:22:54.897095	3	1
4	2010-01-18 12:22:54.897095	4	2
\.


--
-- Data for Name: biosample_pipeproject; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY biosample_pipeproject (biosample_pipeproject_id, biosample, pipeproject) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	2
\.


--
-- Data for Name: cv; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY cv (cv_id, name, definition) FROM stdin;
1	tracking 3 prime adaptor	\N
2	tracking analysis types	\N
3	tracking bar code position	\N
4	tracking biosample processing requirements	\N
5	tracking biosample types	\N
6	tracking file content types	\N
7	tracking file format types	\N
8	tracking fractionation types	\N
9	tracking library types	\N
10	tracking molecule types	\N
11	tracking pipedata property types	\N
12	tracking pipeprocess status	\N
13	tracking publication types	\N
14	tracking quality values	\N
15	tracking sequencing method	\N
16	tracking treatment types	\N
17	tracking users types	\N
\.


--
-- Data for Name: cvterm; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY cvterm (cvterm_id, cv_id, name, definition, dbxref_id, is_obsolete, is_relationshiptype) FROM stdin;
1	1	illumina old adaptor	TCGTATGCCGTCTTCTGCTTGT	1	0	0
2	1	illumina v1.5 adaptor	ATCTCGTATGCCGTCTTCTGCTTG	2	0	0
3	2	bwa alignment	Align reads against a sequence database with BWA	3	0	0
4	2	calculate fasta or fastq file statistics	Get sequence composition statistics from a FASTA or FASTQ file	4	0	0
5	2	fasta index	Create an index of FASTA file	5	0	0
6	2	filter sequences by size	Filter sequences from a FASTA file by size	6	0	0
7	2	genome aligned reads filter	Filter a fasta file, creating a file containing only genome aligned reads	7	0	0
8	2	gff3 index	Create an index of GFF3 file	8	0	0
9	2	gff3 to gff2 converter	Convert a GFF3 file into a GFF2 file	9	0	0
10	2	gff3 to sam converter	Convert a GFF3 file into a SAM file	10	0	0
11	2	patman alignment	Align reads against a sequence database with PatMaN	11	0	0
12	2	remove redundant reads	Read a fasta file of short sequences, remove redundant reads and add a count to the header	12	0	0
13	2	sam to bam converter	Convert a SAM file into a BAM file	13	0	0
14	2	sequencing run	This pseudo-analysis generates raw sequence files, with quality scores	14	0	0
15	2	srf to fastq converter	Create a FastQ file from an SRF file	15	0	0
16	2	ssaha alignment	Align reads against a sequence database with SSAHA	16	0	0
17	2	summarise fasta first base	Read a fasta file of short sequences and summarise the first base composition	17	0	0
18	2	trim reads	Read FastQ files, trim each read to a fixed length or remove adaptor and then create a fasta file	18	0	0
19	3	3-prime	Bar code will be at 3' end of the read	19	0	0
20	3	5-prime	Bar code will be at 5' end of the read	20	0	0
21	4	needs processing	 Processing should be performed for this sample	21	0	0
22	4	no processing	Processing should not be performed for this sample	22	0	0
23	5	chip_seq	Chromatin immunoprecipitation (ChIP) and sequencing	23	0	0
24	5	dna_seq	Genomic DNA sequence	24	0	0
25	5	mrna_expression	Expression analysis of mRNA	25	0	0
26	5	sage_expression	Expression analysis using SAGE	26	0	0
27	5	small_rnas	Small RNA sequences	27	0	0
28	6	aligned_reads	Non-redundant (unique) reads that have been aligned against a reference	28	0	0
29	6	bam_index	A BAM file index created by samtools	29	0	0
30	6	fast_stats	Summary information and statistics about a FASTA or FASTQ file	30	0	0
31	6	fasta_index	An index of a fasta file that has the sequence as the key	31	0	0
32	6	filtered_trimmed_reads	Sequence reads that have been trimmed and then filtered by size	32	0	0
33	6	first_base_summary	A summary of the first base composition of sequences from a fasta file	33	0	0
34	6	gff3_index	An index of a gff3 file that has the read sequence as the key	34	0	0
35	6	n_mer_stats	Counts of each sequence, ordered by count	35	0	0
36	6	non_aligned_reads	Reads that did not align against the reference	36	0	0
37	6	non_redundant_reads	Trimmed and filtered sequence reads with redundant sequences removed	37	0	0
38	6	raw_reads	Raw sequence reads from a sequencing run, before any processing	38	0	0
39	6	redundant_aligned_reads	Redundant reads that align against the a reference - one FASTA record for each read from the original redundant file that matches	39	0	0
40	6	trim_n_rejects	Sequence reads that were rejected by the trim step for containing Ns	40	0	0
41	6	trim_rejects	Sequence reads that were rejected by the trim step for being too short or for not having the correct adaptor or bar code	41	0	0
42	6	trim_unknown_barcode	Sequence reads that were rejected during the trim step because they did not match an expected barcode	42	0	0
43	6	trimmed_reads	Sequence reads that have been trimmed to a fixed length or to remove adaptor sequences	43	0	0
44	7	bam	BAM alignment format	44	0	0
45	7	fasta	FASTA format	45	0	0
46	7	fastq	FastQ format file	46	0	0
47	7	fs	FASTA format with an empty description line	47	0	0
48	7	gff2	GFF2 format	48	0	0
49	7	gff3	GFF3 format	49	0	0
50	7	sam	SAM alignment format	50	0	0
51	7	seq_offset_index	An index of a GFF3 or FASTA format file	51	0	0
52	7	srf	SRF format file	52	0	0
53	7	text	A human readable text file with summaries or statistics	53	0	0
54	7	tsv	A file containing tab-separated value	54	0	0
55	8	no fractionation	no fractionation	55	0	0
56	9	biological replicate	biological replicate/re-run	56	0	0
57	9	failure re-run	re-run because of failure	57	0	0
58	9	initial run	initial sequencing run	58	0	0
59	9	technical replicate	technical replicate/re-run	59	0	0
60	10	DNA	Deoxyribonucleic acid	60	0	0
61	10	RNA	Ribonucleic acid	61	0	0
62	11	alignment component	The target genome component for this alignment, eg. "nuclear genome", "mitochondria"	62	0	0
63	11	alignment ecotype	The target ecotype and organism for this alignment, eg. "unspecified Arabidopsis thaliana"	63	0	0
64	11	alignment program	The program used for this alignment, eg. "ssaha", "bwa", "patman"	64	0	0
65	11	base count	Total number of bases	65	0	0
66	11	gc content	Total G+C bases	66	0	0
67	11	multiplexing code	The barcode found on the reads in this file	67	0	0
68	11	n content	Total N bases	68	0	0
69	11	sequence count	Total number of sequences	69	0	0
70	12	failed	Processing failed	70	0	0
71	12	finished	Processing is done	71	0	0
72	12	not_started	Process has not been queued yet	72	0	0
73	12	queued	A job is queued to run this process	73	0	0
74	12	started	Processing has started	74	0	0
75	13	book	Publication type: book	75	0	0
76	13	book review	Publication type: book review	76	0	0
77	13	conference report	Publication type: conference report	77	0	0
78	13	editorial	Publication type: editorial	78	0	0
79	13	letter	Publication type: letter	79	0	0
80	13	meeting report	Publication type: meeting report	80	0	0
81	13	news article	Publication type: news article	81	0	0
82	13	paper	Publication type: paper	82	0	0
83	13	personal communication	Publication type: personal communication	83	0	0
84	13	review	Publication type: review	84	0	0
85	13	thesis	Publication type: thesis	85	0	0
86	14	high	high quality	86	0	0
87	14	low	low quality	87	0	0
88	14	medium	medium quality	88	0	0
89	14	unknown	unknown quality	89	0	0
90	15	Illumina	Illumina sequencing method	90	0	0
91	16	no treatment	no treatment	91	0	0
92	17	admin	Admin user - full privileges	92	0	0
93	17	external	External user - access only to selected data, no delete/edit privileges	93	0	0
94	17	local	Local user - full access to all data but not full delete/edit privileges	94	0	0
\.


--
-- Data for Name: cvterm_dbxref; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY cvterm_dbxref (cvterm_dbxref_id, cvterm_id, dbxref_id, is_for_definition) FROM stdin;
\.


--
-- Data for Name: db; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY db (db_id, name, description, urlprefix, url) FROM stdin;
1	SmallRNA pipeline database	\N	\N	\N
\.


--
-- Data for Name: dbxref; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY dbxref (dbxref_id, db_id, accession, version, description) FROM stdin;
1	1	illumina old adaptor		\N
2	1	illumina v1.5 adaptor		\N
3	1	bwa alignment		\N
4	1	calculate fasta or fastq file statistics		\N
5	1	fasta index		\N
6	1	filter sequences by size		\N
7	1	genome aligned reads filter		\N
8	1	gff3 index		\N
9	1	gff3 to gff2 converter		\N
10	1	gff3 to sam converter		\N
11	1	patman alignment		\N
12	1	remove redundant reads		\N
13	1	sam to bam converter		\N
14	1	sequencing run		\N
15	1	srf to fastq converter		\N
16	1	ssaha alignment		\N
17	1	summarise fasta first base		\N
18	1	trim reads		\N
19	1	3-prime		\N
20	1	5-prime		\N
21	1	needs processing		\N
22	1	no processing		\N
23	1	chip_seq		\N
24	1	dna_seq		\N
25	1	mrna_expression		\N
26	1	sage_expression		\N
27	1	small_rnas		\N
28	1	aligned_reads		\N
29	1	bam_index		\N
30	1	fast_stats		\N
31	1	fasta_index		\N
32	1	filtered_trimmed_reads		\N
33	1	first_base_summary		\N
34	1	gff3_index		\N
35	1	n_mer_stats		\N
36	1	non_aligned_reads		\N
37	1	non_redundant_reads		\N
38	1	raw_reads		\N
39	1	redundant_aligned_reads		\N
40	1	trim_n_rejects		\N
41	1	trim_rejects		\N
42	1	trim_unknown_barcode		\N
43	1	trimmed_reads		\N
44	1	bam		\N
45	1	fasta		\N
46	1	fastq		\N
47	1	fs		\N
48	1	gff2		\N
49	1	gff3		\N
50	1	sam		\N
51	1	seq_offset_index		\N
52	1	srf		\N
53	1	text		\N
54	1	tsv		\N
55	1	no fractionation		\N
56	1	biological replicate		\N
57	1	failure re-run		\N
58	1	initial run		\N
59	1	technical replicate		\N
60	1	DNA		\N
61	1	RNA		\N
62	1	alignment component		\N
63	1	alignment ecotype		\N
64	1	alignment program		\N
65	1	base count		\N
66	1	gc content		\N
67	1	multiplexing code		\N
68	1	n content		\N
69	1	sequence count		\N
70	1	failed		\N
71	1	finished		\N
72	1	not_started		\N
73	1	queued		\N
74	1	started		\N
75	1	book		\N
76	1	book review		\N
77	1	conference report		\N
78	1	editorial		\N
79	1	letter		\N
80	1	meeting report		\N
81	1	news article		\N
82	1	paper		\N
83	1	personal communication		\N
84	1	review		\N
85	1	thesis		\N
86	1	high		\N
87	1	low		\N
88	1	medium		\N
89	1	unknown		\N
90	1	Illumina		\N
91	1	no treatment		\N
92	1	admin		\N
93	1	external		\N
94	1	local		\N
\.


--
-- Data for Name: ecotype; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY ecotype (ecotype_id, created_stamp, organism, description) FROM stdin;
1	2010-01-18 12:22:53.458617	1	unspecified
2	2010-01-18 12:22:53.458617	1	Col
3	2010-01-18 12:22:53.458617	1	WS
4	2010-01-18 12:22:53.458617	1	Ler
5	2010-01-18 12:22:53.458617	1	C24
6	2010-01-18 12:22:53.458617	1	Cvi
7	2010-01-18 12:22:53.458617	2	unspecified
8	2010-01-18 12:22:53.458617	3	unspecified
9	2010-01-18 12:22:53.458617	4	unspecified
10	2010-01-18 12:22:53.458617	5	unspecified
11	2010-01-18 12:22:53.458617	6	unspecified
12	2010-01-18 12:22:53.458617	7	unspecified
13	2010-01-18 12:22:53.458617	8	unspecified
14	2010-01-18 12:22:53.458617	9	unspecified
15	2010-01-18 12:22:53.458617	10	unspecified
16	2010-01-18 12:22:53.458617	11	unspecified
17	2010-01-18 12:22:53.458617	12	unspecified
18	2010-01-18 12:22:53.458617	12	B73
19	2010-01-18 12:22:53.458617	12	Mo17
20	2010-01-18 12:22:53.458617	14	unspecified
21	2010-01-18 12:22:53.458617	15	unspecified
22	2010-01-18 12:22:53.458617	13	unspecified
23	2010-01-18 12:22:53.458617	13	indica
24	2010-01-18 12:22:53.458617	13	japonica
25	2010-01-18 12:22:53.458617	16	unspecified
26	2010-01-18 12:22:53.458617	17	unspecified
27	2010-01-18 12:22:53.458617	18	unspecified
\.


--
-- Data for Name: library; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY library (library_id, created_stamp, name, description, library_type, biosample, sequencing_sample, adaptor, barcode) FROM stdin;
1	2010-01-18 12:22:54.897095	SL234_B_L1	barcoded library for: SL234_B using barcode: B	58	1	1	1	2
2	2010-01-18 12:22:54.897095	SL234_C_L1	barcoded library for: SL234_C using barcode: C	58	2	1	1	3
3	2010-01-18 12:22:54.897095	SL234_F_L1	barcoded library for: SL234_F using barcode: F	58	3	1	1	6
4	2010-01-18 12:22:54.897095	SL285_B_L1	barcoded library for: SL285_B using barcode: B	58	4	2	1	13
\.


--
-- Data for Name: organisation; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY organisation (organisation_id, created_stamp, name, description) FROM stdin;
1	2010-01-18 12:22:53.385707	DCB	David Baulcombe Lab, University of Cambridge, Dept. of Plant Sciences
2	2010-01-18 12:22:53.385707	CRUK CRI	Cancer Research UK, Cambridge Research Institute
3	2010-01-18 12:22:53.385707	Sainsbury	Sainsbury Laboratory
4	2010-01-18 12:22:53.385707	JIC	John Innes Centre
5	2010-01-18 12:22:53.385707	BGI	Beijing Genomics Institute
6	2010-01-18 12:22:53.385707	CSHL	Cold Spring Harbor Laboratory
7	2010-01-18 12:22:53.385707	Edinburgh	The University of Edinburgh
\.


--
-- Data for Name: organism; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY organism (organism_id, abbreviation, genus, species, common_name, comment) FROM stdin;
1	arath	Arabidopsis	thaliana	thale cress	\N
2	chlre	Chlamydomonas	reinhardtii	chlamy	\N
3		Cardamine	hirsuta	Hairy bittercress	\N
4	caeel	Caenorhabditis	elegans	worm	\N
5	dicdi	Dictyostelium	discoideum	Slime mold	\N
6	clegy	Cleome	gynandra	African cabbage	\N
7	human	Homo	sapiens	human	\N
8	mouse	Mus	musculus	mouse	\N
9	drome	Drosophila	melanogaster	fly	\N
10		Lycopersicon	esculentum	tomato	\N
11		Solanum	lycopersicon	tomato	\N
12	maize	Zea	mays	corn	\N
13	orysa	Oryza	sativa	rice	\N
14	nicbe	Nicotiana	benthamiana	tabaco	\N
15	schpo	Schizosaccharomyces	pombe	pombe	\N
16	tcv	Carmovirus	turnip crinkle virus	tcv	\N
17	rsv	Benyvirus	rice stripe virus	rsv	\N
18	none	Unknown	unknown	none	\N
\.


--
-- Data for Name: organism_dbxref; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY organism_dbxref (organism_dbxref_id, organism_id, dbxref_id) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY person (person_id, created_stamp, first_name, last_name, username, password, role, organisation) FROM stdin;
1	2010-01-18 12:22:53.623589	Andy	Bassett	andy_bassett	andy_bassett	94	1
2	2010-01-18 12:22:53.623589	David	Baulcombe	david_baulcombe	david_baulcombe	94	1
3	2010-01-18 12:22:53.623589	Amy	Beeken	amy_beeken	amy_beeken	94	1
4	2010-01-18 12:22:53.623589	Paola	Fedita	paola_fedita	paola_fedita	94	1
5	2010-01-18 12:22:53.623589	Susi	Heimstaedt	susi_heimstaedt	susi_heimstaedt	94	1
6	2010-01-18 12:22:53.623589	Jagger	Harvey	jagger_harvey	jagger_harvey	94	1
7	2010-01-18 12:22:53.623589	Ericka	Havecker	ericka_havecker	ericka_havecker	94	1
8	2010-01-18 12:22:53.623589	Ian	Henderson	ian_henderson	ian_henderson	94	1
9	2010-01-18 12:22:53.623589	Charles	Melnyk	charles_melnyk	charles_melnyk	94	1
10	2010-01-18 12:22:53.623589	Attila	Molnar	attila_molnar	attila_molnar	94	1
11	2010-01-18 12:22:53.623589	Becky	Mosher	becky_mosher	becky_mosher	94	1
12	2010-01-18 12:22:53.623589	Kanu	Patel	kanu_patel	kanu_patel	94	1
13	2010-01-18 12:22:53.623589	Anna	Peters	anna_peters	anna_peters	94	1
14	2010-01-18 12:22:53.623589	Kim	Rutherford	kim_rutherford	kim_rutherford	92	1
15	2010-01-18 12:22:53.623589	Iain	Searle	iain_searle	iain_searle	94	1
16	2010-01-18 12:22:53.623589	Padubidri	Shivaprasad	padubidri_shivaprasad	padubidri_shivaprasad	94	1
17	2010-01-18 12:22:53.623589	Shuoya	Tang	shuoya_tang	shuoya_tang	94	1
18	2010-01-18 12:22:53.623589	Laura	Taylor	laura_taylor	laura_taylor	94	1
19	2010-01-18 12:22:53.623589	Craig	Thompson	craig_thompson	craig_thompson	94	1
20	2010-01-18 12:22:53.623589	Natasha	Yelina	natasha_yelina	natasha_yelina	94	1
21	2010-01-18 12:22:53.623589	Krys	Kelly	krys_kelly	krys_kelly	94	1
22	2010-01-18 12:22:53.623589	Hannes	V	hannes_v	hannes_v	94	1
23	2010-01-18 12:22:53.623589	Antonis	Giakountis	antonis_giakountis	antonis_giakountis	94	1
\.


--
-- Data for Name: pipedata; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipedata (pipedata_id, created_stamp, format_type, content_type, file_name, file_length, generating_pipeprocess) FROM stdin;
1	2010-01-18 12:22:54.897095	46	38	fastq/SL234_BCF.090202.30W8NAAXX.s_1.fq	517055794	1
2	2010-01-18 12:22:54.897095	46	38	fastq/SL285.090720.42L77AAXX.s_7.fq	912823970	2
\.


--
-- Data for Name: pipedata_property; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipedata_property (pipedata_property_id, pipedata, type, value) FROM stdin;
\.


--
-- Data for Name: pipeprocess; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipeprocess (pipeprocess_id, created_stamp, description, process_conf, status, job_identifier, time_queued, time_started, time_finished) FROM stdin;
1	2010-01-18 12:22:54.897095	Sequencing by CRUK CRI for: SL234_B, SL234_C, SL234_F	1	71	\N	\N	\N	\N
2	2010-01-18 12:22:54.897095	Sequencing by CRUK CRI for: SL285_B	1	71	\N	\N	\N	\N
\.


--
-- Data for Name: pipeprocess_in_pipedata; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipeprocess_in_pipedata (pipeprocess_in_pipedata_id, created_stamp, pipeprocess, pipedata) FROM stdin;
\.


--
-- Data for Name: pipeprocess_pub; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipeprocess_pub (pipeprocess_pub_id, pipeprocess_id, pub_id) FROM stdin;
\.


--
-- Data for Name: pipeproject; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipeproject (pipeproject_id, created_stamp, name, description, owner, funder) FROM stdin;
1	2010-01-18 12:22:54.897095	P_SL234_BCF	P_SL234_BCF	7	\N
2	2010-01-18 12:22:54.897095	P_SL285	P_SL285	1	\N
\.


--
-- Data for Name: process_conf; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY process_conf (process_conf_id, created_stamp, runable_name, detail, type) FROM stdin;
0	2010-01-18 12:22:53.752003	\N	Sainsbury	14
1	2010-01-18 12:22:53.752003	\N	CRI	14
2	2010-01-18 12:22:53.752003	\N	BGI	14
3	2010-01-18 12:22:53.752003	\N	CSHL	14
4	2010-01-18 12:22:53.752003	\N	Edinburgh	14
5	2010-01-18 12:22:53.752003	SmallRNA::Runable::SRFToFastqRunable	\N	15
6	2010-01-18 12:22:53.752003	SmallRNA::Runable::TrimRunable	action: remove_adaptors	18
7	2010-01-18 12:22:53.752003	SmallRNA::Runable::TrimRunable	action: passthrough	18
8	2010-01-18 12:22:53.752003	SmallRNA::Runable::TrimRunable	action: trim	18
9	2010-01-18 12:22:53.752003	SmallRNA::Runable::TrimRunable	action: remove_adaptors	18
10	2010-01-18 12:22:53.752003	SmallRNA::Runable::TrimRunable	action: passthrough	18
11	2010-01-18 12:22:53.752003	SmallRNA::Runable::FastStatsRunable	\N	4
12	2010-01-18 12:22:53.752003	SmallRNA::Runable::FastStatsRunable	\N	4
13	2010-01-18 12:22:53.752003	SmallRNA::Runable::FastStatsRunable	\N	4
14	2010-01-18 12:22:53.752003	SmallRNA::Runable::FastStatsRunable	\N	4
15	2010-01-18 12:22:53.752003	SmallRNA::Runable::FastStatsRunable	\N	4
16	2010-01-18 12:22:53.752003	SmallRNA::Runable::FastStatsRunable	\N	4
17	2010-01-18 12:22:53.752003	SmallRNA::Runable::FastStatsRunable	\N	4
18	2010-01-18 12:22:53.752003	SmallRNA::Runable::FastStatsRunable	\N	4
19	2010-01-18 12:22:53.752003	SmallRNA::Runable::FastStatsRunable	\N	4
20	2010-01-18 12:22:53.752003	SmallRNA::Runable::FastStatsRunable	\N	4
21	2010-01-18 12:22:53.752003	SmallRNA::Runable::SizeFilterRunable	min_size: 15	6
22	2010-01-18 12:22:53.752003	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	17
23	2010-01-18 12:22:53.752003	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	17
24	2010-01-18 12:22:53.752003	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	17
25	2010-01-18 12:22:53.752003	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	17
26	2010-01-18 12:22:53.752003	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	17
27	2010-01-18 12:22:53.752003	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	17
28	2010-01-18 12:22:53.752003	SmallRNA::Runable::NonRedundantFastaRunable	\N	12
29	2010-01-18 12:22:53.752003	SmallRNA::Runable::CreateIndexRunable	\N	8
30	2010-01-18 12:22:53.752003	SmallRNA::Runable::CreateIndexRunable	\N	5
31	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: genome, torque_flags: -l pmem=5gb	11
32	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: genome-tair9, torque_flags: -l pmem=5gb	11
33	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: trna	11
34	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: mirbase-hairpin	11
35	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: mirbase-mature	11
36	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: mirbase-maturestar	11
37	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: genome, torque_flags: -l pmem=5gb	11
38	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: genome-20091201, torque_flags: -l pmem=5gb	11
39	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: ests, torque_flags: -l pmem=5gb	11
40	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: concat_ests, ignore_poly_a: yes, torque_flags: -l pmem=5gb	11
41	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: genome, torque_flags: -l pmem=5gb	11
42	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: mirbase-mature, target: "Arabidopsis thaliana", torque_flags: -l pmem=5gb	11
43	2010-01-18 12:22:53.752003	SmallRNA::Runable::BWASearchRunable	component: genome	3
44	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: genome, target: "Arabidopsis thaliana", mismatches: 1, torque_flags: -l pmem=20gb	11
45	2010-01-18 12:22:53.752003	SmallRNA::Runable::PatmanAlignmentRunable	component: mrna, target: "Arabidopsis thaliana", mismatches: 1, torque_flags: -l pmem=20gb	11
46	2010-01-18 12:22:53.752003	SmallRNA::Runable::GenomeMatchingReadsRunable	\N	7
47	2010-01-18 12:22:53.752003	SmallRNA::Runable::GFF3ToSAMRunable	\N	10
48	2010-01-18 12:22:53.752003	SmallRNA::Runable::GFF3ToGFF2Runable	\N	9
49	2010-01-18 12:22:53.752003	SmallRNA::Runable::SAMToBAMRunable	\N	13
50	2010-01-18 12:22:53.752003	SmallRNA::Runable::SAMToBAMRunable	\N	13
51	2010-01-18 12:22:53.752003	SmallRNA::Runable::SAMToBAMRunable	\N	13
52	2010-01-18 12:22:53.752003	SmallRNA::Runable::SAMToBAMRunable	target: "Arabidopsis thaliana"	13
\.


--
-- Data for Name: process_conf_input; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY process_conf_input (process_conf_input_id, created_stamp, process_conf, format_type, content_type, ecotype, biosample_type) FROM stdin;
1	2010-01-18 12:22:53.752003	5	52	38	\N	\N
2	2010-01-18 12:22:53.752003	6	46	38	\N	27
3	2010-01-18 12:22:53.752003	7	46	38	\N	24
4	2010-01-18 12:22:53.752003	8	46	38	\N	23
5	2010-01-18 12:22:53.752003	9	46	38	\N	26
6	2010-01-18 12:22:53.752003	10	46	38	\N	25
7	2010-01-18 12:22:53.752003	11	46	38	\N	\N
8	2010-01-18 12:22:53.752003	12	45	43	\N	\N
9	2010-01-18 12:22:53.752003	13	45	32	\N	\N
10	2010-01-18 12:22:53.752003	14	45	37	\N	\N
11	2010-01-18 12:22:53.752003	15	45	28	\N	\N
12	2010-01-18 12:22:53.752003	16	45	42	\N	\N
13	2010-01-18 12:22:53.752003	17	45	41	\N	\N
14	2010-01-18 12:22:53.752003	18	45	40	\N	\N
15	2010-01-18 12:22:53.752003	19	45	39	\N	\N
16	2010-01-18 12:22:53.752003	20	45	36	\N	\N
17	2010-01-18 12:22:53.752003	21	45	43	\N	\N
18	2010-01-18 12:22:53.752003	22	45	43	\N	\N
19	2010-01-18 12:22:53.752003	23	45	32	\N	\N
20	2010-01-18 12:22:53.752003	24	45	37	\N	\N
21	2010-01-18 12:22:53.752003	25	45	38	\N	\N
22	2010-01-18 12:22:53.752003	26	45	28	\N	\N
23	2010-01-18 12:22:53.752003	27	45	39	\N	\N
24	2010-01-18 12:22:53.752003	28	45	32	\N	\N
25	2010-01-18 12:22:53.752003	29	49	28	\N	\N
26	2010-01-18 12:22:53.752003	30	45	37	\N	\N
27	2010-01-18 12:22:53.752003	31	45	37	1	\N
28	2010-01-18 12:22:53.752003	32	45	37	1	\N
29	2010-01-18 12:22:53.752003	33	45	37	1	\N
30	2010-01-18 12:22:53.752003	34	45	37	1	\N
31	2010-01-18 12:22:53.752003	35	45	37	1	\N
32	2010-01-18 12:22:53.752003	36	45	37	1	\N
33	2010-01-18 12:22:53.752003	37	45	37	16	\N
34	2010-01-18 12:22:53.752003	38	45	37	16	\N
35	2010-01-18 12:22:53.752003	39	45	37	16	\N
36	2010-01-18 12:22:53.752003	40	45	37	16	\N
37	2010-01-18 12:22:53.752003	41	45	37	7	\N
38	2010-01-18 12:22:53.752003	42	45	37	20	\N
39	2010-01-18 12:22:53.752003	43	45	37	1	\N
40	2010-01-18 12:22:53.752003	44	45	37	11	\N
41	2010-01-18 12:22:53.752003	45	45	37	11	\N
42	2010-01-18 12:22:53.752003	46	49	28	\N	\N
43	2010-01-18 12:22:53.752003	47	49	28	\N	\N
44	2010-01-18 12:22:53.752003	48	49	28	\N	\N
45	2010-01-18 12:22:53.752003	49	50	28	1	\N
46	2010-01-18 12:22:53.752003	50	50	28	16	\N
47	2010-01-18 12:22:53.752003	51	50	28	7	\N
48	2010-01-18 12:22:53.752003	52	50	28	11	\N
\.


--
-- Data for Name: protocol; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY protocol (protocol_id, name, description) FROM stdin;
1	unknown	
\.


--
-- Data for Name: pub; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pub (pub_id, title, volumetitle, volume, series_name, issue, pyear, pages, miniref, uniquename, type_id, is_obsolete, publisher, pubplace) FROM stdin;
\.


--
-- Data for Name: pub_dbxref; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pub_dbxref (pub_dbxref_id, pub_id, dbxref_id, is_current) FROM stdin;
\.


--
-- Data for Name: sequencing_run; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sequencing_run (sequencing_run_id, created_stamp, identifier, sequencing_sample, initial_pipedata, sequencing_centre, initial_pipeprocess, submission_date, run_date, data_received_date, quality, sequencing_type) FROM stdin;
1	2010-01-18 12:22:54.897095	RUN_SL234_BCF	1	1	2	1	2009-01-20	2009-02-10	2009-02-10	89	90
2	2010-01-18 12:22:54.897095	RUN_SL285	2	2	2	2	2009-07-14	2009-07-24	2009-07-24	89	90
\.


--
-- Data for Name: sequencing_sample; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sequencing_sample (sequencing_sample_id, name) FROM stdin;
1	CRI_SL234_BCF
2	CRI_SL285
\.


--
-- Data for Name: sequencingrun; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sequencingrun (sequencingrun_id, created_stamp, identifier, sequencing_sample, initial_pipedata, sequencing_centre, initial_pipeprocess, submission_date, run_date, data_received_date, quality, sequencing_type) FROM stdin;
1	2010-01-15 17:27:26.40102	RUN_SL11	1	1	3	1	\N	\N	\N	89	90
2	2010-01-15 17:27:26.40102	RUN_SL54	2	2	3	2	\N	\N	\N	89	90
3	2010-01-15 17:27:26.40102	RUN_SL55	3	3	3	3	\N	\N	\N	89	90
4	2010-01-15 17:27:26.40102	RUN_SL136	4	4	2	4	2008-06-24	2008-09-11	2008-09-11	89	90
5	2010-01-15 17:27:26.40102	RUN_SL165_1	5	5	2	5	2008-08-27	2008-09-11	2008-09-11	89	90
6	2010-01-15 17:27:26.40102	RUN_SL234_BCF	6	6	2	6	2009-01-20	2009-02-10	2009-02-10	89	90
7	2010-01-15 17:27:26.40102	RUN_SL236	7	7	2	7	2009-02-10	2009-03-09	2009-03-09	89	90
8	2010-01-15 17:27:26.40102	RUN_SL285	8	8	2	8	2009-07-14	2009-07-24	2009-07-24	89	90
\.


--
-- Data for Name: tissue; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY tissue (tissue_id, created_stamp, organism, description) FROM stdin;
1	2010-01-18 12:22:53.540551	1	unspecified
2	2010-01-18 12:22:53.540551	1	unopened flowers (stage 0-12)
3	2010-01-18 12:22:53.540551	1	open flowers (stage 13)
4	2010-01-18 12:22:53.540551	1	young siliques (<7 dpf)
5	2010-01-18 12:22:53.540551	1	mature siliques (>7 dpf)
6	2010-01-18 12:22:53.540551	1	young leaves (<14 days)
7	2010-01-18 12:22:53.540551	1	mature leaves (>14 days)
8	2010-01-18 12:22:53.540551	1	vegetative meristem
9	2010-01-18 12:22:53.540551	1	floral meristem
10	2010-01-18 12:22:53.540551	1	roots (including meristem)
11	2010-01-18 12:22:53.540551	1	seedlings (roots, cotyledons, leaves, and meristem)
12	2010-01-18 12:22:53.540551	1	cauline leaves
13	2010-01-18 12:22:53.540551	1	stem
14	2010-01-18 12:22:53.540551	2	unspecified
15	2010-01-18 12:22:53.540551	2	vegetative cells
16	2010-01-18 12:22:53.540551	2	gametes
17	2010-01-18 12:22:53.540551	3	unspecified
18	2010-01-18 12:22:53.540551	4	unspecified
19	2010-01-18 12:22:53.540551	5	unspecified
20	2010-01-18 12:22:53.540551	7	unspecified
21	2010-01-18 12:22:53.540551	10	unspecified
22	2010-01-18 12:22:53.540551	12	unspecified
23	2010-01-18 12:22:53.540551	14	unspecified
24	2010-01-18 12:22:53.540551	15	unspecified
25	2010-01-18 12:22:53.540551	13	unspecified
26	2010-01-18 12:22:53.540551	16	unspecified
27	2010-01-18 12:22:53.540551	17	unspecified
28	2010-01-18 12:22:53.540551	18	unspecified
\.


--
-- Name: barcode_code_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY barcode
    ADD CONSTRAINT barcode_code_constraint UNIQUE (code, barcode_set);


--
-- Name: barcode_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY barcode
    ADD CONSTRAINT barcode_id_pk PRIMARY KEY (barcode_id);


--
-- Name: barcode_identifier_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY barcode
    ADD CONSTRAINT barcode_identifier_constraint UNIQUE (identifier, barcode_set);


--
-- Name: barcode_set_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY barcode_set
    ADD CONSTRAINT barcode_set_id_pk PRIMARY KEY (barcode_set_id);


--
-- Name: barcode_set_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY barcode_set
    ADD CONSTRAINT barcode_set_name_key UNIQUE (name);


--
-- Name: biosample_ecotype_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY biosample_ecotype
    ADD CONSTRAINT biosample_ecotype_constraint UNIQUE (biosample, ecotype);


--
-- Name: biosample_ecotype_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY biosample_ecotype
    ADD CONSTRAINT biosample_ecotype_id_pk PRIMARY KEY (biosample_ecotype_id);


--
-- Name: biosample_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY biosample
    ADD CONSTRAINT biosample_id_pk PRIMARY KEY (biosample_id);


--
-- Name: biosample_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY biosample
    ADD CONSTRAINT biosample_name_key UNIQUE (name);


--
-- Name: biosample_pipedata_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY biosample_pipedata
    ADD CONSTRAINT biosample_pipedata_id_pk PRIMARY KEY (biosample_pipedata_id);


--
-- Name: biosample_pipeproject_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY biosample_pipeproject
    ADD CONSTRAINT biosample_pipeproject_constraint UNIQUE (biosample, pipeproject);


--
-- Name: biosample_pipeproject_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY biosample_pipeproject
    ADD CONSTRAINT biosample_pipeproject_id_pk PRIMARY KEY (biosample_pipeproject_id);


--
-- Name: cv_c1; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY cv
    ADD CONSTRAINT cv_c1 UNIQUE (name);


--
-- Name: cv_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY cv
    ADD CONSTRAINT cv_pkey PRIMARY KEY (cv_id);


--
-- Name: cvterm_c1; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY cvterm
    ADD CONSTRAINT cvterm_c1 UNIQUE (name, cv_id, is_obsolete);


--
-- Name: cvterm_c2; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY cvterm
    ADD CONSTRAINT cvterm_c2 UNIQUE (dbxref_id);


--
-- Name: cvterm_dbxref_c1; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY cvterm_dbxref
    ADD CONSTRAINT cvterm_dbxref_c1 UNIQUE (cvterm_id, dbxref_id);


--
-- Name: cvterm_dbxref_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY cvterm_dbxref
    ADD CONSTRAINT cvterm_dbxref_pkey PRIMARY KEY (cvterm_dbxref_id);


--
-- Name: cvterm_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY cvterm
    ADD CONSTRAINT cvterm_pkey PRIMARY KEY (cvterm_id);


--
-- Name: db_c1; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY db
    ADD CONSTRAINT db_c1 UNIQUE (name);


--
-- Name: db_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY db
    ADD CONSTRAINT db_pkey PRIMARY KEY (db_id);


--
-- Name: dbxref_c1; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY dbxref
    ADD CONSTRAINT dbxref_c1 UNIQUE (db_id, accession, version);


--
-- Name: dbxref_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY dbxref
    ADD CONSTRAINT dbxref_pkey PRIMARY KEY (dbxref_id);


--
-- Name: ecotype_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY ecotype
    ADD CONSTRAINT ecotype_id_pk PRIMARY KEY (ecotype_id);


--
-- Name: library_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY library
    ADD CONSTRAINT library_id_pk PRIMARY KEY (library_id);


--
-- Name: library_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY library
    ADD CONSTRAINT library_name_key UNIQUE (name);


--
-- Name: organisation_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY organisation
    ADD CONSTRAINT organisation_id_pk PRIMARY KEY (organisation_id);


--
-- Name: organism_c1; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY organism
    ADD CONSTRAINT organism_c1 UNIQUE (genus, species);


--
-- Name: organism_dbxref_c1; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY organism_dbxref
    ADD CONSTRAINT organism_dbxref_c1 UNIQUE (organism_id, dbxref_id);


--
-- Name: organism_dbxref_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY organism_dbxref
    ADD CONSTRAINT organism_dbxref_pkey PRIMARY KEY (organism_dbxref_id);


--
-- Name: organism_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY organism
    ADD CONSTRAINT organism_pkey PRIMARY KEY (organism_id);


--
-- Name: person_full_name_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_full_name_constraint UNIQUE (first_name, last_name);


--
-- Name: person_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_id_pk PRIMARY KEY (person_id);


--
-- Name: person_username_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_username_key UNIQUE (username);


--
-- Name: pipedata_file_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_file_name_key UNIQUE (file_name);


--
-- Name: pipedata_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_id_pk PRIMARY KEY (pipedata_id);


--
-- Name: pipedata_property_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipedata_property
    ADD CONSTRAINT pipedata_property_id_pk PRIMARY KEY (pipedata_property_id);


--
-- Name: pipeprocess_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipeprocess
    ADD CONSTRAINT pipeprocess_id_pk PRIMARY KEY (pipeprocess_id);


--
-- Name: pipeprocess_in_pipedata_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipeprocess_in_pipedata
    ADD CONSTRAINT pipeprocess_in_pipedata_id_pk PRIMARY KEY (pipeprocess_in_pipedata_id);


--
-- Name: pipeprocess_in_pk_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipeprocess_in_pipedata
    ADD CONSTRAINT pipeprocess_in_pk_constraint UNIQUE (pipeprocess, pipedata);


--
-- Name: pipeprocess_pub_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipeprocess_pub
    ADD CONSTRAINT pipeprocess_pub_id_pk PRIMARY KEY (pipeprocess_pub_id);


--
-- Name: pipeproject_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipeproject
    ADD CONSTRAINT pipeproject_id_pk PRIMARY KEY (pipeproject_id);


--
-- Name: process_conf_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY process_conf
    ADD CONSTRAINT process_conf_id_pk PRIMARY KEY (process_conf_id);


--
-- Name: process_conf_input_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_id_pk PRIMARY KEY (process_conf_input_id);


--
-- Name: protocol_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY protocol
    ADD CONSTRAINT protocol_id_pk PRIMARY KEY (protocol_id);


--
-- Name: protocol_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY protocol
    ADD CONSTRAINT protocol_name_key UNIQUE (name);


--
-- Name: pub_c1; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pub
    ADD CONSTRAINT pub_c1 UNIQUE (uniquename);


--
-- Name: pub_dbxref_c1; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pub_dbxref
    ADD CONSTRAINT pub_dbxref_c1 UNIQUE (pub_id, dbxref_id);


--
-- Name: pub_dbxref_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pub_dbxref
    ADD CONSTRAINT pub_dbxref_pkey PRIMARY KEY (pub_dbxref_id);


--
-- Name: pub_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pub
    ADD CONSTRAINT pub_pkey PRIMARY KEY (pub_id);


--
-- Name: sequencing_run_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sequencing_run
    ADD CONSTRAINT sequencing_run_id_pk PRIMARY KEY (sequencing_run_id);


--
-- Name: sequencing_run_identifier_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sequencing_run
    ADD CONSTRAINT sequencing_run_identifier_key UNIQUE (identifier);


--
-- Name: sequencing_sample_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sequencing_sample
    ADD CONSTRAINT sequencing_sample_id_pk PRIMARY KEY (sequencing_sample_id);


--
-- Name: sequencing_sample_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sequencing_sample
    ADD CONSTRAINT sequencing_sample_name_key UNIQUE (name);


--
-- Name: sequencingrun_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_id_pk PRIMARY KEY (sequencingrun_id);


--
-- Name: sequencingrun_identifier_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_identifier_key UNIQUE (identifier);


--
-- Name: tissue_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY tissue
    ADD CONSTRAINT tissue_id_pk PRIMARY KEY (tissue_id);


--
-- Name: INDEX cvterm_c1; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON INDEX cvterm_c1 IS 'A name can mean different things in
different contexts; for example "chromosome" in SO and GO. A name
should be unique within an ontology or cv. A name may exist twice in a
cv, in both obsolete and non-obsolete forms - these will be for
different cvterms with different OBO identifiers; so GO documentation
for more details on obsoletion. Note that occasionally multiple
obsolete terms with the same name will exist in the same cv. If this
is a possibility for the ontology under consideration (e.g. GO) then the
ID should be appended to the name to ensure uniqueness.';


--
-- Name: INDEX cvterm_c2; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON INDEX cvterm_c2 IS 'The OBO identifier is globally unique.';


--
-- Name: cvterm_dbxref_idx1; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX cvterm_dbxref_idx1 ON cvterm_dbxref USING btree (cvterm_id);


--
-- Name: cvterm_dbxref_idx2; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX cvterm_dbxref_idx2 ON cvterm_dbxref USING btree (dbxref_id);


--
-- Name: cvterm_idx1; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX cvterm_idx1 ON cvterm USING btree (cv_id);


--
-- Name: cvterm_idx2; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX cvterm_idx2 ON cvterm USING btree (name);


--
-- Name: cvterm_idx3; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX cvterm_idx3 ON cvterm USING btree (dbxref_id);


--
-- Name: dbxref_idx1; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX dbxref_idx1 ON dbxref USING btree (db_id);


--
-- Name: dbxref_idx2; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX dbxref_idx2 ON dbxref USING btree (accession);


--
-- Name: dbxref_idx3; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX dbxref_idx3 ON dbxref USING btree (version);


--
-- Name: organism_dbxref_idx1; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX organism_dbxref_idx1 ON organism_dbxref USING btree (organism_id);


--
-- Name: organism_dbxref_idx2; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX organism_dbxref_idx2 ON organism_dbxref USING btree (dbxref_id);


--
-- Name: pub_dbxref_idx1; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX pub_dbxref_idx1 ON pub_dbxref USING btree (pub_id);


--
-- Name: pub_dbxref_idx2; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX pub_dbxref_idx2 ON pub_dbxref USING btree (dbxref_id);


--
-- Name: pub_idx1; Type: INDEX; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE INDEX pub_idx1 ON pub USING btree (type_id);


--
-- Name: barcode_barcode_set_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY barcode
    ADD CONSTRAINT barcode_barcode_set_fkey FOREIGN KEY (barcode_set) REFERENCES barcode_set(barcode_set_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: barcode_set_position_in_read_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY barcode_set
    ADD CONSTRAINT barcode_set_position_in_read_fkey FOREIGN KEY (position_in_read) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_biosample_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample
    ADD CONSTRAINT biosample_biosample_type_fkey FOREIGN KEY (biosample_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_dbxref_biosample_fk; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample_dbxref
    ADD CONSTRAINT biosample_dbxref_biosample_fk FOREIGN KEY (biosample_id) REFERENCES biosample(biosample_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_dbxref_dbxref_fk; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample_dbxref
    ADD CONSTRAINT biosample_dbxref_dbxref_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_ecotype_biosample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample_ecotype
    ADD CONSTRAINT biosample_ecotype_biosample_fkey FOREIGN KEY (biosample) REFERENCES biosample(biosample_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_ecotype_ecotype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample_ecotype
    ADD CONSTRAINT biosample_ecotype_ecotype_fkey FOREIGN KEY (ecotype) REFERENCES ecotype(ecotype_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_fractionation_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample
    ADD CONSTRAINT biosample_fractionation_type_fkey FOREIGN KEY (fractionation_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_molecule_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample
    ADD CONSTRAINT biosample_molecule_type_fkey FOREIGN KEY (molecule_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_pipedata_biosample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample_pipedata
    ADD CONSTRAINT biosample_pipedata_biosample_fkey FOREIGN KEY (biosample) REFERENCES biosample(biosample_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_pipedata_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample_pipedata
    ADD CONSTRAINT biosample_pipedata_pipedata_fkey FOREIGN KEY (pipedata) REFERENCES pipedata(pipedata_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_pipeproject_biosample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample_pipeproject
    ADD CONSTRAINT biosample_pipeproject_biosample_fkey FOREIGN KEY (biosample) REFERENCES biosample(biosample_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_pipeproject_pipeproject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample_pipeproject
    ADD CONSTRAINT biosample_pipeproject_pipeproject_fkey FOREIGN KEY (pipeproject) REFERENCES pipeproject(pipeproject_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_processing_requirement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample
    ADD CONSTRAINT biosample_processing_requirement_fkey FOREIGN KEY (processing_requirement) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_protocol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample
    ADD CONSTRAINT biosample_protocol_fkey FOREIGN KEY (protocol) REFERENCES protocol(protocol_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_tissue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample
    ADD CONSTRAINT biosample_tissue_fkey FOREIGN KEY (tissue) REFERENCES tissue(tissue_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: biosample_treatment_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY biosample
    ADD CONSTRAINT biosample_treatment_type_fkey FOREIGN KEY (treatment_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cvterm_cv_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY cvterm
    ADD CONSTRAINT cvterm_cv_id_fkey FOREIGN KEY (cv_id) REFERENCES cv(cv_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cvterm_dbxref_cvterm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY cvterm_dbxref
    ADD CONSTRAINT cvterm_dbxref_cvterm_id_fkey FOREIGN KEY (cvterm_id) REFERENCES cvterm(cvterm_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cvterm_dbxref_dbxref_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY cvterm_dbxref
    ADD CONSTRAINT cvterm_dbxref_dbxref_id_fkey FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cvterm_dbxref_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY cvterm
    ADD CONSTRAINT cvterm_dbxref_id_fkey FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbxref_db_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY dbxref
    ADD CONSTRAINT dbxref_db_id_fkey FOREIGN KEY (db_id) REFERENCES db(db_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ecotype_organism_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY ecotype
    ADD CONSTRAINT ecotype_organism_fkey FOREIGN KEY (organism) REFERENCES organism(organism_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: library_adaptor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY library
    ADD CONSTRAINT library_adaptor_fkey FOREIGN KEY (adaptor) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: library_barcode_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY library
    ADD CONSTRAINT library_barcode_fkey FOREIGN KEY (barcode) REFERENCES barcode(barcode_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: library_biosample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY library
    ADD CONSTRAINT library_biosample_fkey FOREIGN KEY (biosample) REFERENCES biosample(biosample_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: library_library_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY library
    ADD CONSTRAINT library_library_type_fkey FOREIGN KEY (library_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: library_sequencing_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY library
    ADD CONSTRAINT library_sequencing_sample_fkey FOREIGN KEY (sequencing_sample) REFERENCES sequencing_sample(sequencing_sample_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: organism_dbxref_dbxref_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY organism_dbxref
    ADD CONSTRAINT organism_dbxref_dbxref_id_fkey FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: organism_dbxref_organism_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY organism_dbxref
    ADD CONSTRAINT organism_dbxref_organism_id_fkey FOREIGN KEY (organism_id) REFERENCES organism(organism_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: person_organisation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_organisation_fkey FOREIGN KEY (organisation) REFERENCES organisation(organisation_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: person_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_role_fkey FOREIGN KEY (role) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipedata_content_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_content_type_fkey FOREIGN KEY (content_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipedata_format_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_format_type_fkey FOREIGN KEY (format_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipedata_generating_pipeprocess_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_generating_pipeprocess_fkey FOREIGN KEY (generating_pipeprocess) REFERENCES pipeprocess(pipeprocess_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipedata_property_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata_property
    ADD CONSTRAINT pipedata_property_pipedata_fkey FOREIGN KEY (pipedata) REFERENCES pipedata(pipedata_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipedata_property_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata_property
    ADD CONSTRAINT pipedata_property_type_fkey FOREIGN KEY (type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeprocess_in_pipedata_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess_in_pipedata
    ADD CONSTRAINT pipeprocess_in_pipedata_pipedata_fkey FOREIGN KEY (pipedata) REFERENCES pipedata(pipedata_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeprocess_in_pipedata_pipeprocess_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess_in_pipedata
    ADD CONSTRAINT pipeprocess_in_pipedata_pipeprocess_fkey FOREIGN KEY (pipeprocess) REFERENCES pipeprocess(pipeprocess_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeprocess_process_conf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess
    ADD CONSTRAINT pipeprocess_process_conf_fkey FOREIGN KEY (process_conf) REFERENCES process_conf(process_conf_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeprocess_pub_pipeprocess_fk; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess_pub
    ADD CONSTRAINT pipeprocess_pub_pipeprocess_fk FOREIGN KEY (pipeprocess_id) REFERENCES pipeprocess(pipeprocess_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeprocess_pub_pub_fk; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess_pub
    ADD CONSTRAINT pipeprocess_pub_pub_fk FOREIGN KEY (pub_id) REFERENCES pub(pub_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeprocess_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess
    ADD CONSTRAINT pipeprocess_status_fkey FOREIGN KEY (status) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeproject_funder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeproject
    ADD CONSTRAINT pipeproject_funder_fkey FOREIGN KEY (funder) REFERENCES organisation(organisation_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeproject_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeproject
    ADD CONSTRAINT pipeproject_owner_fkey FOREIGN KEY (owner) REFERENCES person(person_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: process_conf_input_biosample_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_biosample_type_fkey FOREIGN KEY (biosample_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: process_conf_input_content_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_content_type_fkey FOREIGN KEY (content_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: process_conf_input_ecotype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_ecotype_fkey FOREIGN KEY (ecotype) REFERENCES ecotype(ecotype_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: process_conf_input_format_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_format_type_fkey FOREIGN KEY (format_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: process_conf_input_process_conf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_process_conf_fkey FOREIGN KEY (process_conf) REFERENCES process_conf(process_conf_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: process_conf_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf
    ADD CONSTRAINT process_conf_type_fkey FOREIGN KEY (type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pub_dbxref_dbxref_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pub_dbxref
    ADD CONSTRAINT pub_dbxref_dbxref_id_fkey FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pub_dbxref_pub_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pub_dbxref
    ADD CONSTRAINT pub_dbxref_pub_id_fkey FOREIGN KEY (pub_id) REFERENCES pub(pub_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pub_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pub
    ADD CONSTRAINT pub_type_id_fkey FOREIGN KEY (type_id) REFERENCES cvterm(cvterm_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sequencing_run_initial_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencing_run
    ADD CONSTRAINT sequencing_run_initial_pipedata_fkey FOREIGN KEY (initial_pipedata) REFERENCES pipedata(pipedata_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sequencing_run_initial_pipeprocess_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencing_run
    ADD CONSTRAINT sequencing_run_initial_pipeprocess_fkey FOREIGN KEY (initial_pipeprocess) REFERENCES pipeprocess(pipeprocess_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sequencing_run_quality_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencing_run
    ADD CONSTRAINT sequencing_run_quality_fkey FOREIGN KEY (quality) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sequencing_run_sequencing_centre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencing_run
    ADD CONSTRAINT sequencing_run_sequencing_centre_fkey FOREIGN KEY (sequencing_centre) REFERENCES organisation(organisation_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sequencing_run_sequencing_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencing_run
    ADD CONSTRAINT sequencing_run_sequencing_sample_fkey FOREIGN KEY (sequencing_sample) REFERENCES sequencing_sample(sequencing_sample_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sequencing_run_sequencing_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencing_run
    ADD CONSTRAINT sequencing_run_sequencing_type_fkey FOREIGN KEY (sequencing_type) REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tissue_organism_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY tissue
    ADD CONSTRAINT tissue_organism_fkey FOREIGN KEY (organism) REFERENCES organism(organism_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

