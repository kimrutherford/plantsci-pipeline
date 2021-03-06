#!/usr/bin/perl -w

use strict;
use warnings;
use Carp;

use SmallRNA::DB;
use SmallRNA::DBLayer::Loader;
use SmallRNA::Config;

my $config_file_name = shift;

my $config = SmallRNA::Config->new($config_file_name);

my $schema = SmallRNA::DB->new($config);
my $loader = SmallRNA::DBLayer::Loader->new(schema => $schema);

my $pipeline_db = $schema->find_or_create_with_type('Db', { name => 'SmallRNA pipeline database' });

my %terms = (
             'tracking file format types' =>
             {
              'srf' => 'SRF format file',
              'fastq' => 'FastQ format file',
              'fs' => 'FASTA format with an empty description line',
              'fasta' => 'FASTA format',
              'gff2' => 'GFF2 format',
              'gff3' => 'GFF3 format',
              'sam' => 'SAM alignment format',
              'bam' => 'BAM alignment format',
              'bam_index' => 'BAM index file format',
              'seq_offset_index' => 'An index of a GFF3 or FASTA format file',
              'text' => 'A human readable text file with summaries or statistics',
              'tsv' => 'A file containing tab-separated value',
             },
             'tracking file content types' =>
             {
              'raw_reads' =>
                'Raw sequence reads from a sequencing run, before any processing',
              'trimmed_reads' =>
                'Sequence reads that have been trimmed to a fixed length or to remove adaptor sequences',
              'filtered_trimmed_reads' =>
                'Sequence reads that have been trimmed and then filtered by size',
              'non_redundant_reads' =>
                'Trimmed and filtered sequence reads with redundant sequences removed',
              'trim_rejects' =>
                'Sequence reads that were rejected by the trim step for being too short or for not having the correct adaptor or bar code',
              'trim_n_rejects' =>
                'Sequence reads that were rejected by the trim step for containing Ns',
              'trim_unknown_barcode' =>
                'Sequence reads that were rejected during the trim step because they did not match an expected barcode',
              'first_base_summary' =>
                'A summary of the first base composition of sequences from a fasta file',
              'fast_stats' =>
                'Summary information and statistics about a FASTA or FASTQ file',
              'n_mer_stats' =>
                'Counts of each sequence, ordered by count',
              'aligned_reads' =>
                'Non-redundant (unique) reads that have been aligned against a reference',
              'redundant_aligned_reads' =>
                'Redundant reads that align against the a reference - one FASTA record for each read from the original redundant file that matches',
              'redundant_non_aligned_reads' =>
                'Reads that did not align against the reference',
              'non_redundant_non_aligned_reads' =>
                'Unique reads that did not align against the reference',
              'gff3_index' =>
                'An index of a gff3 file that has the read sequence as the key',
              'fasta_index' =>
                'An index of a fasta file that has the sequence as the key',
              'bam_index' =>
                'A BAM file index created by samtools',
             },
             'tracking sequencing method' =>
             {
              'Illumina' => 'Illumina sequencing method',
             },
             'tracking molecule types' =>
             {
              'DNA' => 'Deoxyribonucleic acid',
              'RNA' => 'Ribonucleic acid',
             },
             'tracking quality values' =>
             {
              'high' => 'high quality',
              'medium' => 'medium quality',
              'low' => 'low quality',
              'unknown' => 'unknown quality',
             },
             'tracking pipeprocess status' =>
             {
              'not_started' => 'Process has not been queued yet',
              'queued' => 'A job is queued to run this process',
              'started' => 'Processing has started',
              'finished' => 'Processing is done',
              'failed' => 'Processing failed',
             },
             'tracking biosample processing requirements' =>
             {
              'no processing' => 'Processing should not be performed for this sample',
              'needs processing' =>' Processing should be performed for this sample',
             },
             'tracking analysis types' =>
             {
              'sequencing run' =>
                'This pseudo-analysis generates raw sequence files, ' .
                'with quality scores',
              'srf to fastq converter' =>
                'Create a FastQ file from an SRF file',
              'trim reads' =>
                'Read FastQ files, trim each read to a fixed length or remove adaptor and then create a fasta file',
              'summarise fasta first base' =>
                'Read a fasta file of short sequences and summarise the first base composition',
              'calculate fasta or fastq file statistics' =>
                'Get sequence composition statistics from a FASTA or FASTQ file',
              'filter sequences by size' =>
                'Filter sequences from a FASTA file by size',
              'remove redundant reads' =>
                'Read a fasta file of short sequences, remove redundant reads '
                  . 'and add a count to the header',
              'make redundant fasta' =>
                'Read a non-redundant fasta file of short sequences that has '
                  . 'counts in the header and create a redundant fasta file',
              'ssaha alignment' =>
                'Align reads against a sequence database with SSAHA',
              'patman alignment' =>
                'Align reads against a sequence database with PatMaN',
              'bwa alignment' =>
                'Align reads against a sequence database with BWA',
              'genome aligned reads filter' =>
                'Filter a fasta file, creating a file containing only genome aligned reads',
              'gff3 to gff2 converter' =>
                'Convert a GFF3 file into a GFF2 file',
              'gff3 to sam converter' =>
                'Convert a GFF3 file into a SAM file',
              'sam to bam converter' =>
                'Convert a SAM file into a BAM file',
              'gff3 index' =>
                'Create an index of GFF3 file',
              'fasta index' =>
                'Create an index of FASTA file',
             },
             'tracking library types' =>
             {
              'initial run' => 'initial sequencing run',
              'technical replicate' => 'technical replicate/re-run',
              'biological replicate' => 'biological replicate/re-run',
              'failure re-run' => 're-run because of failure'
             },
             'tracking treatment types' => { 'no treatment' => 'no treatment' },
             'tracking fractionation types' => { 'no fractionation' => 'no fractionation' },

             'tracking users types' =>
             {
              'admin' => 'Admin user - full privileges',
              'local' => 'Local user - full access to all data but not full delete/edit privileges',
              'external' => 'External user - access only to selected data, no delete/edit privileges',
             },
             'tracking biosample types' =>
             {
               small_rnas => 'Small RNA sequences',
               chip_seq => 'Chromatin immunoprecipitation (ChIP) and sequencing',
               mrna_expression => 'Expression analysis of mRNA',
               sage_expression => 'Expression analysis using SAGE',
               dna_seq => 'Genomic DNA sequence',
             },
             'tracking bar code position' =>
             {
               '5-prime' => "Bar code will be at 5' end of the read",
               '3-prime' => "Bar code will be at 3' end of the read",
             },
             'tracking 3 prime adaptor' =>
             {
               'illumina old adaptor' => "TCGTATGCCGTCTTCTGCTTGT",
               'illumina v1.5 adaptor' => "ATCTCGTATGCCGTCTTCTGCTTG",
               'GEX adaptor' => "TCGTATGCCGTCTTCTGCTTGAGTAGCT",
             },
             'tracking publication types' =>
               {
                 'paper' => 'Publication type: paper',
                 'book' => 'Publication type: book',
                 'book review' => 'Publication type: book review',
                 'conference report' => 'Publication type: conference report',
                 'editorial' => 'Publication type: editorial',
                 'letter' => 'Publication type: letter',
                 'meeting report' => 'Publication type: meeting report',
                 'news article' => 'Publication type: news article',
                 'personal communication' => 'Publication type: personal communication',
                 'review' => 'Publication type: review',
                 'thesis' => 'Publication type: thesis',
               },
             'tracking pipedata property types' =>
               {
                 'sequence count' => 'Total number of sequences',
                 'base count' => 'Total number of bases',
                 'gc content' => 'Total G+C bases',
                 'n content' => 'Total N bases',
                 'multiplexing code' => 'The barcode found on the reads in this file',
                 'alignment component' => 'The target genome component for this alignment, eg. "nuclear genome", "mitochondria"',
                 'alignment ecotype' => 'The target ecotype and organism for this alignment, eg. "unspecified Arabidopsis thaliana"',
                 'alignment program' => 'The program used for this alignment, eg. "ssaha", "bwa", "patman"',
               }
            );

my %cvterm_objs = ();

$schema->txn_do(sub {
  for my $term_cv_name (sort keys %terms) {
    my $cv_rs = $schema->resultset('Cv');
    my $cv = $cv_rs->find_or_create({ name => $term_cv_name});

    my %cvterms = %{$terms{$term_cv_name}};

    for my $cvterm_name (sort keys %cvterms) {
      my $definition = $cvterms{$cvterm_name};
      my $rs = $schema->resultset('Cvterm');
      my $obj = $rs->find_or_create({name => $cvterm_name,
                             definition => $definition,
                             cv => $cv});

      $cvterm_objs{$cvterm_name} = $obj;
    }
  }
});

sub _get_cvterm
{
  my $term_name = shift;

  my $obj = $cvterm_objs{$term_name};

  if (defined $obj) {
    return $obj;
  } else {
    croak "no cvterm for term name: $term_name\n";
  }
}

my %barcode_sets = (
  "DCB small RNA barcode set" =>
    { code_position => "3-prime",
      codes => {
        A => 'TACCT',
        B => 'TACGA',
        C => 'TAGCA',
        D => 'TAGGT',
        E => 'TCAAG',
        F => 'TCATC',
        G => 'TCTAC',
        H => 'TCTTG',
        I => 'TGAAC',
        J => 'TGTTG',
        K => 'TGTTC',
       },
    },
  "Dmitry's barcode set" =>
    { code_position => "5-prime",
      codes => {
        A => 'AAAT',
        B => 'ATCT',
        C => 'AGGT',
        D => 'ACTT',
        E => 'TACT',
        F => 'TTGT',
        G => 'TGTT',
        H => 'TCAT',
        I => 'GAGT',
        J => 'GTTT',
        K => 'GGAT',
        L => 'GCCT',
        M => 'CATT',
        N => 'CTAT',
        O => 'CGCT',
        P => 'CCGT',
       }
     },
  "Natasha's barcode set" =>
    { code_position => "5-prime",
      codes => {
        A => 'CGTGA',
        B => 'GTCGA',
        C => 'AGCGC',
        D => 'TATGA',
        E => 'CACAG',
        F => 'TGCAG',
        G => 'CTCAC',
        H => 'GTCAG',
        I => 'TAGAC',
        J => 'GCGAC',
        K => 'TCGAG',
        L => 'ATGAC',
        M => 'CTGAG',
        N => 'GATAC',
        O => 'TATAG',
        P => 'GCTAG',
        Q => 'AGTAC',
        R => 'CGTAG',
        S => 'ACACG',
        T => 'GCACA',
        U => 'CGACA',
        V => 'TGACG',
        W => 'ATACA',
        X => 'GTACG',
        Y => 'CAGCA',
        Z => 'TAGCG',
        A1 => 'ACGCA',
        B1 => 'GCGCG',
        C1 => 'ATGCG',
        D1 => 'GTGCA',
        E1 => 'GATCG',
        F1 => 'TCTCA',
        G1 => 'AGTCG',
        H1 => 'GCAGC',
        I1 => 'AGAGA',
        J1 => 'CGAGC',
        K1 => 'ATAGC',
        L1 => 'CACGA',
        M1 => 'GACGC',
        N1 => 'TGCGA',
        O1 => 'GCTGA',
        P1 => 'TCTGC',
        Q1 => 'ACATA',
        R1 => 'GCATG',
        S1 => 'AGATC',
        T1 => 'CGATG',
        U1 => 'TGATA',
        V1 => 'ATATG',
        W1 => 'GTATA',
        X1 => 'CACTC',
        Y1 => 'GACTG',
        Z1 => 'AGCTG',
        A2 => 'TGCTC',
        B2 => 'CTCTA',
        C2 => 'GTCTC',
        D2 => 'CAGTG',
        E2 => 'TAGTA',
        F2 => 'ACGTG',
        G2 => 'GCGTA',
        H2 => 'TCGTC',
        I2 => 'ATGTA',
        J2 => 'CTGTC',
        K2 => 'GTGTG',
      }
     },
  "GEX Adaptor barcodes" => {
    code_position => "3-prime",
    codes => {
      '2.1' => 'GACCT',
      '2.2' => 'GACGA',
      '2.3' => 'GAGCA',
      '2.4' => 'GAGGT',
      '2.5' => 'GCAAG',
      '2.6' => 'GCATC',
      '2.7' => 'GCTAC',
      '2.8' => 'GCTTG',
    },
  }
 );

$schema->txn_do(sub {
  my $set_rs = $schema->resultset('BarcodeSet');

  for my $barcode_set_name (sort keys %barcode_sets) {
    my %set_info = %{$barcode_sets{$barcode_set_name}};
    my $barcode_position_string = $set_info{code_position};
    my $position_cvterm_rs = $schema->resultset('Cvterm');
    my $barcode_position =
      $position_cvterm_rs->find({ name => $barcode_position_string });
    my %codes = %{$set_info{codes}};

    my $set = $set_rs->find_or_create({ name => $barcode_set_name,
                                position_in_read => $barcode_position });

    for my $barcode_identifier (sort keys %codes) {
      my $rs = $schema->resultset('Barcode');
      $rs->find_or_create({
        identifier => $barcode_identifier,
        code => $codes{$barcode_identifier},
        barcode_set => $set
       });
    }
  }
});

$schema->txn_commit();

my @orgs = ({ name => "DCB",
              description => 'David Baulcombe Lab, University of Cambridge, Dept. of Plant Sciences' },
            { name => 'CRUK CRI',
              description => 'Cancer Research UK, Cambridge Research Institute' },
            { name => 'Sainsbury',
              description => 'Sainsbury Laboratory' },
            { name => 'JIC',
              description => 'John Innes Centre' },
            { name => 'BGI',
              description => 'Beijing Genomics Institute' },
            { name => 'CSHL',
              description => 'Cold Spring Harbor Laboratory' },
            { name => 'Edinburgh',
              description => 'The University of Edinburgh' },
            { name => 'Unknown',
              description => 'Catch-all organisation for external samples' },
           );

$schema->txn_do(sub {
                  for my $org (@orgs) {
                    $schema->find_or_create_with_type('Organisation', $org);
                  }
                });
my @organisms = ({ genus => "Arabidopsis", species => "thaliana",
                   abbreviation => "arath", common_name => "thale cress" },
                 { genus => "Chlamydomonas", species => "reinhardtii",
                   abbreviation => "chlre", common_name => "chlamy"},
                 { genus => "Cardamine", species => "hirsuta",
                   abbreviation => "", common_name => "Hairy bittercress" },
                 { genus => "Caenorhabditis", species => "elegans",
                   abbreviation => "caeel", common_name => "worm" },
                 { genus => "Dictyostelium", species => "discoideum",
                   abbreviation => "dicdi", common_name => "Slime mold" },
                 { genus => "Cleome", species => "gynandra",
                   abbreviation => "clegy", common_name => "African cabbage" },
                 { genus => "Homo", species => "sapiens",
                   abbreviation => "human", common_name => "human" },
                 { genus => "Mus", species => "musculus",
                   abbreviation => "mouse", common_name => "mouse" },
                 { genus => "Drosophila", species => "melanogaster",
                   abbreviation => "drome", common_name => "fly" },
                 { genus => "Lycopersicon", species => "esculentum",
                   abbreviation => "", common_name => "tomato" },
                 { genus => "Solanum", species => "lycopersicon",
                   abbreviation => "", common_name => "tomato" },
                 { genus => "Zea", species => "mays",
                   abbreviation => "maize", common_name => "corn" },
                 { genus => "Oryza", species => "sativa",
                   abbreviation => "orysa", common_name => "rice" },
                 { genus => "Nicotiana", species => "benthamiana",
                   abbreviation => "nicbe", common_name => "benth" },
                 { genus => "Nicotiana", species => "tabacum",
                   abbreviation => "nicta", common_name => "tabaco" },
                 { genus => "Schizosaccharomyces", species => "pombe",
                   abbreviation => "schpo", common_name => "pombe" },
                 { genus => "Carmovirus", species => "turnip crinkle virus",
                   abbreviation => "tcv", common_name => "tcv" },
                 { genus => "Benyvirus", species => "rice stripe virus",
                   abbreviation => "rsv", common_name => "rsv" },
                 { genus => "Cyperus", species => "luzulae",
                   abbreviation => "rsv", common_name => "rsv" },
                 { genus => "Cyperus", species => "longus",
                   abbreviation => "rsv", common_name => "rsv" },
                 { genus => "Unknown", species => "unknown",
                   abbreviation => "none", common_name => "none" },
                );

my %organism_objects = ();

$schema->txn_do(sub {
                  for my $organism_desc (@organisms) {
                    my $organism_obj = $loader->add_organism($organism_desc);
                    my $key = $organism_obj->genus() . ' ' . $organism_obj->species();
                    $organism_objects{$key} = $organism_obj;
                  }
                });

my @ecotypes = (
    { description => "unspecified", org => "Arabidopsis thaliana" },
    { description => "Col-0 (seed stock: 3541)", org => "Arabidopsis thaliana" },
    { description => "WS", org => "Arabidopsis thaliana" },
    { description => "Ler", org => "Arabidopsis thaliana" },
    { description => "C24 (seed stock: 3539)", org => "Arabidopsis thaliana" },
    { description => "Col-0 (seed stock: 3541) x C24 (seed stock: 3539)",
      org => "Arabidopsis thaliana" },
    { description => "Cvi", org => "Arabidopsis thaliana" },
    { description => "unspecified", org => "Chlamydomonas reinhardtii" },
    { description => "unspecified", org => "Cardamine hirsuta" },
    { description => "unspecified", org => "Caenorhabditis elegans" },
    { description => "unspecified", org => "Dictyostelium discoideum" },
    { description => "unspecified", org => "Cleome gynandra" },
    { description => "unspecified", org => "Homo sapiens" },
    { description => "unspecified", org => "Mus musculus" },
    { description => "unspecified", org => "Drosophila melanogaster" },
    { description => "unspecified", org => "Lycopersicon esculentum" },
    { description => "unspecified", org => "Solanum lycopersicon" },
    { description => "unspecified", org => "Zea mays" },
    { description => "B73", org => "Zea mays" },
    { description => "Mo17", org => "Zea mays" },
    { description => "unspecified", org => "Nicotiana benthamiana" },
    { description => "unspecified", org => "Nicotiana tabacum" },
    { description => "unspecified", org => "Schizosaccharomyces pombe" },
    { description => "unspecified", org => "Oryza sativa" },
    { description => "indica", org => "Oryza sativa" },
    { description => "japonica", org => "Oryza sativa" },
    { description => "unspecified", org => "Carmovirus turnip crinkle virus" },
    { description => "unspecified", org => "Benyvirus rice stripe virus" },
    { description => "unspecified", org => "Unknown unknown" },
    { description => "unspecified", org => "Cyperus luzulae" },
    { description => "unspecified", org => "Cyperus longus" },
   );

my %ecotype_objs = ();

$schema->txn_do(sub {
                  for my $ecotype (@ecotypes) {
                    my $org_obj = $organism_objects{$ecotype->{org}};

                    if (!defined $org_obj) {
                      croak "can't find organism for ", $ecotype->{org}, "\n";
                    }

                    my $obj =
                      $schema->find_or_create_with_type('Ecotype',
                                                {
                                                  description => $ecotype->{description},
                                                  organism => $org_obj,
                                                });
                    my $ecotype_desc =
                      $ecotype->{description} . ' ' . $ecotype->{org};
                    $ecotype_objs{$ecotype_desc} = $obj;
                  }
                });

my @tissues = (
    { description => "unspecified", org => "Arabidopsis thaliana" },
    { description => "unopened flowers (stage 0-12)", org => "Arabidopsis thaliana" },
    { description => "open flowers (stage 13)", org => "Arabidopsis thaliana" },
    { description => "young siliques (<7 dpf)", org => "Arabidopsis thaliana" },
    { description => "mature siliques (>7 dpf)", org => "Arabidopsis thaliana" },
    { description => "young leaves (<14 days)", org => "Arabidopsis thaliana" },
    { description => "mature leaves (>14 days)", org => "Arabidopsis thaliana" },
    { description => "vegetative meristem", org => "Arabidopsis thaliana" },
    { description => "floral meristem", org => "Arabidopsis thaliana" },
    { description => "roots (including meristem)", org => "Arabidopsis thaliana" },
    { description => "seedlings (roots, cotyledons, leaves, and meristem)", org => "Arabidopsis thaliana" },
    { description => "cauline leaves", org => "Arabidopsis thaliana" },
    { description => "stem", org => "Arabidopsis thaliana" },

    { description => "unspecified", org => "Chlamydomonas reinhardtii" },
    { description => "vegetative cells", org => "Chlamydomonas reinhardtii" },
    { description => "gametes", org => "Chlamydomonas reinhardtii" },

    { description => "unspecified", org => "Cardamine hirsuta" },
    { description => "unspecified", org => "Caenorhabditis elegans" },
    { description => "unspecified", org => "Dictyostelium discoideum" },
    { description => "unspecified", org => "Homo sapiens" },
    { description => "unspecified", org => "Lycopersicon esculentum" },
    { description => "unspecified", org => "Zea mays" },
    { description => "unspecified", org => "Nicotiana benthamiana" },
    { description => "unspecified", org => "Schizosaccharomyces pombe" },
    { description => "unspecified", org => "Oryza sativa" },
    { description => "unspecified", org => "Carmovirus turnip crinkle virus" },
    { description => "unspecified", org => "Benyvirus rice stripe virus" },
    { description => "unspecified", org => "Unknown unknown" },
   );

my %tissue_objs = ();

$schema->txn_do(sub {
                  for my $tissue (@tissues) {
                    my $org_obj = $organism_objects{$tissue->{org}};

                    if (!defined $org_obj) {
                      croak "can't find organism for ", $tissue->{org}, "\n";
                    }

                    my $obj =
                      $schema->find_or_create_with_type('Tissue',
                                                {
                                                  description => $tissue->{description},
                                                  organism => $org_obj,
                                                });
                    my $tissue_desc =
                      $tissue->{description} . ' ' . $tissue->{org};
                    $tissue_objs{$tissue_desc} = $obj;
                  }
                });

my @people = (
              ['Andy Bassett', 'ab1', 'DCB'],
              ['David Baulcombe', 'david_baulcombe', 'DCB'],
              ['Amy Beeken', 'ab2', 'DCB'],
              ['Donna Bond', 'db2', 'DCB'],
              ['Paola Fedita', 'paola_fedita', 'DCB'],
              ['Susi Heimstaedt', 'susi_heimstaedt', 'DCB'],
              ['Jagger Harvey', 'jagger_harvey', 'DCB'],
              ['Ericka Havecker', 'ericka_havecker', 'DCB'],
              ['Ian Henderson', 'ian_henderson', 'DCB'],
              ['Charles Melnyk', 'cm1', 'DCB'],
              ['Attila Molnar', 'attila_molnar', 'DCB'],
              ['Becky Mosher', 'becky_mosher', 'DCB'],
              ['Kanu Patel', 'kp1', 'DCB'],
              ['Anna Peters', 'anna_peters', 'DCB'],
              ['Kim Rutherford', 'kr1', 'DCB', 'admin'],
              ['Iain Searle', 'iain_searle', 'DCB'],
              ['Padubidri Shivaprasad', 'padubidri_shivaprasad', 'DCB'],
              ['Shuoya Tang', 'shuoya_tang', 'DCB'],
              ['Laura Taylor', 'lt1', 'DCB'],
              ['Craig Thompson', 'cm1', 'DCB'],
              ['Natasha Yelina', 'ne1', 'DCB'],
              ['Krys Kelly', 'krys_kelly', 'DCB'],
              ['Hannes V', 'hannes_v', 'DCB'],
              ['Antonis Giakountis', 'ag1', 'DCB'],
              ['Unknown Unknown', 'unknown', 'Unknown'],
             );

$schema->txn_do(sub {
  my $role_cvterm_rs = $schema->resultset('Cvterm');
  my $admin_role_cvterm = $role_cvterm_rs->find({ name => 'admin' });
  my $local_role_cvterm = $role_cvterm_rs->find({ name => 'local' });

  for my $person (@people) {
    my ($person_name, $username, $organisation_name, $admin) = @$person;

    my $rs = $schema->resultset('Organisation');
    my $organisation = $rs->find({
                                  name => $organisation_name
                                 });

    my $role_cvterm;

    if (defined $admin) {
      $role_cvterm = $admin_role_cvterm;
    } else {
      $role_cvterm = $local_role_cvterm;
    }

    if ($person_name =~ /(.*) (.*)/) {
      $loader->add_person(first_name => $1, last_name => $2,
                          username => $username,
                          password => $username,
                          organisation => $organisation,
                          role => $role_cvterm);
    } else {
      die "no space in name: $person_name\n";
    }
  }
});

my @analyses = (
                {
                 type_term_name => 'sequencing run',
                 detail => 'Sainsbury',
                 inputs => []
                },
                {
                 type_term_name => 'sequencing run',
                 detail => 'CRI',
                 inputs => []
                },
                {
                 type_term_name => 'sequencing run',
                 detail => 'BGI',
                 inputs => []
                },
                {
                 type_term_name => 'sequencing run',
                 detail => 'CSHL',
                 inputs => []
                },
                {
                 type_term_name => 'sequencing run',
                 detail => 'Edinburgh',
                 inputs => []
                },
                {
                 type_term_name => 'sequencing run',
                 detail => 'Unknown',
                 inputs => []
                },
                {
                 type_term_name => 'srf to fastq converter',
                 runable_name => 'SmallRNA::Runable::SRFToFastqRunable',
                 inputs => [
                     {
                       format_type => 'srf',
                       content_type => 'raw_reads'
                     }
                   ]
                },
                {
                 type_term_name => 'trim reads',
                 detail => 'action: remove_adaptors',
                 runable_name => 'SmallRNA::Runable::TrimRunable',
                 inputs => [
                     {
                       biosample_type => 'small_rnas',
                       format_type => 'fastq',
                       content_type => 'raw_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'trim reads',
                 detail => 'action: passthrough',
                 runable_name => 'SmallRNA::Runable::TrimRunable',
                 inputs => [
                     {
                       biosample_type => 'dna_seq',
                       format_type => 'fastq',
                       content_type => 'raw_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'trim reads',
                 detail => 'action: trim',
                 runable_name => 'SmallRNA::Runable::TrimRunable',
                 inputs => [
                     {
                       biosample_type => 'chip_seq',
                       format_type => 'fastq',
                       content_type => 'raw_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'trim reads',
                 detail => 'action: remove_adaptors',
                 runable_name => 'SmallRNA::Runable::TrimRunable',
                 inputs => [
                     {
                       biosample_type => 'sage_expression',
                       format_type => 'fastq',
                       content_type => 'raw_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'trim reads',
                 detail => 'action: passthrough',
                 runable_name => 'SmallRNA::Runable::TrimRunable',
                 inputs => [
                     {
                       biosample_type => 'mrna_expression',
                       format_type => 'fastq',
                       content_type => 'raw_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fastq',
                       content_type => 'raw_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'trimmed_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'filtered_trimmed_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'aligned_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'trim_unknown_barcode',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'trim_rejects',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'trim_n_rejects',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'redundant_aligned_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'redundant_non_aligned_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'calculate fasta or fastq file statistics',
                 runable_name => 'SmallRNA::Runable::FastStatsRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'non_redundant_non_aligned_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'filter sequences by size',
                 runable_name => 'SmallRNA::Runable::SizeFilterRunable',
                 detail => 'min_size: 15',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'trimmed_reads'
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'trim_rejects',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'trimmed_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'filtered_trimmed_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'raw_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'aligned_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'redundant_non_aligned_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'non_redundant_non_aligned_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'summarise fasta first base',
                 runable_name => 'SmallRNA::Runable::FirstBaseCompSummaryRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'redundant_aligned_reads',
                      }
                    ]
                },
                {
                 type_term_name => 'remove redundant reads',
                 runable_name => 'SmallRNA::Runable::NonRedundantFastaRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'filtered_trimmed_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'gff3 index',
                 runable_name => 'SmallRNA::Runable::CreateIndexRunable',
                 inputs => [
                     {
                       format_type => 'gff3',
                       content_type => 'aligned_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'fasta index',
                 runable_name => 'SmallRNA::Runable::CreateIndexRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome-tair9, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome-tair9, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'Col-0 (seed stock: 3541) Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome-tair9, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'C24 (seed stock: 3539) Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome-tair9, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'Col-0 (seed stock: 3541) x C24 (seed stock: 3539) Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: c24-genome, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'C24 (seed stock: 3539) Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'Col-0 (seed stock: 3541) Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'Col-0 (seed stock: 3541) x C24 (seed stock: 3539) Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'C24 (seed stock: 3539) Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: c24-genome, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'Col-0 (seed stock: 3541) x C24 (seed stock: 3539) Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: trna',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: mirbase-hairpin',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: mirbase-mature',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: mirbase-maturestar',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Arabidopsis thaliana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome-old, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Solanum lycopersicon',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Solanum lycopersicon',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: ests, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Solanum lycopersicon',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: concat_ests, ignore_poly_a: yes, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Solanum lycopersicon',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: genome, torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Chlamydomonas reinhardtii',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                {
                 type_term_name => 'patman alignment',
                 detail => 'component: mirbase-mature, target: "Arabidopsis thaliana", torque_flags: -l pmem=5gb',
                 runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                 inputs => [
                     {
                       ecotype_name => 'unspecified Nicotiana benthamiana',
                       format_type => 'fasta',
                       content_type => 'non_redundant_reads',
                     }
                    ]
                },
                # {
                #  type_term_name => 'bwa alignment',
                #  detail => 'component: genome',
                #  runable_name => 'SmallRNA::Runable::BWASearchRunable',
                #  inputs => [
                #      {
                #        ecotype_name => 'unspecified Arabidopsis thaliana',
                #        format_type => 'fasta',
                #        content_type => 'non_redundant_reads',
                #      }
                #     ]
                # },
                # {
                #  type_term_name => 'patman alignment',
                #  detail => 'component: genome, target: "Arabidopsis thaliana", mismatches: 1, torque_flags: -l pmem=20gb',
                #  runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                #  inputs => [
                #      {
                #        ecotype_name => 'unspecified Cleome gynandra',
                #        format_type => 'fasta',
                #        content_type => 'non_redundant_reads',
                #      }
                #     ]
                # },
                # {
                #  type_term_name => 'patman alignment',
                #  detail => 'component: mrna, target: "Arabidopsis thaliana", mismatches: 1, torque_flags: -l pmem=20gb',
                #  runable_name => 'SmallRNA::Runable::PatmanAlignmentRunable',
                #  inputs => [
                #      {
                #        ecotype_name => 'unspecified Cleome gynandra',
                #        format_type => 'fasta',
                #        content_type => 'non_redundant_reads',
                #      }
                #     ]
                # },
                {
                 type_term_name => 'genome aligned reads filter',
                 runable_name => 'SmallRNA::Runable::GenomeMatchingReadsRunable',
                 inputs => [
                     {
                       format_type => 'gff3',
                       content_type => 'aligned_reads'
                     }
                   ]
                },
                {
                 type_term_name => 'gff3 to sam converter',
                 runable_name => 'SmallRNA::Runable::GFF3ToSAMRunable',
                 inputs => [
                     {
                       format_type => 'gff3',
                       content_type => 'aligned_reads'
                     }
                   ]
                },
                {
                 type_term_name => 'gff3 to gff2 converter',
                 runable_name => 'SmallRNA::Runable::GFF3ToGFF2Runable',
                 inputs => [
                     {
                       format_type => 'gff3',
                       content_type => 'aligned_reads'
                     }
                   ]
                },
                {
                 type_term_name => 'sam to bam converter',
                 runable_name => 'SmallRNA::Runable::SAMToBAMRunable',
                 inputs => [
                     {
                       format_type => 'sam',
                       content_type => 'aligned_reads',
                       ecotype_name => 'unspecified Arabidopsis thaliana',
                     }
                   ]
                },
                {
                 type_term_name => 'sam to bam converter',
                 runable_name => 'SmallRNA::Runable::SAMToBAMRunable',
                 inputs => [
                     {
                       format_type => 'sam',
                       content_type => 'aligned_reads',
                       ecotype_name => 'Col-0 (seed stock: 3541) Arabidopsis thaliana',
                     }
                   ]
                },
                {
                 type_term_name => 'sam to bam converter',
                 runable_name => 'SmallRNA::Runable::SAMToBAMRunable',
                 inputs => [
                     {
                       format_type => 'sam',
                       content_type => 'aligned_reads',
                       ecotype_name => 'Col-0 (seed stock: 3541) x C24 (seed stock: 3539) Arabidopsis thaliana',
                     }
                   ]
                },
                {
                 type_term_name => 'sam to bam converter',
                 runable_name => 'SmallRNA::Runable::SAMToBAMRunable',
                 inputs => [
                     {
                       format_type => 'sam',
                       content_type => 'aligned_reads',
                       ecotype_name => 'C24 (seed stock: 3539) Arabidopsis thaliana',
                     }
                   ]
                },
                {
                 type_term_name => 'sam to bam converter',
                 runable_name => 'SmallRNA::Runable::SAMToBAMRunable',
                 inputs => [
                     {
                       format_type => 'sam',
                       content_type => 'aligned_reads',
                       ecotype_name => 'unspecified Solanum lycopersicon',
                     }
                   ]
                },
                {
                 type_term_name => 'sam to bam converter',
                 runable_name => 'SmallRNA::Runable::SAMToBAMRunable',
                 inputs => [
                     {
                       format_type => 'sam',
                       content_type => 'aligned_reads',
                       ecotype_name => 'unspecified Chlamydomonas reinhardtii',
                     }
                   ]
                },
                {
                 type_term_name => 'sam to bam converter',
                 detail => 'target: "Arabidopsis thaliana"',
                 runable_name => 'SmallRNA::Runable::SAMToBAMRunable',
                 inputs => [
                     {
                       format_type => 'sam',
                       content_type => 'aligned_reads',
                       ecotype_name => 'unspecified Cleome gynandra',
                     }
                   ]
                },
                {
                 type_term_name => 'make redundant fasta',
                 runable_name => 'SmallRNA::Runable::MakeRedundantFastaRunable',
                 inputs => [
                     {
                       format_type => 'fasta',
                       content_type => 'non_redundant_non_aligned_reads',
                     }
                    ]
                },
               );

$schema->txn_do(sub {
  my %seen = ();

  for (my $i = 0; $i < @analyses; $i++) {
    my $analysis = $analyses[$i];
    my %conf = %$analysis;

    my $type_cvterm_rs = $schema->resultset('Cvterm');
    my $type_cvterm = $type_cvterm_rs->find({ name => $conf{type_term_name} });

    if (!defined $type_cvterm) {
      die "can't find cvterm for $conf{type_term_name}\n";
    }

    my $process_conf = $schema->find_or_create_with_type('ProcessConf', {
      process_conf_id => $i,
      type => $type_cvterm,
      detail => $conf{detail},
      runable_name => $conf{runable_name},
    });

    my $key = "$type_cvterm " . ($conf{detail} || '') . ' ' .
      ($conf{runable_name} || '') . " inputs:" .
      map {
        ($_->{content_type} || '') . ' ' . ($_->{format_type} || '') .
          ($_->{ecotype_name} || '');
      } @{$conf{inputs}};

    if (exists $seen{$key}) {
      die "already processed process_conf: $key\n";
    } else {
      $seen{$key} = 1;
    }

    for my $input (@{$conf{inputs}}) {
      my %args = (
        process_conf => $process_conf
      );

      if (defined $input->{content_type}) {
        $args{content_type} = _get_cvterm($input->{content_type});
      }

      if (defined $input->{format_type}) {
        $args{format_type} = _get_cvterm($input->{format_type});
      }

      if (defined $input->{ecotype_name}) {
        $args{ecotype} = $ecotype_objs{$input->{ecotype_name}};
      }

      if (defined $input->{biosample_type}) {
        $args{biosample_type} = _get_cvterm($input->{biosample_type});
      }

      $schema->find_or_create_with_type('ProcessConfInput', { %args });
    }
  }
});

my @protocols = (
              ['unknown', ''],
             );

$schema->txn_do(sub {
  for my $protocol (@protocols) {
    my ($name, $description) = @$protocol;
    $schema->find_or_create_with_type('Protocol',
                                {
                                  name => $name,
                                  description => $description,
                                });

  }
});
