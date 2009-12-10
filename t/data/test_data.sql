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
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_sequencing_type_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_sequencing_sample_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_sequencing_centre_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_quality_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_multiplexing_type_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_initial_pipeprocess_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_initial_pipedata_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_treatment_type_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_tissue_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_sample_type_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_protocol_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_processing_requirement_fkey;
ALTER TABLE ONLY public.sample_pipeproject DROP CONSTRAINT sample_pipeproject_sample_fkey;
ALTER TABLE ONLY public.sample_pipeproject DROP CONSTRAINT sample_pipeproject_pipeproject_fkey;
ALTER TABLE ONLY public.sample_pipedata DROP CONSTRAINT sample_pipedata_sample_fkey;
ALTER TABLE ONLY public.sample_pipedata DROP CONSTRAINT sample_pipedata_pipedata_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_molecule_type_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_fractionation_type_fkey;
ALTER TABLE ONLY public.sample_ecotype DROP CONSTRAINT sample_ecotype_sample_fkey;
ALTER TABLE ONLY public.sample_ecotype DROP CONSTRAINT sample_ecotype_ecotype_fkey;
ALTER TABLE ONLY public.sample_dbxref DROP CONSTRAINT sample_dbxref_sample_fk;
ALTER TABLE ONLY public.sample_dbxref DROP CONSTRAINT sample_dbxref_dbxref_fk;
ALTER TABLE ONLY public.pub DROP CONSTRAINT pub_type_id_fkey;
ALTER TABLE ONLY public.pub_dbxref DROP CONSTRAINT pub_dbxref_pub_id_fkey;
ALTER TABLE ONLY public.pub_dbxref DROP CONSTRAINT pub_dbxref_dbxref_id_fkey;
ALTER TABLE ONLY public.process_conf DROP CONSTRAINT process_conf_type_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_sample_type_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_process_conf_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_format_type_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_ecotype_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_content_type_fkey;
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
ALTER TABLE ONLY public.ecotype DROP CONSTRAINT ecotype_organism_fkey;
ALTER TABLE ONLY public.dbxref DROP CONSTRAINT dbxref_db_id_fkey;
ALTER TABLE ONLY public.cvterm DROP CONSTRAINT cvterm_dbxref_id_fkey;
ALTER TABLE ONLY public.cvterm_dbxref DROP CONSTRAINT cvterm_dbxref_dbxref_id_fkey;
ALTER TABLE ONLY public.cvterm_dbxref DROP CONSTRAINT cvterm_dbxref_cvterm_id_fkey;
ALTER TABLE ONLY public.cvterm DROP CONSTRAINT cvterm_cv_id_fkey;
ALTER TABLE ONLY public.coded_sample DROP CONSTRAINT coded_sample_sequencing_sample_fkey;
ALTER TABLE ONLY public.coded_sample DROP CONSTRAINT coded_sample_sample_fkey;
ALTER TABLE ONLY public.coded_sample DROP CONSTRAINT coded_sample_coded_sample_type_fkey;
ALTER TABLE ONLY public.coded_sample DROP CONSTRAINT coded_sample_barcode_fkey;
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
ALTER TABLE ONLY public.sample_pipeproject DROP CONSTRAINT sample_pipeproject_id_pk;
ALTER TABLE ONLY public.sample_pipeproject DROP CONSTRAINT sample_pipeproject_constraint;
ALTER TABLE ONLY public.sample_pipedata DROP CONSTRAINT sample_pipedata_id_pk;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_name_key;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_id_pk;
ALTER TABLE ONLY public.sample_ecotype DROP CONSTRAINT sample_ecotype_id_pk;
ALTER TABLE ONLY public.sample_ecotype DROP CONSTRAINT sample_ecotype_constraint;
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
ALTER TABLE ONLY public.coded_sample DROP CONSTRAINT coded_sample_id_pk;
ALTER TABLE ONLY public.barcode_set DROP CONSTRAINT barcode_set_name_key;
ALTER TABLE ONLY public.barcode_set DROP CONSTRAINT barcode_set_id_pk;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_identifier_constraint;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_id_pk;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_code_constraint;
ALTER TABLE public.tissue ALTER COLUMN tissue_id DROP DEFAULT;
ALTER TABLE public.sequencingrun ALTER COLUMN sequencingrun_id DROP DEFAULT;
ALTER TABLE public.sequencing_sample ALTER COLUMN sequencing_sample_id DROP DEFAULT;
ALTER TABLE public.sample_pipeproject ALTER COLUMN sample_pipeproject_id DROP DEFAULT;
ALTER TABLE public.sample_pipedata ALTER COLUMN sample_pipedata_id DROP DEFAULT;
ALTER TABLE public.sample_ecotype ALTER COLUMN sample_ecotype_id DROP DEFAULT;
ALTER TABLE public.sample ALTER COLUMN sample_id DROP DEFAULT;
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
ALTER TABLE public.ecotype ALTER COLUMN ecotype_id DROP DEFAULT;
ALTER TABLE public.dbxref ALTER COLUMN dbxref_id DROP DEFAULT;
ALTER TABLE public.db ALTER COLUMN db_id DROP DEFAULT;
ALTER TABLE public.cvterm_dbxref ALTER COLUMN cvterm_dbxref_id DROP DEFAULT;
ALTER TABLE public.cvterm ALTER COLUMN cvterm_id DROP DEFAULT;
ALTER TABLE public.cv ALTER COLUMN cv_id DROP DEFAULT;
ALTER TABLE public.coded_sample ALTER COLUMN coded_sample_id DROP DEFAULT;
ALTER TABLE public.barcode_set ALTER COLUMN barcode_set_id DROP DEFAULT;
ALTER TABLE public.barcode ALTER COLUMN barcode_id DROP DEFAULT;
DROP SEQUENCE public.tissue_tissue_id_seq;
DROP SEQUENCE public.sequencingrun_sequencingrun_id_seq;
DROP SEQUENCE public.sequencing_sample_sequencing_sample_id_seq;
DROP SEQUENCE public.sample_sample_id_seq;
DROP SEQUENCE public.sample_pipeproject_sample_pipeproject_id_seq;
DROP SEQUENCE public.sample_pipedata_sample_pipedata_id_seq;
DROP SEQUENCE public.sample_ecotype_sample_ecotype_id_seq;
DROP SEQUENCE public.pub_pub_id_seq;
DROP SEQUENCE public.pub_dbxref_pub_dbxref_id_seq;
DROP SEQUENCE public.protocol_protocol_id_seq;
DROP SEQUENCE public.process_conf_process_conf_id_seq;
DROP SEQUENCE public.process_conf_input_process_conf_input_id_seq;
DROP SEQUENCE public.pipeproject_pipeproject_id_seq;
DROP SEQUENCE public.pipeprocess_pub_pipeprocess_pub_id_seq;
DROP SEQUENCE public.pipeprocess_pipeprocess_id_seq;
DROP SEQUENCE public.pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq;
DROP SEQUENCE public.pipedata_property_pipedata_property_id_seq;
DROP SEQUENCE public.pipedata_pipedata_id_seq;
DROP SEQUENCE public.person_person_id_seq;
DROP SEQUENCE public.organism_organism_id_seq;
DROP SEQUENCE public.organism_dbxref_organism_dbxref_id_seq;
DROP SEQUENCE public.organisation_organisation_id_seq;
DROP SEQUENCE public.ecotype_ecotype_id_seq;
DROP SEQUENCE public.dbxref_dbxref_id_seq;
DROP SEQUENCE public.db_db_id_seq;
DROP SEQUENCE public.cvterm_dbxref_cvterm_dbxref_id_seq;
DROP SEQUENCE public.cvterm_cvterm_id_seq;
DROP SEQUENCE public.cv_cv_id_seq;
DROP SEQUENCE public.coded_sample_coded_sample_id_seq;
DROP SEQUENCE public.barcode_set_barcode_set_id_seq;
DROP SEQUENCE public.barcode_barcode_id_seq;
DROP OPERATOR CLASS public.gist_bioseg_ops USING gist;
DROP OPERATOR CLASS public.bioseg_ops USING btree;
DROP OPERATOR public.@> (bioseg, bioseg);
DROP OPERATOR public.>> (bioseg, bioseg);
DROP OPERATOR public.>= (bioseg, bioseg);
DROP OPERATOR public.> (bioseg, bioseg);
DROP OPERATOR public.= (bioseg, bioseg);
DROP OPERATOR public.<@ (bioseg, bioseg);
DROP OPERATOR public.<> (bioseg, bioseg);
DROP OPERATOR public.<= (bioseg, bioseg);
DROP OPERATOR public.<< (bioseg, bioseg);
DROP OPERATOR public.< (bioseg, bioseg);
DROP OPERATOR public.&> (bioseg, bioseg);
DROP OPERATOR public.&< (bioseg, bioseg);
DROP OPERATOR public.&& (bioseg, bioseg);
DROP FUNCTION public.bioseg_upper(bioseg);
DROP FUNCTION public.bioseg_size(bioseg);
DROP FUNCTION public.bioseg_sel(internal, oid, internal, integer);
DROP FUNCTION public.bioseg_same(bioseg, bioseg);
DROP FUNCTION public.bioseg_right(bioseg, bioseg);
DROP FUNCTION public.bioseg_overlap(bioseg, bioseg);
DROP FUNCTION public.bioseg_over_right(bioseg, bioseg);
DROP FUNCTION public.bioseg_over_left(bioseg, bioseg);
DROP FUNCTION public.bioseg_lt(bioseg, bioseg);
DROP FUNCTION public.bioseg_lower(bioseg);
DROP FUNCTION public.bioseg_left(bioseg, bioseg);
DROP FUNCTION public.bioseg_le(bioseg, bioseg);
DROP FUNCTION public.bioseg_joinsel(internal, oid, internal, smallint);
DROP FUNCTION public.bioseg_gt(bioseg, bioseg);
DROP FUNCTION public.bioseg_gist_union(internal, internal);
DROP FUNCTION public.bioseg_gist_same(bioseg, bioseg, internal);
DROP FUNCTION public.bioseg_gist_picksplit(internal, internal);
DROP FUNCTION public.bioseg_gist_penalty(internal, internal, internal);
DROP FUNCTION public.bioseg_gist_decompress(internal);
DROP FUNCTION public.bioseg_gist_consistent(internal, bioseg, integer);
DROP FUNCTION public.bioseg_gist_compress(internal);
DROP FUNCTION public.bioseg_ge(bioseg, bioseg);
DROP FUNCTION public.bioseg_different(bioseg, bioseg);
DROP FUNCTION public.bioseg_create(integer, integer);
DROP FUNCTION public.bioseg_contsel(internal, oid, internal, integer);
DROP FUNCTION public.bioseg_contjoinsel(internal, oid, internal, smallint);
DROP FUNCTION public.bioseg_contains(bioseg, bioseg);
DROP FUNCTION public.bioseg_contained(bioseg, bioseg);
DROP FUNCTION public.bioseg_cmp(bioseg, bioseg);
DROP TABLE public.tissue;
DROP TABLE public.sequencingrun;
DROP TABLE public.sequencing_sample;
DROP TABLE public.sample_pipeproject;
DROP TABLE public.sample_pipedata;
DROP TABLE public.sample_ecotype;
DROP TABLE public.sample_dbxref;
DROP TABLE public.sample;
DROP TABLE public.pub_dbxref;
DROP TABLE public.pub;
DROP TABLE public.protocol;
DROP TABLE public.process_conf_input;
DROP TABLE public.process_conf;
DROP TABLE public.pipeproject;
DROP TABLE public.pipeprocess_pub;
DROP TABLE public.pipeprocess_in_pipedata;
DROP TABLE public.pipeprocess;
DROP TABLE public.pipedata_property;
DROP TABLE public.pipedata;
DROP TABLE public.person;
DROP TABLE public.organism_dbxref;
DROP TABLE public.organism;
DROP TABLE public.organisation;
DROP TABLE public.ecotype;
DROP TABLE public.dbxref;
DROP TABLE public.db;
DROP TABLE public.cvterm_dbxref;
DROP TABLE public.cvterm;
DROP TABLE public.cv;
DROP TABLE public.coded_sample;
DROP TYPE public.bioseg CASCADE;
DROP FUNCTION public.bioseg_out(bioseg);
DROP FUNCTION public.bioseg_in(cstring);
DROP TABLE public.barcode_set;
DROP TABLE public.barcode;
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
-- Name: barcode_set; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE barcode_set (
    barcode_set_id integer NOT NULL,
    position_in_read integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.barcode_set OWNER TO kmr44;

--
-- Name: bioseg; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE bioseg;


--
-- Name: bioseg_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_in(cstring) RETURNS bioseg
    AS '$libdir/bioseg', 'bioseg_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_in(cstring) OWNER TO postgres;

--
-- Name: bioseg_out(bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_out(bioseg) RETURNS cstring
    AS '$libdir/bioseg', 'bioseg_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_out(bioseg) OWNER TO postgres;

--
-- Name: bioseg; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE bioseg (
    INTERNALLENGTH = 8,
    INPUT = bioseg_in,
    OUTPUT = bioseg_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.bioseg OWNER TO postgres;

--
-- Name: TYPE bioseg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE bioseg IS 'integer point interval ''INT..INT'', ''INT...INT'', or ''INT''';


--
-- Name: coded_sample; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE coded_sample (
    coded_sample_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    description text,
    coded_sample_type integer NOT NULL,
    sample integer NOT NULL,
    sequencing_sample integer,
    barcode integer
);


ALTER TABLE public.coded_sample OWNER TO kmr44;

--
-- Name: TABLE coded_sample; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE coded_sample IS 'This table records the many-to-many relationship between samples and sequencing runs and the type of the run (initial, re-run, replicate etc.)';


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
-- Name: pipeprocess_pub; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipeprocess_pub (
    pipeprocess_pub_id integer NOT NULL,
    pipeprocess_id integer NOT NULL,
    pub_id integer NOT NULL
);


ALTER TABLE public.pipeprocess_pub OWNER TO kmr44;

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
    sample_type integer
);


ALTER TABLE public.process_conf_input OWNER TO kmr44;

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
-- Name: sample; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sample (
    sample_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    genotype text,
    description text NOT NULL,
    protocol integer NOT NULL,
    sample_type integer NOT NULL,
    molecule_type integer NOT NULL,
    treatment_type integer,
    fractionation_type integer,
    processing_requirement integer NOT NULL,
    tissue integer
);


ALTER TABLE public.sample OWNER TO kmr44;

--
-- Name: sample_dbxref; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sample_dbxref (
    sample_dbxref_id integer NOT NULL,
    sample_id integer NOT NULL,
    dbxref_id integer NOT NULL
);


ALTER TABLE public.sample_dbxref OWNER TO kmr44;

--
-- Name: sample_ecotype; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sample_ecotype (
    sample_ecotype_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    sample integer NOT NULL,
    ecotype integer NOT NULL
);


ALTER TABLE public.sample_ecotype OWNER TO kmr44;

--
-- Name: sample_pipedata; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sample_pipedata (
    sample_pipedata_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    sample integer NOT NULL,
    pipedata integer NOT NULL
);


ALTER TABLE public.sample_pipedata OWNER TO kmr44;

--
-- Name: sample_pipeproject; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sample_pipeproject (
    sample_pipeproject_id integer NOT NULL,
    sample integer NOT NULL,
    pipeproject integer NOT NULL
);


ALTER TABLE public.sample_pipeproject OWNER TO kmr44;

--
-- Name: sequencing_sample; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sequencing_sample (
    sequencing_sample_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.sequencing_sample OWNER TO kmr44;

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
    multiplexing_type integer NOT NULL,
    CONSTRAINT sequencingrun_check CHECK (CASE WHEN (run_date IS NULL) THEN (data_received_date IS NULL) ELSE true END)
);


ALTER TABLE public.sequencingrun OWNER TO kmr44;

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
-- Name: bioseg_cmp(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_cmp(bioseg, bioseg) RETURNS integer
    AS '$libdir/bioseg', 'bioseg_cmp'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_cmp(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_cmp(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_cmp(bioseg, bioseg) IS 'btree comparison function';


--
-- Name: bioseg_contained(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_contained(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_contained'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_contained(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_contained(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_contained(bioseg, bioseg) IS 'contained in';


--
-- Name: bioseg_contains(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_contains(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_contains'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_contains(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_contains(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_contains(bioseg, bioseg) IS 'contains';


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
-- Name: bioseg_create(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_create(integer, integer) RETURNS bioseg
    AS '$libdir/bioseg', 'bioseg_create'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_create(integer, integer) OWNER TO postgres;

--
-- Name: bioseg_different(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_different(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_different'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_different(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_different(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_different(bioseg, bioseg) IS 'different';


--
-- Name: bioseg_ge(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_ge(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_ge'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_ge(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_ge(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_ge(bioseg, bioseg) IS 'greater than or equal';


--
-- Name: bioseg_gist_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_compress(internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_compress(internal) OWNER TO postgres;

--
-- Name: bioseg_gist_consistent(internal, bioseg, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_consistent(internal, bioseg, integer) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_gist_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_consistent(internal, bioseg, integer) OWNER TO postgres;

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
-- Name: bioseg_gist_same(bioseg, bioseg, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_same(bioseg, bioseg, internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_same(bioseg, bioseg, internal) OWNER TO postgres;

--
-- Name: bioseg_gist_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_union(internal, internal) RETURNS bioseg
    AS '$libdir/bioseg', 'bioseg_gist_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_union(internal, internal) OWNER TO postgres;

--
-- Name: bioseg_gt(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gt(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_gt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_gt(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_gt(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_gt(bioseg, bioseg) IS 'greater than';


--
-- Name: bioseg_joinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_joinsel(internal, oid, internal, smallint) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_joinsel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_joinsel(internal, oid, internal, smallint) OWNER TO postgres;

--
-- Name: bioseg_le(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_le(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_le'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_le(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_le(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_le(bioseg, bioseg) IS 'less than or equal';


--
-- Name: bioseg_left(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_left(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_left'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_left(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_left(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_left(bioseg, bioseg) IS 'is left of';


--
-- Name: bioseg_lower(bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_lower(bioseg) RETURNS integer
    AS '$libdir/bioseg', 'bioseg_lower'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_lower(bioseg) OWNER TO postgres;

--
-- Name: bioseg_lt(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_lt(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_lt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_lt(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_lt(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_lt(bioseg, bioseg) IS 'less than';


--
-- Name: bioseg_over_left(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_over_left(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_over_left'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_over_left(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_over_left(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_over_left(bioseg, bioseg) IS 'overlaps or is left of';


--
-- Name: bioseg_over_right(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_over_right(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_over_right'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_over_right(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_over_right(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_over_right(bioseg, bioseg) IS 'overlaps or is right of';


--
-- Name: bioseg_overlap(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_overlap(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_overlap'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_overlap(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_overlap(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_overlap(bioseg, bioseg) IS 'overlaps';


--
-- Name: bioseg_right(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_right(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_right'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_right(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_right(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_right(bioseg, bioseg) IS 'is right of';


--
-- Name: bioseg_same(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_same(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_same'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_same(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_same(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_same(bioseg, bioseg) IS 'same as';


--
-- Name: bioseg_sel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_sel(internal, oid, internal, integer) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_sel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_sel(internal, oid, internal, integer) OWNER TO postgres;

--
-- Name: bioseg_size(bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_size(bioseg) RETURNS integer
    AS '$libdir/bioseg', 'bioseg_size'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_size(bioseg) OWNER TO postgres;

--
-- Name: bioseg_upper(bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_upper(bioseg) RETURNS integer
    AS '$libdir/bioseg', 'bioseg_upper'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_upper(bioseg) OWNER TO postgres;

--
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = bioseg_overlap,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = &&,
    RESTRICT = bioseg_sel,
    JOIN = bioseg_joinsel
);


ALTER OPERATOR public.&& (bioseg, bioseg) OWNER TO postgres;

--
-- Name: &<; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &< (
    PROCEDURE = bioseg_over_left,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&< (bioseg, bioseg) OWNER TO postgres;

--
-- Name: &>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &> (
    PROCEDURE = bioseg_over_right,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&> (bioseg, bioseg) OWNER TO postgres;

--
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = bioseg_lt,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (bioseg, bioseg) OWNER TO postgres;

--
-- Name: <<; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR << (
    PROCEDURE = bioseg_left,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = >>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.<< (bioseg, bioseg) OWNER TO postgres;

--
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = bioseg_le,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (bioseg, bioseg) OWNER TO postgres;

--
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = bioseg_different,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (bioseg, bioseg) OWNER TO postgres;

--
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = bioseg_contained,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = @>,
    RESTRICT = bioseg_contsel,
    JOIN = bioseg_contjoinsel
);


ALTER OPERATOR public.<@ (bioseg, bioseg) OWNER TO postgres;

--
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = bioseg_same,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (bioseg, bioseg) OWNER TO postgres;

--
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = bioseg_gt,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (bioseg, bioseg) OWNER TO postgres;

--
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = bioseg_ge,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (bioseg, bioseg) OWNER TO postgres;

--
-- Name: >>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >> (
    PROCEDURE = bioseg_right,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = <<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.>> (bioseg, bioseg) OWNER TO postgres;

--
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = bioseg_contains,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = <@,
    RESTRICT = bioseg_contsel,
    JOIN = bioseg_contjoinsel
);


ALTER OPERATOR public.@> (bioseg, bioseg) OWNER TO postgres;

--
-- Name: bioseg_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS bioseg_ops
    DEFAULT FOR TYPE bioseg USING btree AS
    OPERATOR 1 <(bioseg,bioseg) ,
    OPERATOR 2 <=(bioseg,bioseg) ,
    OPERATOR 3 =(bioseg,bioseg) ,
    OPERATOR 4 >=(bioseg,bioseg) ,
    OPERATOR 5 >(bioseg,bioseg) ,
    FUNCTION 1 bioseg_cmp(bioseg,bioseg);


ALTER OPERATOR CLASS public.bioseg_ops USING btree OWNER TO postgres;

--
-- Name: gist_bioseg_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_bioseg_ops
    DEFAULT FOR TYPE bioseg USING gist AS
    OPERATOR 1 <<(bioseg,bioseg) ,
    OPERATOR 2 &<(bioseg,bioseg) ,
    OPERATOR 3 &&(bioseg,bioseg) ,
    OPERATOR 4 &>(bioseg,bioseg) ,
    OPERATOR 5 >>(bioseg,bioseg) ,
    OPERATOR 6 =(bioseg,bioseg) ,
    OPERATOR 7 @>(bioseg,bioseg) ,
    OPERATOR 8 <@(bioseg,bioseg) ,
    FUNCTION 1 bioseg_gist_consistent(internal,bioseg,integer) ,
    FUNCTION 2 bioseg_gist_union(internal,internal) ,
    FUNCTION 3 bioseg_gist_compress(internal) ,
    FUNCTION 4 bioseg_gist_decompress(internal) ,
    FUNCTION 5 bioseg_gist_penalty(internal,internal,internal) ,
    FUNCTION 6 bioseg_gist_picksplit(internal,internal) ,
    FUNCTION 7 bioseg_gist_same(bioseg,bioseg,internal);


ALTER OPERATOR CLASS public.gist_bioseg_ops USING gist OWNER TO postgres;

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
-- Name: coded_sample_coded_sample_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE coded_sample_coded_sample_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.coded_sample_coded_sample_id_seq OWNER TO kmr44;

--
-- Name: coded_sample_coded_sample_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE coded_sample_coded_sample_id_seq OWNED BY coded_sample.coded_sample_id;


--
-- Name: coded_sample_coded_sample_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('coded_sample_coded_sample_id_seq', 9, true);


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

SELECT pg_catalog.setval('cvterm_cvterm_id_seq', 92, true);


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

SELECT pg_catalog.setval('dbxref_dbxref_id_seq', 92, true);


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

SELECT pg_catalog.setval('pipedata_pipedata_id_seq', 7, true);


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

SELECT pg_catalog.setval('pipeprocess_pipeprocess_id_seq', 7, true);


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

SELECT pg_catalog.setval('pipeproject_pipeproject_id_seq', 7, true);


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

SELECT pg_catalog.setval('process_conf_input_process_conf_input_id_seq', 39, true);


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
-- Name: sample_ecotype_sample_ecotype_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sample_ecotype_sample_ecotype_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sample_ecotype_sample_ecotype_id_seq OWNER TO kmr44;

--
-- Name: sample_ecotype_sample_ecotype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sample_ecotype_sample_ecotype_id_seq OWNED BY sample_ecotype.sample_ecotype_id;


--
-- Name: sample_ecotype_sample_ecotype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sample_ecotype_sample_ecotype_id_seq', 9, true);


--
-- Name: sample_pipedata_sample_pipedata_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sample_pipedata_sample_pipedata_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sample_pipedata_sample_pipedata_id_seq OWNER TO kmr44;

--
-- Name: sample_pipedata_sample_pipedata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sample_pipedata_sample_pipedata_id_seq OWNED BY sample_pipedata.sample_pipedata_id;


--
-- Name: sample_pipedata_sample_pipedata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sample_pipedata_sample_pipedata_id_seq', 9, true);


--
-- Name: sample_pipeproject_sample_pipeproject_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sample_pipeproject_sample_pipeproject_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sample_pipeproject_sample_pipeproject_id_seq OWNER TO kmr44;

--
-- Name: sample_pipeproject_sample_pipeproject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sample_pipeproject_sample_pipeproject_id_seq OWNED BY sample_pipeproject.sample_pipeproject_id;


--
-- Name: sample_pipeproject_sample_pipeproject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sample_pipeproject_sample_pipeproject_id_seq', 9, true);


--
-- Name: sample_sample_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sample_sample_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sample_sample_id_seq OWNER TO kmr44;

--
-- Name: sample_sample_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sample_sample_id_seq OWNED BY sample.sample_id;


--
-- Name: sample_sample_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sample_sample_id_seq', 9, true);


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

SELECT pg_catalog.setval('sequencing_sample_sequencing_sample_id_seq', 7, true);


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

SELECT pg_catalog.setval('sequencingrun_sequencingrun_id_seq', 7, true);


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
-- Name: coded_sample_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE coded_sample ALTER COLUMN coded_sample_id SET DEFAULT nextval('coded_sample_coded_sample_id_seq'::regclass);


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
-- Name: sample_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sample ALTER COLUMN sample_id SET DEFAULT nextval('sample_sample_id_seq'::regclass);


--
-- Name: sample_ecotype_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sample_ecotype ALTER COLUMN sample_ecotype_id SET DEFAULT nextval('sample_ecotype_sample_ecotype_id_seq'::regclass);


--
-- Name: sample_pipedata_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sample_pipedata ALTER COLUMN sample_pipedata_id SET DEFAULT nextval('sample_pipedata_sample_pipedata_id_seq'::regclass);


--
-- Name: sample_pipeproject_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sample_pipeproject ALTER COLUMN sample_pipeproject_id SET DEFAULT nextval('sample_pipeproject_sample_pipeproject_id_seq'::regclass);


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
1	2009-11-13 18:13:11.093063	A	1	TACCT
2	2009-11-13 18:13:11.093063	B	1	TACGA
3	2009-11-13 18:13:11.093063	C	1	TAGCA
4	2009-11-13 18:13:11.093063	D	1	TAGGT
5	2009-11-13 18:13:11.093063	E	1	TCAAG
6	2009-11-13 18:13:11.093063	F	1	TCATC
7	2009-11-13 18:13:11.093063	G	1	TCTAC
8	2009-11-13 18:13:11.093063	H	1	TCTTG
9	2009-11-13 18:13:11.093063	I	1	TGAAC
10	2009-11-13 18:13:11.093063	J	1	TGTTG
11	2009-11-13 18:13:11.093063	K	1	TGTTC
12	2009-11-13 18:13:11.093063	A	2	AAAT
13	2009-11-13 18:13:11.093063	B	2	ATCT
14	2009-11-13 18:13:11.093063	C	2	AGGT
15	2009-11-13 18:13:11.093063	D	2	ACTT
16	2009-11-13 18:13:11.093063	E	2	TACT
17	2009-11-13 18:13:11.093063	F	2	TTGT
18	2009-11-13 18:13:11.093063	G	2	TGTT
19	2009-11-13 18:13:11.093063	H	2	TCAT
20	2009-11-13 18:13:11.093063	I	2	GAGT
21	2009-11-13 18:13:11.093063	J	2	GTTT
22	2009-11-13 18:13:11.093063	K	2	GGAT
23	2009-11-13 18:13:11.093063	L	2	GCCT
24	2009-11-13 18:13:11.093063	M	2	CATT
25	2009-11-13 18:13:11.093063	N	2	CTAT
26	2009-11-13 18:13:11.093063	O	2	CGCT
27	2009-11-13 18:13:11.093063	P	2	CCGT
28	2009-11-13 18:13:11.093063	A	3	CGTGA
29	2009-11-13 18:13:11.093063	A1	3	ACGCA
30	2009-11-13 18:13:11.093063	A2	3	TGCTC
31	2009-11-13 18:13:11.093063	B	3	GTCGA
32	2009-11-13 18:13:11.093063	B1	3	GCGCG
33	2009-11-13 18:13:11.093063	B2	3	CTCTA
34	2009-11-13 18:13:11.093063	C	3	AGCGC
35	2009-11-13 18:13:11.093063	C1	3	ATGCG
36	2009-11-13 18:13:11.093063	C2	3	GTCTC
37	2009-11-13 18:13:11.093063	D	3	TATGA
38	2009-11-13 18:13:11.093063	D1	3	GTGCA
39	2009-11-13 18:13:11.093063	D2	3	CAGTG
40	2009-11-13 18:13:11.093063	E	3	CACAG
41	2009-11-13 18:13:11.093063	E1	3	GATCG
42	2009-11-13 18:13:11.093063	E2	3	TAGTA
43	2009-11-13 18:13:11.093063	F	3	TGCAG
44	2009-11-13 18:13:11.093063	F1	3	TCTCA
45	2009-11-13 18:13:11.093063	F2	3	ACGTG
46	2009-11-13 18:13:11.093063	G	3	CTCAC
47	2009-11-13 18:13:11.093063	G1	3	AGTCG
48	2009-11-13 18:13:11.093063	G2	3	GCGTA
49	2009-11-13 18:13:11.093063	H	3	GTCAG
50	2009-11-13 18:13:11.093063	H1	3	GCAGC
51	2009-11-13 18:13:11.093063	H2	3	TCGTC
52	2009-11-13 18:13:11.093063	I	3	TAGAC
53	2009-11-13 18:13:11.093063	I1	3	AGAGA
54	2009-11-13 18:13:11.093063	I2	3	ATGTA
55	2009-11-13 18:13:11.093063	J	3	GCGAC
56	2009-11-13 18:13:11.093063	J1	3	CGAGC
57	2009-11-13 18:13:11.093063	J2	3	CTGTC
58	2009-11-13 18:13:11.093063	K	3	TCGAG
59	2009-11-13 18:13:11.093063	K1	3	ATAGC
60	2009-11-13 18:13:11.093063	K2	3	GTGTG
61	2009-11-13 18:13:11.093063	L	3	ATGAC
62	2009-11-13 18:13:11.093063	L1	3	CACGA
63	2009-11-13 18:13:11.093063	M	3	CTGAG
64	2009-11-13 18:13:11.093063	M1	3	GACGC
65	2009-11-13 18:13:11.093063	N	3	GATAC
66	2009-11-13 18:13:11.093063	N1	3	TGCGA
67	2009-11-13 18:13:11.093063	O	3	TATAG
68	2009-11-13 18:13:11.093063	O1	3	GCTGA
69	2009-11-13 18:13:11.093063	P	3	GCTAG
70	2009-11-13 18:13:11.093063	P1	3	TCTGC
71	2009-11-13 18:13:11.093063	Q	3	AGTAC
72	2009-11-13 18:13:11.093063	Q1	3	ACATA
73	2009-11-13 18:13:11.093063	R	3	CGTAG
74	2009-11-13 18:13:11.093063	R1	3	GCATG
75	2009-11-13 18:13:11.093063	S	3	ACACG
76	2009-11-13 18:13:11.093063	S1	3	AGATC
77	2009-11-13 18:13:11.093063	T	3	GCACA
78	2009-11-13 18:13:11.093063	T1	3	CGATG
79	2009-11-13 18:13:11.093063	U	3	CGACA
80	2009-11-13 18:13:11.093063	U1	3	TGATA
81	2009-11-13 18:13:11.093063	V	3	TGACG
82	2009-11-13 18:13:11.093063	V1	3	ATATG
83	2009-11-13 18:13:11.093063	W	3	ATACA
84	2009-11-13 18:13:11.093063	W1	3	GTATA
85	2009-11-13 18:13:11.093063	X	3	GTACG
86	2009-11-13 18:13:11.093063	X1	3	CACTC
87	2009-11-13 18:13:11.093063	Y	3	CAGCA
88	2009-11-13 18:13:11.093063	Y1	3	GACTG
89	2009-11-13 18:13:11.093063	Z	3	TAGCG
90	2009-11-13 18:13:11.093063	Z1	3	AGCTG
\.


--
-- Data for Name: barcode_set; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY barcode_set (barcode_set_id, position_in_read, name) FROM stdin;
1	17	DCB small RNA barcode set
2	18	Dmitry's barcode set
3	18	Natasha's barcode set
\.


--
-- Data for Name: coded_sample; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY coded_sample (coded_sample_id, created_stamp, description, coded_sample_type, sample, sequencing_sample, barcode) FROM stdin;
1	2009-11-13 18:13:13.019739	non-barcoded sample for: SL11	21	1	1	\N
2	2009-11-13 18:13:13.019739	non-barcoded sample for: SL54	21	2	2	\N
3	2009-11-13 18:13:13.019739	non-barcoded sample for: SL55	21	3	3	\N
4	2009-11-13 18:13:13.019739	non-barcoded sample for: SL165_1	21	4	4	\N
5	2009-11-13 18:13:13.019739	barcoded sample for: SL234_B using barcode: B	21	5	5	2
6	2009-11-13 18:13:13.019739	barcoded sample for: SL234_C using barcode: C	21	6	5	3
7	2009-11-13 18:13:13.019739	barcoded sample for: SL234_F using barcode: F	21	7	5	6
8	2009-11-13 18:13:13.019739	non-barcoded sample for: SL236	21	8	6	\N
9	2009-11-13 18:13:13.019739	barcoded sample for: SL285_B using barcode: B	21	9	7	13
\.


--
-- Data for Name: cv; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY cv (cv_id, name, definition) FROM stdin;
1	tracking analysis types	\N
2	tracking bar code position	\N
3	tracking coded sample types	\N
4	tracking file content types	\N
5	tracking file format types	\N
6	tracking fractionation types	\N
7	tracking molecule types	\N
8	tracking multiplexing types	\N
9	tracking pipedata property types	\N
10	tracking pipeprocess status	\N
11	tracking publication types	\N
12	tracking quality values	\N
13	tracking sample processing requirements	\N
14	tracking sample types	\N
15	tracking sequencing method	\N
16	tracking treatment types	\N
17	tracking users types	\N
\.


--
-- Data for Name: cvterm; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY cvterm (cvterm_id, cv_id, name, definition, dbxref_id, is_obsolete, is_relationshiptype) FROM stdin;
1	1	bwa alignment	Align reads against a sequence database with BWA	1	0	0
2	1	calculate fasta or fastq file statistics	Get sequence composition statistics from a FASTA or FASTQ file	2	0	0
3	1	fasta index	Create an index of FASTA file	3	0	0
4	1	filter sequences by size	Filter sequences from a FASTA file by size	4	0	0
5	1	genome aligned reads filter	Filter a fasta file, creating a file containing only genome aligned reads	5	0	0
6	1	gff3 index	Create an index of GFF3 file	6	0	0
7	1	gff3 to gff2 converter	Convert a GFF3 file into a GFF2 file	7	0	0
8	1	gff3 to sam converter	Convert a GFF3 file into a SAM file	8	0	0
9	1	multiplexed sequencing run	This pseudo-analysis generates raw sequence files, with quality scores, and uses multiplexing/barcodes	9	0	0
10	1	non-multiplexed sequencing run	This pseudo-analysis generates raw sequence files, with quality scores, with no multiplexing	10	0	0
11	1	patman alignment	Align reads against a sequence database with PatMaN	11	0	0
12	1	remove redundant reads	Read a fasta file of short sequences, remove redundant reads and add a count to the header	12	0	0
13	1	sam to bam converter	Convert a SAM file into a BAM file	13	0	0
14	1	ssaha alignment	Align reads against a sequence database with SSAHA	14	0	0
15	1	summarise fasta first base	Read a fasta file of short sequences and summarise the first base composition	15	0	0
16	1	trim reads	Read FastQ files, trim each read to a fixed length or remove adaptor and then create a fasta file	16	0	0
17	2	3-prime	Bar code will be at 3' end of the read	17	0	0
18	2	5-prime	Bar code will be at 5' end of the read	18	0	0
19	3	biological replicate	biological replicate/re-run	19	0	0
20	3	failure re-run	re-run because of failure	20	0	0
21	3	initial run	initial sequencing run	21	0	0
22	3	technical replicate	technical replicate/re-run	22	0	0
23	4	aligned_reads	Reads that have been aligned against a reference	23	0	0
24	4	bam_index	A BAM file index created by samtools	24	0	0
25	4	fast_stats	Summary information and statistics about a FASTA or FASTQ file	25	0	0
26	4	fasta_index	An index of a fasta file that has the sequence as the key	26	0	0
27	4	filtered_trimmed_reads	Sequence reads that have been trimmed and then filtered by size	27	0	0
28	4	first_base_summary	A summary of the first base composition of sequences from a fasta file	28	0	0
29	4	gff3_index	An index of a gff3 file that has the read sequence as the key	29	0	0
30	4	n_mer_stats	Counts of each sequence, ordered by count	30	0	0
31	4	non_aligned_reads	Reads that did not align against the reference	31	0	0
32	4	non_redundant_reads	Trimmed and filtered sequence reads with redundant sequences removed	32	0	0
33	4	raw_reads	Raw sequence reads from a sequencing run, before any processing	33	0	0
34	4	redundant_aligned_reads	Redundant reads that align against the a reference - one FASTA record for each read from the original redundant file that matches	34	0	0
35	4	trim_n_rejects	Sequence reads that were rejected by the trim step for containing Ns	35	0	0
36	4	trim_rejects	Sequence reads that were rejected by the trim step for being too short or for not having the correct adaptor or bar code	36	0	0
37	4	trim_unknown_barcode	Sequence reads that were rejected during the trim step because they did not match an expected barcode	37	0	0
38	4	trimmed_reads	Sequence reads that have been trimmed to a fixed length or to remove adaptor sequences	38	0	0
39	5	bam	BAM alignment format	39	0	0
40	5	fasta	FASTA format	40	0	0
41	5	fastq	FastQ format file	41	0	0
42	5	fs	FASTA format with an empty description line	42	0	0
43	5	gff2	GFF2 format	43	0	0
44	5	gff3	GFF3 format	44	0	0
45	5	sam	SAM alignment format	45	0	0
46	5	seq_offset_index	An index of a GFF3 or FASTA format file	46	0	0
47	5	text	A human readable text file with summaries or statistics	47	0	0
48	5	tsv	A file containing tab-separated value	48	0	0
49	6	no fractionation	no fractionation	49	0	0
50	7	DNA	Deoxyribonucleic acid	50	0	0
51	7	RNA	Ribonucleic acid	51	0	0
52	8	multiplexed	multiplexed sequencing run using barcodes	52	0	0
53	8	non-multiplexed	One sample per sequencing run	53	0	0
54	9	alignment component	The target genome component for this alignment, eg. "nuclear genome", "mitochondria"	54	0	0
55	9	alignment ecotype	The target ecotype and organism for this alignment, eg. "unspecified Arabidopsis thaliana"	55	0	0
56	9	alignment program	The program used for this alignment, eg. "ssaha", "bwa", "patman"	56	0	0
57	9	base count	Total number of bases	57	0	0
58	9	gc content	Total G+C bases	58	0	0
59	9	multiplexing code	The barcode found on the reads in this file	59	0	0
60	9	n content	Total N bases	60	0	0
61	9	sequence count	Total number of sequences	61	0	0
62	10	failed	Processing failed	62	0	0
63	10	finished	Processing is done	63	0	0
64	10	not_started	Process has not been queued yet	64	0	0
65	10	queued	A job is queued to run this process	65	0	0
66	10	started	Processing has started	66	0	0
67	11	book	Publication type: book	67	0	0
68	11	book review	Publication type: book review	68	0	0
69	11	conference report	Publication type: conference report	69	0	0
70	11	editorial	Publication type: editorial	70	0	0
71	11	letter	Publication type: letter	71	0	0
72	11	meeting report	Publication type: meeting report	72	0	0
73	11	news article	Publication type: news article	73	0	0
74	11	paper	Publication type: paper	74	0	0
75	11	personal communication	Publication type: personal communication	75	0	0
76	11	review	Publication type: review	76	0	0
77	11	thesis	Publication type: thesis	77	0	0
78	12	high	high quality	78	0	0
79	12	low	low quality	79	0	0
80	12	medium	medium quality	80	0	0
81	12	unknown	unknown quality	81	0	0
82	13	needs processing	 Processing should be performed for this sample	82	0	0
83	13	no processing	Processing should not be performed for this sample	83	0	0
84	14	chip_seq	Chromatin immunoprecipitation (ChIP) and sequencing	84	0	0
85	14	dna_seq	Genomic DNA sequence	85	0	0
86	14	mrna_expression	Expression analysis of mRNA	86	0	0
87	14	small_rnas	Small RNA sequences	87	0	0
88	15	Illumina	Illumina sequencing method	88	0	0
89	16	no treatment	no treatment	89	0	0
90	17	admin	Admin user - full privileges	90	0	0
91	17	external	External user - access only to selected data, no delete/edit privileges	91	0	0
92	17	local	Local user - full access to all data but not full delete/edit privileges	92	0	0
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
1	1	bwa alignment		\N
2	1	calculate fasta or fastq file statistics		\N
3	1	fasta index		\N
4	1	filter sequences by size		\N
5	1	genome aligned reads filter		\N
6	1	gff3 index		\N
7	1	gff3 to gff2 converter		\N
8	1	gff3 to sam converter		\N
9	1	multiplexed sequencing run		\N
10	1	non-multiplexed sequencing run		\N
11	1	patman alignment		\N
12	1	remove redundant reads		\N
13	1	sam to bam converter		\N
14	1	ssaha alignment		\N
15	1	summarise fasta first base		\N
16	1	trim reads		\N
17	1	3-prime		\N
18	1	5-prime		\N
19	1	biological replicate		\N
20	1	failure re-run		\N
21	1	initial run		\N
22	1	technical replicate		\N
23	1	aligned_reads		\N
24	1	bam_index		\N
25	1	fast_stats		\N
26	1	fasta_index		\N
27	1	filtered_trimmed_reads		\N
28	1	first_base_summary		\N
29	1	gff3_index		\N
30	1	n_mer_stats		\N
31	1	non_aligned_reads		\N
32	1	non_redundant_reads		\N
33	1	raw_reads		\N
34	1	redundant_aligned_reads		\N
35	1	trim_n_rejects		\N
36	1	trim_rejects		\N
37	1	trim_unknown_barcode		\N
38	1	trimmed_reads		\N
39	1	bam		\N
40	1	fasta		\N
41	1	fastq		\N
42	1	fs		\N
43	1	gff2		\N
44	1	gff3		\N
45	1	sam		\N
46	1	seq_offset_index		\N
47	1	text		\N
48	1	tsv		\N
49	1	no fractionation		\N
50	1	DNA		\N
51	1	RNA		\N
52	1	multiplexed		\N
53	1	non-multiplexed		\N
54	1	alignment component		\N
55	1	alignment ecotype		\N
56	1	alignment program		\N
57	1	base count		\N
58	1	gc content		\N
59	1	multiplexing code		\N
60	1	n content		\N
61	1	sequence count		\N
62	1	failed		\N
63	1	finished		\N
64	1	not_started		\N
65	1	queued		\N
66	1	started		\N
67	1	book		\N
68	1	book review		\N
69	1	conference report		\N
70	1	editorial		\N
71	1	letter		\N
72	1	meeting report		\N
73	1	news article		\N
74	1	paper		\N
75	1	personal communication		\N
76	1	review		\N
77	1	thesis		\N
78	1	high		\N
79	1	low		\N
80	1	medium		\N
81	1	unknown		\N
82	1	needs processing		\N
83	1	no processing		\N
84	1	chip_seq		\N
85	1	dna_seq		\N
86	1	mrna_expression		\N
87	1	small_rnas		\N
88	1	Illumina		\N
89	1	no treatment		\N
90	1	admin		\N
91	1	external		\N
92	1	local		\N
\.


--
-- Data for Name: ecotype; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY ecotype (ecotype_id, created_stamp, organism, description) FROM stdin;
1	2009-11-13 18:13:11.38043	1	unspecified
2	2009-11-13 18:13:11.38043	1	Col
3	2009-11-13 18:13:11.38043	1	WS
4	2009-11-13 18:13:11.38043	1	Ler
5	2009-11-13 18:13:11.38043	1	C24
6	2009-11-13 18:13:11.38043	1	Cvi
7	2009-11-13 18:13:11.38043	2	unspecified
8	2009-11-13 18:13:11.38043	3	unspecified
9	2009-11-13 18:13:11.38043	4	unspecified
10	2009-11-13 18:13:11.38043	5	unspecified
11	2009-11-13 18:13:11.38043	6	unspecified
12	2009-11-13 18:13:11.38043	7	unspecified
13	2009-11-13 18:13:11.38043	8	unspecified
14	2009-11-13 18:13:11.38043	9	unspecified
15	2009-11-13 18:13:11.38043	10	unspecified
16	2009-11-13 18:13:11.38043	11	unspecified
17	2009-11-13 18:13:11.38043	12	unspecified
18	2009-11-13 18:13:11.38043	12	B73
19	2009-11-13 18:13:11.38043	12	Mo17
20	2009-11-13 18:13:11.38043	14	unspecified
21	2009-11-13 18:13:11.38043	15	unspecified
22	2009-11-13 18:13:11.38043	13	unspecified
23	2009-11-13 18:13:11.38043	13	indica
24	2009-11-13 18:13:11.38043	13	japonica
25	2009-11-13 18:13:11.38043	16	unspecified
26	2009-11-13 18:13:11.38043	17	unspecified
27	2009-11-13 18:13:11.38043	18	unspecified
\.


--
-- Data for Name: organisation; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY organisation (organisation_id, created_stamp, name, description) FROM stdin;
1	2009-11-13 18:13:11.315163	DCB	David Baulcombe Lab, University of Cambridge, Dept. of Plant Sciences
2	2009-11-13 18:13:11.315163	CRUK CRI	Cancer Research UK, Cambridge Research Institute
3	2009-11-13 18:13:11.315163	Sainsbury	Sainsbury Laboratory
4	2009-11-13 18:13:11.315163	JIC	John Innes Centre
5	2009-11-13 18:13:11.315163	BGI	Beijing Genomics Institute
6	2009-11-13 18:13:11.315163	CSHL	Cold Spring Harbor Laboratory
7	2009-11-13 18:13:11.315163	Edinburgh	The University of Edinburgh
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
1	2009-11-13 18:13:11.497703	Andy	Bassett	andy_bassett	andy_bassett	92	1
2	2009-11-13 18:13:11.497703	David	Baulcombe	david_baulcombe	david_baulcombe	92	1
3	2009-11-13 18:13:11.497703	Amy	Beeken	amy_beeken	amy_beeken	92	1
4	2009-11-13 18:13:11.497703	Paola	Fedita	paola_fedita	paola_fedita	92	1
5	2009-11-13 18:13:11.497703	Susi	Heimstaedt	susi_heimstaedt	susi_heimstaedt	92	1
6	2009-11-13 18:13:11.497703	Jagger	Harvey	jagger_harvey	jagger_harvey	92	1
7	2009-11-13 18:13:11.497703	Ericka	Havecker	ericka_havecker	ericka_havecker	92	1
8	2009-11-13 18:13:11.497703	Ian	Henderson	ian_henderson	ian_henderson	92	1
9	2009-11-13 18:13:11.497703	Charles	Melnyk	charles_melnyk	charles_melnyk	92	1
10	2009-11-13 18:13:11.497703	Attila	Molnar	attila_molnar	attila_molnar	92	1
11	2009-11-13 18:13:11.497703	Becky	Mosher	becky_mosher	becky_mosher	92	1
12	2009-11-13 18:13:11.497703	Kanu	Patel	kanu_patel	kanu_patel	92	1
13	2009-11-13 18:13:11.497703	Anna	Peters	anna_peters	anna_peters	92	1
14	2009-11-13 18:13:11.497703	Kim	Rutherford	kim_rutherford	kim_rutherford	90	1
15	2009-11-13 18:13:11.497703	Iain	Searle	iain_searle	iain_searle	92	1
16	2009-11-13 18:13:11.497703	Padubidri	Shivaprasad	padubidri_shivaprasad	padubidri_shivaprasad	92	1
17	2009-11-13 18:13:11.497703	Shuoya	Tang	shuoya_tang	shuoya_tang	92	1
18	2009-11-13 18:13:11.497703	Laura	Taylor	laura_taylor	laura_taylor	92	1
19	2009-11-13 18:13:11.497703	Craig	Thompson	craig_thompson	craig_thompson	92	1
20	2009-11-13 18:13:11.497703	Natasha	Yelina	natasha_yelina	natasha_yelina	92	1
21	2009-11-13 18:13:11.497703	Krys	Kelly	krys_kelly	krys_kelly	92	1
22	2009-11-13 18:13:11.497703	Hannes	V	hannes_v	hannes_v	92	1
23	2009-11-13 18:13:11.497703	Antonis	Giakountis	antonis_giakountis	antonis_giakountis	92	1
\.


--
-- Data for Name: pipedata; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipedata (pipedata_id, created_stamp, format_type, content_type, file_name, file_length, generating_pipeprocess) FROM stdin;
1	2009-11-13 18:13:13.019739	40	38	SL11/SL11.ID15_FC5372.lane2.reads.7_5_2008.fa	85196121	1
2	2009-11-13 18:13:13.019739	41	33	fastq/SL54.ID24_171007_FC5359.lane4.fq	308933804	2
3	2009-11-13 18:13:13.019739	41	33	fastq/SL55.ID24_171007_FC5359.lane5.fq	305662338	3
4	2009-11-13 18:13:13.019739	41	33	fastq/SL165.080905.306BFAAXX.s_5.fq	1026029170	4
5	2009-11-13 18:13:13.019739	41	33	fastq/SL234_BCF.090202.30W8NAAXX.s_1.fq	517055794	5
6	2009-11-13 18:13:13.019739	41	33	fastq/SL236.090227.311F6AAXX.s_1.fq	1203596662	6
7	2009-11-13 18:13:13.019739	41	33	fastq/SL285.090720.42L77AAXX.s_7.fq	912823970	7
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
1	2009-11-13 18:13:13.019739	Sequencing by Sainsbury for: SL11	0	63	\N	\N	\N	\N
2	2009-11-13 18:13:13.019739	Sequencing by Sainsbury for: SL54	0	63	\N	\N	\N	\N
3	2009-11-13 18:13:13.019739	Sequencing by Sainsbury for: SL55	0	63	\N	\N	\N	\N
4	2009-11-13 18:13:13.019739	Sequencing by CRUK CRI for: SL165_1	1	63	\N	\N	\N	\N
5	2009-11-13 18:13:13.019739	Sequencing by CRUK CRI for: SL234_B, SL234_C, SL234_F	1	63	\N	\N	\N	\N
6	2009-11-13 18:13:13.019739	Sequencing by CRUK CRI for: SL236	1	63	\N	\N	\N	\N
7	2009-11-13 18:13:13.019739	Sequencing by CRUK CRI for: SL285_B	1	63	\N	\N	\N	\N
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
1	2009-11-13 18:13:13.019739	P_SL11	P_SL11	7	\N
2	2009-11-13 18:13:13.019739	P_SL54	P_SL54	1	\N
3	2009-11-13 18:13:13.019739	P_SL55	P_SL55	1	\N
4	2009-11-13 18:13:13.019739	P_SL165_1	P_SL165_1	1	\N
5	2009-11-13 18:13:13.019739	P_SL234_BCF	P_SL234_BCF	7	\N
6	2009-11-13 18:13:13.019739	P_SL236	P_SL236	10	\N
7	2009-11-13 18:13:13.019739	P_SL285	P_SL285	1	\N
\.


--
-- Data for Name: process_conf; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY process_conf (process_conf_id, created_stamp, runable_name, detail, type) FROM stdin;
0	2009-11-13 18:13:11.588204	\N	Sainsbury	10
1	2009-11-13 18:13:11.588204	\N	CRI	10
2	2009-11-13 18:13:11.588204	\N	CRI	9
3	2009-11-13 18:13:11.588204	\N	BGI	10
4	2009-11-13 18:13:11.588204	\N	CSHL	10
5	2009-11-13 18:13:11.588204	\N	Edinburgh	10
6	2009-11-13 18:13:11.588204	SmallRNA::Runable::TrimRunable	action: remove_adaptors	16
7	2009-11-13 18:13:11.588204	SmallRNA::Runable::TrimRunable	action: passthrough	16
8	2009-11-13 18:13:11.588204	SmallRNA::Runable::TrimRunable	action: trim	16
9	2009-11-13 18:13:11.588204	SmallRNA::Runable::TrimRunable	action: passthrough	16
10	2009-11-13 18:13:11.588204	SmallRNA::Runable::FastStatsRunable	\N	2
11	2009-11-13 18:13:11.588204	SmallRNA::Runable::FastStatsRunable	\N	2
12	2009-11-13 18:13:11.588204	SmallRNA::Runable::FastStatsRunable	\N	2
13	2009-11-13 18:13:11.588204	SmallRNA::Runable::FastStatsRunable	\N	2
14	2009-11-13 18:13:11.588204	SmallRNA::Runable::FastStatsRunable	\N	2
15	2009-11-13 18:13:11.588204	SmallRNA::Runable::FastStatsRunable	\N	2
16	2009-11-13 18:13:11.588204	SmallRNA::Runable::FastStatsRunable	\N	2
17	2009-11-13 18:13:11.588204	SmallRNA::Runable::FastStatsRunable	\N	2
18	2009-11-13 18:13:11.588204	SmallRNA::Runable::FastStatsRunable	\N	2
19	2009-11-13 18:13:11.588204	SmallRNA::Runable::FastStatsRunable	\N	2
20	2009-11-13 18:13:11.588204	SmallRNA::Runable::SizeFilterRunable	min_size: 15	4
21	2009-11-13 18:13:11.588204	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	15
22	2009-11-13 18:13:11.588204	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	15
23	2009-11-13 18:13:11.588204	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	15
24	2009-11-13 18:13:11.588204	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	15
25	2009-11-13 18:13:11.588204	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	15
26	2009-11-13 18:13:11.588204	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	15
27	2009-11-13 18:13:11.588204	SmallRNA::Runable::NonRedundantFastaRunable	\N	12
28	2009-11-13 18:13:11.588204	SmallRNA::Runable::CreateIndexRunable	\N	6
29	2009-11-13 18:13:11.588204	SmallRNA::Runable::CreateIndexRunable	\N	3
30	2009-11-13 18:13:11.588204	SmallRNA::Runable::PatmanAlignmentRunable	component: genome	11
31	2009-11-13 18:13:11.588204	SmallRNA::Runable::PatmanAlignmentRunable	component: trna	11
32	2009-11-13 18:13:11.588204	SmallRNA::Runable::PatmanAlignmentRunable	component: genome	11
33	2009-11-13 18:13:11.588204	SmallRNA::Runable::PatmanAlignmentRunable	component: ests	11
34	2009-11-13 18:13:11.588204	SmallRNA::Runable::PatmanAlignmentRunable	component: concat_ests	11
35	2009-11-13 18:13:11.588204	SmallRNA::Runable::PatmanAlignmentRunable	component: genome	11
36	2009-11-13 18:13:11.588204	SmallRNA::Runable::BWASearchRunable	component: genome	1
37	2009-11-13 18:13:11.588204	SmallRNA::Runable::PatmanAlignmentRunable	component: genome, target: "Arabidopsis thaliana"	11
38	2009-11-13 18:13:11.588204	SmallRNA::Runable::GenomeMatchingReadsRunable	\N	5
39	2009-11-13 18:13:11.588204	SmallRNA::Runable::GFF3ToSAMRunable	\N	8
40	2009-11-13 18:13:11.588204	SmallRNA::Runable::GFF3ToGFF2Runable	\N	7
41	2009-11-13 18:13:11.588204	SmallRNA::Runable::SAMToBAMRunable	component: genome	13
42	2009-11-13 18:13:11.588204	SmallRNA::Runable::SAMToBAMRunable	component: genome	13
43	2009-11-13 18:13:11.588204	SmallRNA::Runable::SAMToBAMRunable	component: genome	13
44	2009-11-13 18:13:11.588204	SmallRNA::Runable::SAMToBAMRunable	component: genome, target: "Arabidopsis thaliana"	13
\.


--
-- Data for Name: process_conf_input; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY process_conf_input (process_conf_input_id, created_stamp, process_conf, format_type, content_type, ecotype, sample_type) FROM stdin;
1	2009-11-13 18:13:11.588204	6	41	33	\N	87
2	2009-11-13 18:13:11.588204	7	41	33	\N	85
3	2009-11-13 18:13:11.588204	8	41	33	\N	84
4	2009-11-13 18:13:11.588204	9	41	33	\N	86
5	2009-11-13 18:13:11.588204	10	41	33	\N	\N
6	2009-11-13 18:13:11.588204	11	40	38	\N	\N
7	2009-11-13 18:13:11.588204	12	40	27	\N	\N
8	2009-11-13 18:13:11.588204	13	40	32	\N	\N
9	2009-11-13 18:13:11.588204	14	40	23	\N	\N
10	2009-11-13 18:13:11.588204	15	40	37	\N	\N
11	2009-11-13 18:13:11.588204	16	40	36	\N	\N
12	2009-11-13 18:13:11.588204	17	40	35	\N	\N
13	2009-11-13 18:13:11.588204	18	40	34	\N	\N
14	2009-11-13 18:13:11.588204	19	40	31	\N	\N
15	2009-11-13 18:13:11.588204	20	40	38	\N	\N
16	2009-11-13 18:13:11.588204	21	40	38	\N	\N
17	2009-11-13 18:13:11.588204	22	40	27	\N	\N
18	2009-11-13 18:13:11.588204	23	40	32	\N	\N
19	2009-11-13 18:13:11.588204	24	40	33	\N	\N
20	2009-11-13 18:13:11.588204	25	40	23	\N	\N
21	2009-11-13 18:13:11.588204	26	40	34	\N	\N
22	2009-11-13 18:13:11.588204	27	40	27	\N	\N
23	2009-11-13 18:13:11.588204	28	44	23	\N	\N
24	2009-11-13 18:13:11.588204	29	40	32	\N	\N
25	2009-11-13 18:13:11.588204	30	40	32	1	\N
26	2009-11-13 18:13:11.588204	31	40	32	1	\N
27	2009-11-13 18:13:11.588204	32	40	32	16	\N
28	2009-11-13 18:13:11.588204	33	40	32	16	\N
29	2009-11-13 18:13:11.588204	34	40	32	16	\N
30	2009-11-13 18:13:11.588204	35	40	32	7	\N
31	2009-11-13 18:13:11.588204	36	40	32	1	\N
32	2009-11-13 18:13:11.588204	37	40	32	11	\N
33	2009-11-13 18:13:11.588204	38	44	23	\N	\N
34	2009-11-13 18:13:11.588204	39	44	23	\N	\N
35	2009-11-13 18:13:11.588204	40	44	23	\N	\N
36	2009-11-13 18:13:11.588204	41	45	23	1	\N
37	2009-11-13 18:13:11.588204	42	45	23	16	\N
38	2009-11-13 18:13:11.588204	43	45	23	7	\N
39	2009-11-13 18:13:11.588204	44	45	23	11	\N
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
-- Data for Name: sample; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sample (sample_id, created_stamp, name, genotype, description, protocol, sample_type, molecule_type, treatment_type, fractionation_type, processing_requirement, tissue) FROM stdin;
1	2009-11-13 18:13:13.019739	SL11	\N	AGO9 associated small RNAs Rep1 (mixed Col-0 floral + silique)	1	87	51	\N	\N	82	\N
2	2009-11-13 18:13:13.019739	SL54	\N	Chlamy total DNA (mononuc)	1	84	50	\N	\N	82	\N
3	2009-11-13 18:13:13.019739	SL55	\N	Chlamy methylated DNA IP (mononuc)	1	84	50	\N	\N	82	\N
4	2009-11-13 18:13:13.019739	SL165_1	\N	Total sRNA mono-P	1	87	51	\N	\N	82	\N
5	2009-11-13 18:13:13.019739	SL234_B	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP  - barcode B	1	87	51	\N	\N	82	\N
6	2009-11-13 18:13:13.019739	SL234_C	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP  - barcode C	1	87	51	\N	\N	82	\N
7	2009-11-13 18:13:13.019739	SL234_F	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP  - barcode F	1	87	51	\N	\N	82	\N
8	2009-11-13 18:13:13.019739	SL236	\N	grafting dcl2,3,4 to dcl2,3,4 (root)	1	87	51	\N	\N	82	\N
9	2009-11-13 18:13:13.019739	SL285_B	\N	ChIP - H3K9Me1 - barcode B	1	84	50	\N	\N	82	\N
\.


--
-- Data for Name: sample_dbxref; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sample_dbxref (sample_dbxref_id, sample_id, dbxref_id) FROM stdin;
\.


--
-- Data for Name: sample_ecotype; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sample_ecotype (sample_ecotype_id, created_stamp, sample, ecotype) FROM stdin;
1	2009-11-13 18:13:13.019739	1	1
2	2009-11-13 18:13:13.019739	2	7
3	2009-11-13 18:13:13.019739	3	7
4	2009-11-13 18:13:13.019739	4	7
5	2009-11-13 18:13:13.019739	5	1
6	2009-11-13 18:13:13.019739	6	1
7	2009-11-13 18:13:13.019739	7	1
8	2009-11-13 18:13:13.019739	8	1
9	2009-11-13 18:13:13.019739	9	7
\.


--
-- Data for Name: sample_pipedata; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sample_pipedata (sample_pipedata_id, created_stamp, sample, pipedata) FROM stdin;
1	2009-11-13 18:13:13.019739	1	1
2	2009-11-13 18:13:13.019739	2	2
3	2009-11-13 18:13:13.019739	3	3
4	2009-11-13 18:13:13.019739	4	4
5	2009-11-13 18:13:13.019739	5	5
6	2009-11-13 18:13:13.019739	6	5
7	2009-11-13 18:13:13.019739	7	5
8	2009-11-13 18:13:13.019739	8	6
9	2009-11-13 18:13:13.019739	9	7
\.


--
-- Data for Name: sample_pipeproject; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sample_pipeproject (sample_pipeproject_id, sample, pipeproject) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
5	5	5
6	6	5
7	7	5
8	8	6
9	9	7
\.


--
-- Data for Name: sequencing_sample; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sequencing_sample (sequencing_sample_id, name) FROM stdin;
1	CRI_SL11
2	CRI_SL54
3	CRI_SL55
4	CRI_SL165_1
5	CRI_SL234_BCF
6	CRI_SL236
7	CRI_SL285
\.


--
-- Data for Name: sequencingrun; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sequencingrun (sequencingrun_id, created_stamp, identifier, sequencing_sample, initial_pipedata, sequencing_centre, initial_pipeprocess, submission_date, run_date, data_received_date, quality, sequencing_type, multiplexing_type) FROM stdin;
1	2009-11-13 18:13:13.019739	RUN_SL11	1	1	3	1	\N	\N	\N	81	88	53
2	2009-11-13 18:13:13.019739	RUN_SL54	2	2	3	2	\N	\N	\N	81	88	53
3	2009-11-13 18:13:13.019739	RUN_SL55	3	3	3	3	\N	\N	\N	81	88	53
4	2009-11-13 18:13:13.019739	RUN_SL165_1	4	4	2	4	2008-08-27	2008-09-11	2008-09-11	81	88	53
5	2009-11-13 18:13:13.019739	RUN_SL234_BCF	5	5	2	5	2009-01-20	2009-02-10	2009-02-10	81	88	52
6	2009-11-13 18:13:13.019739	RUN_SL236	6	6	2	6	2009-02-10	2009-03-09	2009-03-09	81	88	53
7	2009-11-13 18:13:13.019739	RUN_SL285	7	7	2	7	2009-07-14	2009-07-24	2009-07-24	81	88	52
\.


--
-- Data for Name: tissue; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY tissue (tissue_id, created_stamp, organism, description) FROM stdin;
1	2009-11-13 18:13:11.438602	1	unspecified
2	2009-11-13 18:13:11.438602	1	unopened flowers (stage 0-12)
3	2009-11-13 18:13:11.438602	1	open flowers (stage 13)
4	2009-11-13 18:13:11.438602	1	young siliques (<7 dpf)
5	2009-11-13 18:13:11.438602	1	mature siliques (>7 dpf)
6	2009-11-13 18:13:11.438602	1	young leaves (<14 days)
7	2009-11-13 18:13:11.438602	1	mature leaves (>14 days)
8	2009-11-13 18:13:11.438602	1	vegetative meristem
9	2009-11-13 18:13:11.438602	1	floral meristem
10	2009-11-13 18:13:11.438602	1	roots (including meristem)
11	2009-11-13 18:13:11.438602	1	seedlings (roots, cotyledons, leaves, and meristem)
12	2009-11-13 18:13:11.438602	1	cauline leaves
13	2009-11-13 18:13:11.438602	1	stem
14	2009-11-13 18:13:11.438602	2	unspecified
15	2009-11-13 18:13:11.438602	2	vegetative cells
16	2009-11-13 18:13:11.438602	2	gametes
17	2009-11-13 18:13:11.438602	3	unspecified
18	2009-11-13 18:13:11.438602	4	unspecified
19	2009-11-13 18:13:11.438602	5	unspecified
20	2009-11-13 18:13:11.438602	7	unspecified
21	2009-11-13 18:13:11.438602	10	unspecified
22	2009-11-13 18:13:11.438602	12	unspecified
23	2009-11-13 18:13:11.438602	14	unspecified
24	2009-11-13 18:13:11.438602	15	unspecified
25	2009-11-13 18:13:11.438602	13	unspecified
26	2009-11-13 18:13:11.438602	16	unspecified
27	2009-11-13 18:13:11.438602	17	unspecified
28	2009-11-13 18:13:11.438602	18	unspecified
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
-- Name: coded_sample_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY coded_sample
    ADD CONSTRAINT coded_sample_id_pk PRIMARY KEY (coded_sample_id);


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
-- Name: sample_ecotype_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample_ecotype
    ADD CONSTRAINT sample_ecotype_constraint UNIQUE (sample, ecotype);


--
-- Name: sample_ecotype_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample_ecotype
    ADD CONSTRAINT sample_ecotype_id_pk PRIMARY KEY (sample_ecotype_id);


--
-- Name: sample_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_id_pk PRIMARY KEY (sample_id);


--
-- Name: sample_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_name_key UNIQUE (name);


--
-- Name: sample_pipedata_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample_pipedata
    ADD CONSTRAINT sample_pipedata_id_pk PRIMARY KEY (sample_pipedata_id);


--
-- Name: sample_pipeproject_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample_pipeproject
    ADD CONSTRAINT sample_pipeproject_constraint UNIQUE (sample, pipeproject);


--
-- Name: sample_pipeproject_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample_pipeproject
    ADD CONSTRAINT sample_pipeproject_id_pk PRIMARY KEY (sample_pipeproject_id);


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
    ADD CONSTRAINT barcode_barcode_set_fkey FOREIGN KEY (barcode_set) REFERENCES barcode_set(barcode_set_id);


--
-- Name: barcode_set_position_in_read_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY barcode_set
    ADD CONSTRAINT barcode_set_position_in_read_fkey FOREIGN KEY (position_in_read) REFERENCES cvterm(cvterm_id);


--
-- Name: coded_sample_barcode_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY coded_sample
    ADD CONSTRAINT coded_sample_barcode_fkey FOREIGN KEY (barcode) REFERENCES barcode(barcode_id);


--
-- Name: coded_sample_coded_sample_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY coded_sample
    ADD CONSTRAINT coded_sample_coded_sample_type_fkey FOREIGN KEY (coded_sample_type) REFERENCES cvterm(cvterm_id);


--
-- Name: coded_sample_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY coded_sample
    ADD CONSTRAINT coded_sample_sample_fkey FOREIGN KEY (sample) REFERENCES sample(sample_id);


--
-- Name: coded_sample_sequencing_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY coded_sample
    ADD CONSTRAINT coded_sample_sequencing_sample_fkey FOREIGN KEY (sequencing_sample) REFERENCES sequencing_sample(sequencing_sample_id);


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
    ADD CONSTRAINT ecotype_organism_fkey FOREIGN KEY (organism) REFERENCES organism(organism_id);


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
    ADD CONSTRAINT person_organisation_fkey FOREIGN KEY (organisation) REFERENCES organisation(organisation_id);


--
-- Name: person_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_role_fkey FOREIGN KEY (role) REFERENCES cvterm(cvterm_id);


--
-- Name: pipedata_content_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_content_type_fkey FOREIGN KEY (content_type) REFERENCES cvterm(cvterm_id);


--
-- Name: pipedata_format_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_format_type_fkey FOREIGN KEY (format_type) REFERENCES cvterm(cvterm_id);


--
-- Name: pipedata_generating_pipeprocess_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_generating_pipeprocess_fkey FOREIGN KEY (generating_pipeprocess) REFERENCES pipeprocess(pipeprocess_id);


--
-- Name: pipedata_property_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata_property
    ADD CONSTRAINT pipedata_property_pipedata_fkey FOREIGN KEY (pipedata) REFERENCES pipedata(pipedata_id);


--
-- Name: pipedata_property_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata_property
    ADD CONSTRAINT pipedata_property_type_fkey FOREIGN KEY (type) REFERENCES cvterm(cvterm_id);


--
-- Name: pipeprocess_in_pipedata_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess_in_pipedata
    ADD CONSTRAINT pipeprocess_in_pipedata_pipedata_fkey FOREIGN KEY (pipedata) REFERENCES pipedata(pipedata_id);


--
-- Name: pipeprocess_in_pipedata_pipeprocess_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess_in_pipedata
    ADD CONSTRAINT pipeprocess_in_pipedata_pipeprocess_fkey FOREIGN KEY (pipeprocess) REFERENCES pipeprocess(pipeprocess_id);


--
-- Name: pipeprocess_process_conf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess
    ADD CONSTRAINT pipeprocess_process_conf_fkey FOREIGN KEY (process_conf) REFERENCES process_conf(process_conf_id);


--
-- Name: pipeprocess_pub_pipeprocess_fk; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess_pub
    ADD CONSTRAINT pipeprocess_pub_pipeprocess_fk FOREIGN KEY (pipeprocess_id) REFERENCES pipeprocess(pipeprocess_id) ON DELETE CASCADE;


--
-- Name: pipeprocess_pub_pub_fk; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess_pub
    ADD CONSTRAINT pipeprocess_pub_pub_fk FOREIGN KEY (pub_id) REFERENCES pub(pub_id) ON DELETE CASCADE;


--
-- Name: pipeprocess_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess
    ADD CONSTRAINT pipeprocess_status_fkey FOREIGN KEY (status) REFERENCES cvterm(cvterm_id);


--
-- Name: pipeproject_funder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeproject
    ADD CONSTRAINT pipeproject_funder_fkey FOREIGN KEY (funder) REFERENCES organisation(organisation_id);


--
-- Name: pipeproject_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeproject
    ADD CONSTRAINT pipeproject_owner_fkey FOREIGN KEY (owner) REFERENCES person(person_id);


--
-- Name: process_conf_input_content_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_content_type_fkey FOREIGN KEY (content_type) REFERENCES cvterm(cvterm_id);


--
-- Name: process_conf_input_ecotype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_ecotype_fkey FOREIGN KEY (ecotype) REFERENCES ecotype(ecotype_id);


--
-- Name: process_conf_input_format_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_format_type_fkey FOREIGN KEY (format_type) REFERENCES cvterm(cvterm_id);


--
-- Name: process_conf_input_process_conf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_process_conf_fkey FOREIGN KEY (process_conf) REFERENCES process_conf(process_conf_id);


--
-- Name: process_conf_input_sample_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_sample_type_fkey FOREIGN KEY (sample_type) REFERENCES cvterm(cvterm_id);


--
-- Name: process_conf_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf
    ADD CONSTRAINT process_conf_type_fkey FOREIGN KEY (type) REFERENCES cvterm(cvterm_id);


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
-- Name: sample_dbxref_dbxref_fk; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_dbxref
    ADD CONSTRAINT sample_dbxref_dbxref_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) ON DELETE CASCADE;


--
-- Name: sample_dbxref_sample_fk; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_dbxref
    ADD CONSTRAINT sample_dbxref_sample_fk FOREIGN KEY (sample_id) REFERENCES sample(sample_id) ON DELETE CASCADE;


--
-- Name: sample_ecotype_ecotype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_ecotype
    ADD CONSTRAINT sample_ecotype_ecotype_fkey FOREIGN KEY (ecotype) REFERENCES ecotype(ecotype_id);


--
-- Name: sample_ecotype_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_ecotype
    ADD CONSTRAINT sample_ecotype_sample_fkey FOREIGN KEY (sample) REFERENCES sample(sample_id);


--
-- Name: sample_fractionation_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_fractionation_type_fkey FOREIGN KEY (fractionation_type) REFERENCES cvterm(cvterm_id);


--
-- Name: sample_molecule_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_molecule_type_fkey FOREIGN KEY (molecule_type) REFERENCES cvterm(cvterm_id);


--
-- Name: sample_pipedata_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_pipedata
    ADD CONSTRAINT sample_pipedata_pipedata_fkey FOREIGN KEY (pipedata) REFERENCES pipedata(pipedata_id);


--
-- Name: sample_pipedata_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_pipedata
    ADD CONSTRAINT sample_pipedata_sample_fkey FOREIGN KEY (sample) REFERENCES sample(sample_id);


--
-- Name: sample_pipeproject_pipeproject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_pipeproject
    ADD CONSTRAINT sample_pipeproject_pipeproject_fkey FOREIGN KEY (pipeproject) REFERENCES pipeproject(pipeproject_id);


--
-- Name: sample_pipeproject_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_pipeproject
    ADD CONSTRAINT sample_pipeproject_sample_fkey FOREIGN KEY (sample) REFERENCES sample(sample_id);


--
-- Name: sample_processing_requirement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_processing_requirement_fkey FOREIGN KEY (processing_requirement) REFERENCES cvterm(cvterm_id);


--
-- Name: sample_protocol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_protocol_fkey FOREIGN KEY (protocol) REFERENCES protocol(protocol_id);


--
-- Name: sample_sample_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_sample_type_fkey FOREIGN KEY (sample_type) REFERENCES cvterm(cvterm_id);


--
-- Name: sample_tissue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_tissue_fkey FOREIGN KEY (tissue) REFERENCES tissue(tissue_id);


--
-- Name: sample_treatment_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_treatment_type_fkey FOREIGN KEY (treatment_type) REFERENCES cvterm(cvterm_id);


--
-- Name: sequencingrun_initial_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_initial_pipedata_fkey FOREIGN KEY (initial_pipedata) REFERENCES pipedata(pipedata_id);


--
-- Name: sequencingrun_initial_pipeprocess_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_initial_pipeprocess_fkey FOREIGN KEY (initial_pipeprocess) REFERENCES pipeprocess(pipeprocess_id);


--
-- Name: sequencingrun_multiplexing_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_multiplexing_type_fkey FOREIGN KEY (multiplexing_type) REFERENCES cvterm(cvterm_id);


--
-- Name: sequencingrun_quality_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_quality_fkey FOREIGN KEY (quality) REFERENCES cvterm(cvterm_id);


--
-- Name: sequencingrun_sequencing_centre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_sequencing_centre_fkey FOREIGN KEY (sequencing_centre) REFERENCES organisation(organisation_id);


--
-- Name: sequencingrun_sequencing_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_sequencing_sample_fkey FOREIGN KEY (sequencing_sample) REFERENCES sequencing_sample(sequencing_sample_id);


--
-- Name: sequencingrun_sequencing_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_sequencing_type_fkey FOREIGN KEY (sequencing_type) REFERENCES cvterm(cvterm_id);


--
-- Name: tissue_organism_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY tissue
    ADD CONSTRAINT tissue_organism_fkey FOREIGN KEY (organism) REFERENCES organism(organism_id);


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

