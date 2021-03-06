DROP TABLE sequencing_run CASCADE;
DROP TABLE process_conf_input CASCADE;
DROP TABLE process_conf CASCADE;
DROP TABLE pipeprocess CASCADE;
DROP TABLE pipedata CASCADE;
DROP TABLE pipedata_property CASCADE;
DROP TABLE biosample CASCADE;
DROP TABLE biosample_pipeproject CASCADE;
DROP TABLE pipeprocess_in_pipedata CASCADE;
DROP TABLE pipeproject CASCADE;
DROP TABLE person CASCADE;
DROP TABLE organisation CASCADE;
DROP TABLE cvterm CASCADE;
DROP TABLE cv CASCADE;
DROP TABLE db CASCADE;
DROP TABLE pub_dbxref CASCADE;
DROP TABLE cvterm_dbxref CASCADE;
DROP TABLE dbxref CASCADE;
DROP TABLE pub CASCADE;
DROP TABLE barcode CASCADE;
DROP TABLE barcode_set CASCADE;
DROP TABLE tissue CASCADE;
DROP TABLE ecotype CASCADE;
DROP TABLE organism CASCADE;
DROP TABLE organism_dbxref CASCADE;
DROP TABLE biosample_pipedata CASCADE;
DROP TABLE biosample_ecotype CASCADE;
DROP TABLE biosample_dbxref CASCADE;
DROP TABLE library CASCADE;
DROP TABLE sequencing_sample CASCADE;
DROP TABLE protocol CASCADE;
DROP TABLE pipeprocess_pub CASCADE;

\set ON_ERROR_STOP true


-- ================================================
-- TABLE: db
-- ================================================

create table db (
    db_id serial not null,
    primary key (db_id),
    name varchar(255) not null,
--    contact_id int,
--    foreign key (contact_id) references contact (contact_id) on delete cascade INITIALLY DEFERRED,
    description varchar(255) null,
    urlprefix varchar(255) null,
    url varchar(255) null,
    constraint db_c1 unique (name)
);

COMMENT ON TABLE db IS 'A database authority. Typical databases in
bioinformatics are FlyBase, GO, UniProt, NCBI, MGI, etc. The authority
is generally known by this shortened form, which is unique within the
bioinformatics and biomedical realm.  To Do - add support for URIs,
URNs (e.g. LSIDs). We can do this by treating the URL as a URI -
however, some applications may expect this to be resolvable - to be
decided.';

-- ================================================
-- TABLE: dbxref
-- ================================================

create table dbxref (
    dbxref_id serial not null,
    primary key (dbxref_id),
    db_id int not null,
    foreign key (db_id) references db (db_id) on delete cascade INITIALLY DEFERRED,
    accession varchar(255) not null,
    version varchar(255) not null default '',
    description text,
    constraint dbxref_c1 unique (db_id,accession,version)
);
create index dbxref_idx1 on dbxref (db_id);
create index dbxref_idx2 on dbxref (accession);
create index dbxref_idx3 on dbxref (version);

COMMENT ON TABLE dbxref IS 'A unique, global, public, stable identifier. Not necessarily an external reference - can reference data items inside the particular chado instance being used. Typically a row in a table can be uniquely identified with a primary identifier (called dbxref_id); a table may also have secondary identifiers (in a linking table <T>_dbxref). A dbxref is generally written as <DB>:<ACCESSION> or as <DB>:<ACCESSION>:<VERSION>.';

COMMENT ON COLUMN dbxref.accession IS 'The local part of the identifier. Guaranteed by the db authority to be unique for that db.';


CREATE TABLE cv (
                 cv_id serial not null,
                 primary key (cv_id),
                 name varchar(255) not null,
                 definition text,
                 constraint cv_c1 unique (name)
                 );

COMMENT ON TABLE cv IS 'A controlled vocabulary or ontology. A cv is
composed of cvterms (AKA terms, classes, types, universals - relations
and properties are also stored in cvterm) and the relationships
between them.';

COMMENT ON COLUMN cv.name IS 'The name of the ontology. This
corresponds to the obo-format -namespace-. cv names uniquely identify
the cv. In OBO file format, the cv.name is known as the namespace.';

COMMENT ON COLUMN cv.definition IS 'A text description of the criteria for
membership of this ontology.';

-- ================================================
-- TABLE: cvterm
-- ================================================
create table cvterm (
                     cvterm_id serial not null,
                     primary key (cvterm_id),
                     cv_id int not null,
                     foreign key (cv_id) references cv (cv_id) on delete cascade INITIALLY DEFERRED,
                     name varchar(1024) not null,
                     definition text
                   );
create index cvterm_idx1 on cvterm (cv_id);
create index cvterm_idx2 on cvterm (name);

COMMENT ON TABLE cvterm IS 'A term, class, universal or type within an
ontology or controlled vocabulary.  This table is also used for
relations and properties. cvterms constitute nodes in the graph
defined by the collection of cvterms and cvterm_relationships.';

COMMENT ON COLUMN cvterm.cv_id IS 'The cv or ontology or namespace to which
this cvterm belongs.';

COMMENT ON COLUMN cvterm.name IS 'A concise human-readable name or
label for the cvterm. Uniquely identifies a cvterm within a cv.';

COMMENT ON COLUMN cvterm.definition IS 'A human-readable text
definition.';

create table pub (
    pub_id serial not null,
    primary key (pub_id),
    title text,
    volumetitle text,
    volume varchar(255),
    series_name varchar(255),
    issue varchar(255),
    pyear varchar(255),
    pages varchar(255),
    miniref varchar(255),
    uniquename text not null,
    type_id int not null,
    foreign key (type_id) references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED,
    is_obsolete boolean default 'false',
    publisher varchar(255),
    pubplace varchar(255),
    constraint pub_c1 unique (uniquename)
);
CREATE INDEX pub_idx1 ON pub (type_id);

COMMENT ON TABLE pub IS 'A documented provenance artefact - publications,
documents, personal communication.';
COMMENT ON COLUMN pub.title IS 'Descriptive general heading.';
COMMENT ON COLUMN pub.volumetitle IS 'Title of part if one of a series.';
COMMENT ON COLUMN pub.series_name IS 'Full name of (journal) series.';
COMMENT ON COLUMN pub.pages IS 'Page number range[s], e.g. 457--459, viii + 664pp, lv--lvii.';
COMMENT ON COLUMN pub.type_id IS  'The type of the publication (book, journal, poem, graffiti, etc). Uses pub cv.';


-- ================================================
-- TABLE: pub_dbxref
-- ================================================

create table pub_dbxref (
    pub_dbxref_id serial not null,
    primary key (pub_dbxref_id),
    pub_id int not null,
    foreign key (pub_id) references pub (pub_id) on delete cascade INITIALLY DEFERRED,
    dbxref_id int not null,
    foreign key (dbxref_id) references dbxref (dbxref_id) on delete cascade INITIALLY DEFERRED,
    is_current boolean not null default 'true',
    constraint pub_dbxref_c1 unique (pub_id,dbxref_id)
);
create index pub_dbxref_idx1 on pub_dbxref (pub_id);
create index pub_dbxref_idx2 on pub_dbxref (dbxref_id);

COMMENT ON TABLE pub_dbxref IS 'Handle links to repositories,
e.g. Pubmed, Biosis, zoorec, OCLC, Medline, ISSN, coden...';


-- ================================================
-- TABLE: organism
-- ================================================

create table organism (
	organism_id serial not null,
	primary key (organism_id),
	abbreviation varchar(255) null,
	genus varchar(255) not null,
	species varchar(255) not null,
	common_name varchar(255) null,
	comment text null,
	constraint organism_c1 unique (genus,species)
);

COMMENT ON TABLE organism IS 'The organismal taxonomic
classification. Note that phylogenies are represented using the
phylogeny module, and taxonomies can be represented using the cvterm
module or the phylogeny module.';

COMMENT ON COLUMN organism.species IS 'A type of organism is always
uniquely identified by genus and species. When mapping from the NCBI
taxonomy names.dmp file, this column must be used where it
is present, as the common_name column is not always unique (e.g. environmental
samples). If a particular strain or subspecies is to be represented,
this is appended onto the species name. Follows standard NCBI taxonomy
pattern.';

-- ================================================
-- TABLE: organism_dbxref
-- ================================================

create table organism_dbxref (
    organism_dbxref_id serial not null,
    primary key (organism_dbxref_id),
    organism_id int not null,
    foreign key (organism_id) references organism (organism_id) on delete cascade INITIALLY DEFERRED,
    dbxref_id int not null,
    foreign key (dbxref_id) references dbxref (dbxref_id) on delete cascade INITIALLY DEFERRED,
    constraint organism_dbxref_c1 unique (organism_id,dbxref_id)
);
create index organism_dbxref_idx1 on organism_dbxref (organism_id);
create index organism_dbxref_idx2 on organism_dbxref (dbxref_id);


-- ================================================
-- TABLE: cvterm_dbxref
-- ================================================
create table cvterm_dbxref (
    cvterm_dbxref_id serial not null,
    primary key (cvterm_dbxref_id),
    cvterm_id int not null,
    foreign key (cvterm_id) references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED,
    dbxref_id int not null,
    foreign key (dbxref_id) references dbxref (dbxref_id) on delete cascade INITIALLY DEFERRED,
    is_for_definition int not null default 0,
    constraint cvterm_dbxref_c1 unique (cvterm_id,dbxref_id)
);
create index cvterm_dbxref_idx1 on cvterm_dbxref (cvterm_id);
create index cvterm_dbxref_idx2 on cvterm_dbxref (dbxref_id);

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

COMMENT ON COLUMN cvterm_dbxref.is_for_definition IS 'A
cvterm.definition should be supported by one or more references. If
this column is true, the dbxref is not for a term in an external database -
it is a dbxref for provenance information for the definition.';



CREATE TABLE organisation (
       organisation_id serial CONSTRAINT organisation_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       name text NOT NULL,
       description text
);
CREATE TABLE person (
       person_id serial CONSTRAINT person_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       first_name text NOT NULL,
       last_name text NOT NULL,
       username text UNIQUE NOT NULL,
       password text,
       role integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED  NOT NULL,
       organisation integer REFERENCES organisation(organisation_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       CONSTRAINT person_full_name_constraint UNIQUE(first_name, last_name)
);
CREATE TABLE ecotype (
       ecotype_id serial CONSTRAINT ecotype_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       organism integer REFERENCES organism(organism_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       description text NOT NULL
);
CREATE TABLE tissue (
       tissue_id SERIAL CONSTRAINT tissue_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       organism integer REFERENCES organism(organism_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       description text
);
CREATE TABLE pipeproject (
       pipeproject_id serial CONSTRAINT pipeproject_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       identifier text NOT NULL,
       description text,
       owner integer REFERENCES person(person_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       funder integer REFERENCES organisation(organisation_id) DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE process_conf (
       process_conf_id serial CONSTRAINT process_conf_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       runable_name text,
       detail text,
       type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL
);
CREATE TABLE process_conf_input (
       process_conf_input_id serial CONSTRAINT process_conf_input_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       process_conf integer REFERENCES process_conf(process_conf_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       format_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED,
       content_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED,
       ecotype integer REFERENCES ecotype(ecotype_id) DEFERRABLE INITIALLY DEFERRED,
       biosample_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE pipeprocess (
       pipeprocess_id serial CONSTRAINT pipeprocess_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       description text NOT NULL,
       process_conf integer REFERENCES process_conf(process_conf_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       status integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       job_identifier text,
       time_queued timestamp,
       time_started timestamp,
       time_finished timestamp
);
CREATE TABLE barcode_set (
       barcode_set_id serial CONSTRAINT barcode_set_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       position_in_read integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       name text NOT NULL UNIQUE
);
CREATE TABLE barcode (
       barcode_id serial CONSTRAINT barcode_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       identifier text NOT NULL,
       barcode_set integer REFERENCES barcode_set(barcode_set_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       code text NOT NULL,
       CONSTRAINT barcode_identifier_constraint UNIQUE(identifier, barcode_set),
       CONSTRAINT barcode_code_constraint UNIQUE(code, barcode_set)
);
CREATE TABLE protocol (
       protocol_id serial CONSTRAINT protocol_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       name text UNIQUE NOT NULL,
       description text NOT NULL
);
CREATE TABLE biosample (
       biosample_id serial CONSTRAINT biosample_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       name text NOT NULL UNIQUE,
       biosample_creator integer NOT NULL REFERENCES person(person_id) DEFERRABLE INITIALLY DEFERRED,
       genotype text,
       description text NOT NULL,
       protocol integer NOT NULL REFERENCES protocol(protocol_id) DEFERRABLE INITIALLY DEFERRED,
       biosample_type integer NOT NULL REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED,
       molecule_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       treatment_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED,
       fractionation_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED,
       processing_requirement integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       tissue integer REFERENCES tissue(tissue_id) DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE biosample_dbxref (
    biosample_dbxref_id integer NOT NULL,
    created_stamp timestamp NOT NULL DEFAULT now(),
    biosample_id integer NOT NULL,
    dbxref_id integer NOT NULL
);
ALTER TABLE ONLY biosample_dbxref
    ADD CONSTRAINT biosample_dbxref_biosample_fk FOREIGN KEY (biosample_id) REFERENCES biosample(biosample_id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY biosample_dbxref
    ADD CONSTRAINT biosample_dbxref_dbxref_fk FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) DEFERRABLE INITIALLY DEFERRED;


CREATE TABLE biosample_pipeproject (
       biosample_pipeproject_id serial CONSTRAINT biosample_pipeproject_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       biosample integer REFERENCES biosample(biosample_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       pipeproject integer REFERENCES pipeproject(pipeproject_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       CONSTRAINT biosample_pipeproject_constraint UNIQUE(biosample, pipeproject)
);
CREATE TABLE pipedata (
       pipedata_id serial CONSTRAINT pipedata_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       format_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       content_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       file_name text UNIQUE NOT NULL,
       file_length bigint NOT NULL,
       generating_pipeprocess integer REFERENCES pipeprocess(pipeprocess_id) DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE pipedata_property (
       pipedata_property_id serial CONSTRAINT pipedata_property_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       pipedata integer REFERENCES pipedata(pipedata_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       value text NOT NULL
);
CREATE TABLE pipeprocess_in_pipedata (
       pipeprocess_in_pipedata_id serial CONSTRAINT pipeprocess_in_pipedata_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       pipeprocess integer REFERENCES pipeprocess(pipeprocess_id) DEFERRABLE INITIALLY DEFERRED,
       pipedata integer REFERENCES pipedata(pipedata_id) DEFERRABLE INITIALLY DEFERRED,
       CONSTRAINT pipeprocess_in_pk_constraint UNIQUE(pipeprocess, pipedata)
);
COMMENT ON TABLE pipeprocess_in_pipedata IS
        'Join table containing the input pipedatas for a pipeprocess';
CREATE TABLE biosample_pipedata (
       biosample_pipedata_id serial CONSTRAINT biosample_pipedata_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       biosample integer REFERENCES biosample(biosample_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       pipedata integer REFERENCES pipedata(pipedata_id) DEFERRABLE INITIALLY DEFERRED NOT NULL
);
CREATE TABLE biosample_ecotype (
       biosample_ecotype_id serial CONSTRAINT biosample_ecotype_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       biosample integer REFERENCES biosample(biosample_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       ecotype integer REFERENCES ecotype(ecotype_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       CONSTRAINT biosample_ecotype_constraint UNIQUE(biosample, ecotype)
);
CREATE TABLE sequencing_sample (
       sequencing_sample_id serial CONSTRAINT sequencing_sample_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       identifier text NOT NULL UNIQUE,
       read_length integer,
       end_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED,
       sequencing_centre_identifier text UNIQUE,
       number_of_lanes integer,
       sample_creator integer REFERENCES person(person_id) DEFERRABLE INITIALLY DEFERRED NOT NULL
);
CREATE TABLE sequencing_run (
       sequencing_run_id serial CONSTRAINT sequencing_run_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       identifier text NOT NULL UNIQUE,
       sequencing_sample integer NOT NULL REFERENCES sequencing_sample(sequencing_sample_id) DEFERRABLE INITIALLY DEFERRED,
       -- set when fastq arrives:
       initial_pipedata integer REFERENCES pipedata(pipedata_id) DEFERRABLE INITIALLY DEFERRED,
       sequencing_centre integer REFERENCES organisation(organisation_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       -- set when fastq arrives:
       initial_pipeprocess integer REFERENCES pipeprocess(pipeprocess_id) DEFERRABLE INITIALLY DEFERRED,
       submission_date date,
       run_date date,
       data_received_date date,
       quality integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       sequencing_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       CHECK (CASE WHEN run_date IS NULL THEN data_received_date IS NULL ELSE TRUE END)
);
CREATE TABLE library (
       library_id serial CONSTRAINT library_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       identifier text NOT NULL UNIQUE,
       sequencing_centre_identifier text UNIQUE,
       description text,
       library_type integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       biosample integer REFERENCES biosample(biosample_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       sequencing_sample integer REFERENCES sequencing_sample(sequencing_sample_id) DEFERRABLE INITIALLY DEFERRED,
       adaptor integer REFERENCES cvterm(cvterm_id) DEFERRABLE INITIALLY DEFERRED NOT NULL,
       barcode integer REFERENCES barcode(barcode_id) DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE pipeprocess_pub (
       pipeprocess_pub_id serial CONSTRAINT pipeprocess_pub_id_pk PRIMARY KEY,
       created_stamp timestamp NOT NULL DEFAULT now(),
       pipeprocess_id integer NOT NULL,
       pub_id integer NOT NULL
);
ALTER TABLE ONLY pipeprocess_pub
    ADD CONSTRAINT pipeprocess_pub_pipeprocess_fk FOREIGN KEY (pipeprocess_id) REFERENCES pipeprocess(pipeprocess_id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY pipeprocess_pub
    ADD CONSTRAINT pipeprocess_pub_pub_fk FOREIGN KEY (pub_id) REFERENCES pub(pub_id) DEFERRABLE INITIALLY DEFERRED;
