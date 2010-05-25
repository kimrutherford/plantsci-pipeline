#!/usr/bin/perl -w

# script to load the Solexa booking sheet into the tracking database

use strict;

use warnings;
use Text::CSV;
use IO::All;
use Carp;
use DateTime;

use SmallRNA::DB;
use SmallRNA::DBLayer::Loader;
use SmallRNA::Config;

my $test_mode = 0;

if ($ARGV[0] eq '-test') {
  $test_mode = 1;
  shift;
}

my $config_file_name = shift;
my $config = SmallRNA::Config->new($config_file_name);

my $spreadsheet_file = shift;

my $slx_sl_mapping_file_name = shift;

my %sl_to_slx = ();

my %used_sl_slx_ids = ();

open my $slx_sl_mapping_file, '<', $slx_sl_mapping_file_name or
  die "can't open $slx_sl_mapping_file_name: $!\n";

while (defined (my $line = <$slx_sl_mapping_file>)) {
  if ($line =~ /(SL\S+)\s+(\S+)/) {
    $sl_to_slx{$1} = $2;
  } else {
    die "can't parse: $line\n";
  }
}

close $slx_sl_mapping_file or die;

my $csv = Text::CSV->new({binary => 1});

open my $io, '<', $spreadsheet_file;

my $schema = SmallRNA::DB->new($config);

$csv->column_names ($csv->getline($io));

my $loader = SmallRNA::DBLayer::Loader->new(schema => $schema);

my %org_objs = ();

sub add_organism
{
  my $genus = shift;
  my $species = shift;
  my $org = shift;

  my $genus_initial = substr $genus, 0, 1;
  my $fullname = "$genus $species";

  $org_objs{"${genus}_$species}"} = $org;
  $org_objs{$fullname} = $org;
  $org_objs{"${genus_initial}_$species}"} = $org;
  $org_objs{"$genus_initial. $species"} = $org;
  $org_objs{"$genus_initial $species"} = $org;
  $org_objs{"$genus_initial.$species"} = $org;

  if ($fullname eq 'Schizosaccharomyces pombe') {
    $org_objs{"Pombe"} = $org;
  }
  if ($fullname eq 'Zea mays') {
    $org_objs{"Zea maize"} = $org;
  }
  if ($fullname eq 'Homo sapiens') {
    $org_objs{"H. Sapiens"} = $org;
    $org_objs{"Homo Sapiens"} = $org;
  }
  if ($fullname eq 'Unknown unknown') {
    $org_objs{''} = $org;
  }
  if ($fullname eq 'Carmovirus turnip crinkle virus') {
    $org_objs{'TCV'} = $org;
  }
  if ($fullname eq 'Benyvirus rice stripe virus') {
    $org_objs{'RSV'} = $org;
  }
}

my $org_rs = $schema->resultset('Organism')->search();

while (my $org = $org_rs->next) {
  my $genus = $org->genus();
  my $species = $org->species();

  add_organism($genus, $species, $org);

  if ($genus eq 'Arabidopsis') {
    add_organism('Arabidosis', $species, $org);
  }
}

my %person_objs = ();

my $person_rs = $schema->resultset('Person')->search();

sub add_person_to_hash
{
  my $first_name = shift;
  my $last_name = shift;
  my $person_obj = shift;

  my $last_name_initial = substr $last_name, 0, 1;

  $person_objs{"$first_name $last_name"} = $person_obj;
  $person_objs{"$first_name $last_name_initial"} = $person_obj;
}


while (my $person = $person_rs->next) {
  my $first_name = $person->first_name();
  my $last_name = $person->last_name();

  add_person_to_hash($first_name, $last_name, $person);

  if ($first_name eq 'Padubidri') {
    add_person_to_hash('Shiva', 'P', $person);
  }
  if ($first_name eq 'Andy') {
    add_person_to_hash('Andrew', $last_name, $person);
  }
  if ($first_name eq 'Natasha') {
    $person_objs{Natasha} = $person;
  }
}

my %projects = ();

sub create
{
  my $type = shift;
  my $args = shift;

  return $schema->create_with_type($type, $args);
}

sub find
{
  my $obj = $schema->find_with_type(@_);
  if (defined $obj) {
    return $obj;
  } else {
    warn "couldn't find $_[0]\n";
  }
}

sub get_project
{
  my $solexa_library_name = shift;
  my $project_desc = shift;
  my $owner = shift;

  if (!$project_name) {
    $project_name = 'P_' . $solexa_library_name;
  }

  if (!defined $owner) {
    croak "no owner passed to get_project()\n";
  }

  if (!exists $projects{$project_desc}) {
    $projects{$project_name} =
      create('Pipeproject', {
                             identifier => $project_name,
                             description => '',
                             owner => $owner
                           });
  }
  return $projects{$project_name};
}

sub create_biosample
{
  my $project = shift;
  my $biosample_name = shift;
  my $description = shift;
  my $molecule_type = shift;
  my $ecotypes_ref = shift;
  my @ecotypes = @$ecotypes_ref;
  my $do_processing = shift;
  my $biosample_type = shift;

  if (length $biosample_type == 0) {
    $biosample_type = 'smallRNA';
  }

  my $protocol = find('Protocol', name => 'unknown');
  my $molecule_type_term = find('Cvterm', name => $molecule_type);
  my %biosample_type_map = (
    smallRNA => 'small_rnas',
    Sequenced => 'small_rnas',
    sequenced => 'small_rnas',
    'manually sequencing' => 'small_rnas',
    'Very good' => 'small_rnas',
    queued => 'small_rnas',
    Expression => 'mrna_expression',
    'SAGE Expression' => 'sage_expression',
    DNA => 'dna_seq',
    ChipSeq => 'chip_seq'
  );
  my $biosample_type_cvterm_name = $biosample_type_map{$biosample_type};

  if (!defined $biosample_type_cvterm_name) {
    croak(qq(can't find cvterm name for "$biosample_type" from the spreadsheet));
  }

  my $biosample_type_term = find('Cvterm', name => $biosample_type_cvterm_name);
  my $processing_type_term = find('Cvterm',
                                  name => ($do_processing ?
                                           'needs processing' :
                                           'no processing'));

  die "can't find term for $molecule_type" unless defined $molecule_type_term;

  my $biosample_args = {
                     name => $biosample_name,
                     description => $description,
                     molecule_type => $molecule_type_term,
                     processing_requirement => $processing_type_term,
                     protocol => $protocol,
                     biosample_type => $biosample_type_term
                    };

  my $biosample = create('Biosample', $biosample_args);

  map { $biosample->add_to_ecotypes($_); } @ecotypes;
  $biosample->add_to_pipeprojects($project);

  return $biosample;
}

sub create_library
{
  my $biosample = shift;
  my $sequencing_sample = shift;
  my $is_replicate = shift;
  my $barcode = shift;
  my $adaptor = shift;

  my %library_args = (
                      biosample => $biosample,
                      sequencing_sample => $sequencing_sample,
                     );

  if (defined $barcode) {
    $library_args{barcode} = $barcode;
    $library_args{description} =
      'barcoded library for: ' . $biosample->name() . ' using barcode: '
        . $barcode->identifier();
  } else {
    $library_args{description} = 'non-barcoded library for: ' . $biosample->name();
  }

  if ($is_replicate) {
    $library_args{library_type} = find('Cvterm',
                                       name => 'technical replicate');
  } else {
    $library_args{library_type} = find('Cvterm',
                                       name => 'initial run');
  }

  $library_args{adaptor} = $adaptor;

  my $slx_identifier = $sl_to_slx{$biosample->name()};

  $used_sl_slx_ids{$biosample->name()} = 1;

  my $library_name = $biosample->name() . '_L1';

  $library_args{identifier} = $library_name;

  if (defined $slx_identifier) {
    $library_args{sequencing_centre_identifier} = $slx_identifier;
  }

  return create('Library', { %library_args });
}

my %file_name_to_sequencing_run = ();

sub run_exists
{
  my $run_identifier = shift;

  my $existing_run =
    $schema->resultset('SequencingRun')->find({identifier => $run_identifier});

  if (defined $existing_run) {
    return 1;
  } else {
    return 0;
  }
}

sub biosample_exists
{
  my $biosample_name = shift;

  my $existing_sample =
    $schema->resultset('Biosample')->find({name => $biosample_name});

  return defined $existing_sample;
}

# process a file and make a sequencing_run object for it
sub create_sequencing_run
{
  my $run_identifier = shift;
  my $seq_centre_name = shift;
  my $sequencing_sample = shift;
  my $date_submitted = shift;
  my $date_received = shift;

  my $sequencing_run = $loader->add_sequencing_run(run_identifier => $run_identifier,
                                                  sequencing_centre_name => $seq_centre_name,
                                                  sequencing_sample => $sequencing_sample,
                                                  sequencing_type_name => 'Illumina');

  if (defined $date_submitted && length $date_submitted > 0) {
    $sequencing_run->submission_date($date_submitted);
  }
  if (defined $date_received && length $date_received > 0) {
    $sequencing_run->run_date($date_received);
    $sequencing_run->data_received_date($date_received);
  }
  $sequencing_run->update();

  return $sequencing_run;
}

sub fix_date
{
  my $date = shift;
  if ($date =~ s|(\d+)/(\d+)/(0\d)|20$3-$2-${1}T00:00:00|) {
    return $date;
  } else {
    return undef;
  }
}

sub fix_name
{
  my $file_name = shift;
  $file_name =~ s/(?:\.gz)?$//;
  return $file_name;
}

my %dir_files = ();

my @sub_dirs = qw(srf fasta fastq T1 T2 SL4 SL9 SL11 SL12 SL18 SL19 SL21 SL22 SL1000 SL1001 SL1002 SL1007 SL1008 SL1009 SL1010);

for my $sub_dir (@sub_dirs) {
  my $dir_name = $config->data_directory() . "/$sub_dir";
  opendir my $dir, $dir_name or die "can't open directory $dir_name: $!\n";
  while (my $ent = readdir $dir) {
    next if $ent eq '.' or $ent eq '..' or $ent !~ /\.f[qa]$|\.fasta$|\.srf$/;
    $dir_files{$ent} = "$sub_dir/$ent";
  }
  closedir $dir;
}

sub find_real_file_name
{
  my $config = shift;
  my $booking_sheet_file_name = shift;

  if (length $booking_sheet_file_name == 0) {
    return;
  }

  if ($test_mode && $booking_sheet_file_name =~ /SL136.080901.30677AAXX.s_3/) {
    $booking_sheet_file_name = 'SL136.080807.306AKAAXX.s_2.srf';
  }

  if (exists $dir_files{$booking_sheet_file_name}) {
#    warn "found file: $booking_sheet_file_name\n";
    return $dir_files{$booking_sheet_file_name};
  } else {
    my $test_file_name = fix_name($booking_sheet_file_name);

    $test_file_name =~ s/\.reads\.\d+_\d+_\d+//;
    $test_file_name =~ s/\.fa$/.fq/;

    if (exists $dir_files{$test_file_name}) {
#      warn "found file: ", $dir_files{$test_file_name}, " - $test_file_name\n";
      return $dir_files{$test_file_name};
    } else {
#      warn "can't find file for $booking_sheet_file_name ($test_file_name)\n";

      $test_file_name =~ s/^SL\d+\.//;

      if (exists $dir_files{$test_file_name}) {
#      warn "found file: ", $dir_files{$test_file_name}, " - $test_file_name\n";
        return $dir_files{$test_file_name};
      } else {
        $test_file_name = fix_name($booking_sheet_file_name);
        $test_file_name =~ s/\.srf/.fq/;

        if (exists $dir_files{$test_file_name}) {
#          warn "found file: ", $dir_files{$test_file_name}, " - $test_file_name\n";
          return $dir_files{$test_file_name};
        } else {
          $test_file_name = fix_name($booking_sheet_file_name);
          $test_file_name =~ s/\.archive.srf/.sequence.txt.fq/;

          if (exists $dir_files{$test_file_name}) {
            #          warn "found file: ", $dir_files{$test_file_name}, " - $test_file_name\n";
            return $dir_files{$test_file_name};
          } else {
            warn "can't find file for $booking_sheet_file_name\n";
            return undef;
          }
        }
      }
    }
  }
}

sub get_ecotype_object
{
  my $org_obj = shift;
  my $ecotype_name = shift;

  my $ecotype = $schema->resultset('Ecotype')->find(
      {
        organism => $org_obj->organism_id(),
        description => $ecotype_name
      }
    );

  if (!defined $ecotype) {
    croak("failed to find ecotype for $ecotype_name in ",
          $org_obj->full_name());
  }

  return $ecotype;
}

sub get_ecotype_by_org
{
  my $org_obj = shift;

  my $rs = $schema->resultset('Ecotype')->search(
      {
        organism => $org_obj->organism_id(),
        description => 'unspecified'
      }
    );

  if ($rs->count() != 1) {
    croak("failed to find ecotype for organism: ", $org_obj->genus(), ' ',
          $org_obj->species());
  }

  return $rs->next();
}

sub create_sequencing_sample
{
  my $solexa_library_name = shift;
  my $sample_creator = shift;

  my $slx_number = $sl_to_slx{$solexa_library_name};

  $used_sl_slx_ids{$solexa_library_name} = 1;

  return create('SequencingSample', { identifier => "CRI_$solexa_library_name",
                                      sequencing_centre_identifier => $slx_number,
                                      sample_creator => $sample_creator });
}

my %becky_hack_seq_samples = ();

sub process_row
{
    my @columns = @_;

    my $barcodes = undef;

    my ($file_names_column, $solexa_library,
        $project_desc, $do_processing,
        $dcb_validated, $funding,
        $sheet_seq_centre_name,
        $description, $organism_name, $ecotype_name, $genotype,
        $barcode, $barcode_set, $submitter, $institution,
        $date_submitted, $date_received, $time_taken,
        $quality, $quality_note, $smallrna_adaptor, $biosample_type, $run_type,
        $require_number_of_reads, $sample_concentration) = @columns;

    $date_submitted = fix_date($date_submitted);
    $date_received = fix_date($date_received);

    if (lc $do_processing eq 'no') {
      $do_processing = 0;
    } else {
      $do_processing = 1;
    }

    my $virus_name = undef;

    if ($organism_name =~ s{/(TCV|RSV)$}{}) {
      $virus_name = $1;
    }

    if ($solexa_library !~ /SL136|SL11$|SL234_BCF|SL236|SL5[45]|SL165_1|SL285/ && $test_mode) {
      return;
    }

    if ($solexa_library =~ /SL34[3456789]/) {
      # ugly special case - there is a row for each library, so just use the first
      return;
    }

    if ($solexa_library =~ /SL37[2345678]/) {
      # ugly special case - there is a row for each library, so just use the first
      return;
    }

    my @file_names = split m|/|, $file_names_column;

    @file_names = grep { ! /^failed/i } @file_names;
    map {
      s/\((.*)\)//; s/^\s+//; s/[\xff\s]+$//;;
    } @file_names;

    my $org_obj = $org_objs{$organism_name};

    if (!defined $org_obj) {
      warn "unknown organism: '$organism_name' from line: @columns\n";
      return;
    }

    my $ecotype_obj;

    if ($ecotype_name) {
      $ecotype_obj = get_ecotype_object($org_obj, $ecotype_name);
    } else {
      $ecotype_obj = get_ecotype_by_org($org_obj);
    }

    my @ecotypes = ($ecotype_obj);

    if (defined $virus_name) {
      my $virus_obj = $org_objs{$virus_name};
      push @ecotypes, get_ecotype_by_org($virus_obj);
    }

    my $person_obj = $person_objs{$submitter};

    if (!defined $person_obj) {
      warn qq{ignoring row - unknown submitter "$submitter" for '@file_names'\n};
      return;
    }

    my $old_adaptor = find('Cvterm', name => 'illumina old adaptor');
    my $v1_5_adaptor = find('Cvterm', name => 'illumina v1.5 adaptor');
    my $gex_adaptor = find('Cvterm', name => 'GEX adaptor');

    # match SL + (_num)? + (_letters)?
    if ($solexa_library =~ /((?:T|SL|GSM)\d+)(?:_([A-Z]+))?(?:_(\d+))?/) {
      my $biosample_prefix = $1;
      if (defined $barcodes) {
        croak "barcodes set in the library name ($solexa_library) and in the "
          . "spreadsheet barcodes column ($barcodes)\n";
      } else {
        $barcodes = $2;
      }

      if ($solexa_library eq 'SL247') {
        $barcodes = 'AC';
      }

      if ($solexa_library eq 'SL248') {
        $barcodes = 'BD';
      }

      if ($solexa_library =~ /^(SL25[12])/) {
        $barcodes = 'ACDEFGH';
      }

      if ($solexa_library eq 'SL253') {
        $barcodes = 'ABCDFG';
      }

      if ($solexa_library =~ /^(SL28[345])/) {
        $barcodes = 'B';
      }

      if ($solexa_library =~ /SL381/) {
        $barcodes = 'AC';
      }

      if ($solexa_library =~ /SL382/) {
        $barcodes = 'HBG';
      }

      if ($solexa_library =~ /SL383/) {
        $barcodes = 'FDE';
      }

      my %sl342_codes = ();
      if ($solexa_library eq 'SL342') {
        my @codes = qw(2.1 2.8 2.2 2.7 2.3 2.6 2.4 2.5);
        $barcodes = join ' ', @codes;
        for (my $i = 0; $i < 8; $i++) {
          $sl342_codes{$codes[$i]} = 'SL34' . (2 + $i);
        }
      }

      my %sl371_codes = ();
      if ($solexa_library eq 'SL371') {
        my @codes = qw(2.5 2.4 2.6 2.3 2.7 2.2 2.8 2.1);
        $barcodes = join ' ', @codes;
        for (my $i = 0; $i < 8; $i++) {
          $sl371_codes{$codes[$i]} = 'SL37' . (1 + $i);
        }
      }

      $smallrna_adaptor =~ s/^\s+//;
      $smallrna_adaptor =~ s/\s+$//;

      my $adaptor;

      if ($smallrna_adaptor eq 'v1.5') {
        $adaptor = $v1_5_adaptor;
      } else {
        if ($smallrna_adaptor eq '') {
          $adaptor = $old_adaptor;
        } else {
          if ($smallrna_adaptor eq 'GEX') {
            $adaptor = $gex_adaptor;
          } else {
            die "unknown adaptor: $smallrna_adaptor\n";
          }
        }
      }

      my $replicate_identifier = $3;

      my $is_replicate = 0;

      my $molecule_type;

      if ($solexa_library eq 'SL54' || $solexa_library eq 'SL55' ||
          $biosample_type eq 'DNA' || $biosample_type eq 'ChipSeq' ||
          $biosample_type eq 'Expression') {
        $molecule_type = 'DNA';
      } else {
        $molecule_type = 'RNA';
      }

      if (defined $replicate_identifier && $replicate_identifier > 1) {
        $is_replicate = 1;
      }

      my $proj = get_project($solexa_library, $project_desc, $person_obj);

      my $multiplexed;

      if (defined $barcodes) {
        $multiplexed = 1;
      } else {
        $multiplexed = 0;
      }

      if (@file_names == 0) {
        push @file_names, '';
      }

      my $biosample = undef;
      my $sequencing_sample = undef;

      for my $file_name (@file_names) {
        $file_name =~ s/\s+$//;
        $file_name =~ s/^\s+//;

        $file_name = find_real_file_name($config, $file_name);

        my $sequencing_run_identifier;

        if (defined $file_name && $file_name =~ /\.(CRIRUN_\d+)\./) {
          $sequencing_run_identifier = $1 . '_' . $solexa_library;
        } else {
          $sequencing_run_identifier = 'RUN_' . $solexa_library;
        }

        if (run_exists($sequencing_run_identifier)) {
          warn "a sequencing_run entry exists for $solexa_library - skipping\n";
          return;
        }

        if (biosample_exists($solexa_library)) {
          warn "a biosample exists for $solexa_library - skipping\n";
          return;
        }

        my @all_biosamples = ();

        if ($multiplexed) {
          my @barcode_identifiers;

          if ($solexa_library =~ /SL38[123]_([A-Z])/) {
            @barcode_identifiers = $1;
          } else {
            if ($barcodes =~ /2.\d /) {
              @barcode_identifiers = ($barcodes =~ /(2\.\d)/g);
            } else {
              @barcode_identifiers = ($barcodes =~ /(\w)/g);
            }
          }

          for my $barcode_identifier (@barcode_identifiers) {
            my $barcode_set_name;

            if ($solexa_library =~ /^(SL28[345])/) {
              $barcode_set_name = "Dmitry's barcode set";
            } else {
              if ($solexa_library =~ /^(SL322)/) {
                $barcode_set_name = "Natasha's barcode set";
              } else {
                if ($solexa_library eq 'SL342' || $solexa_library eq 'SL371') {
                  $barcode_set_name = "GEX Adaptor barcodes";
                } else {
                  $barcode_set_name = "DCB small RNA barcode set";
                }
              }
            }

            my $barcode_set = find('BarcodeSet', name => $barcode_set_name);
            my $barcode = find('Barcode',
                               {
                                 identifier => $barcode_identifier,
                                 barcode_set => $barcode_set
                               }
                              );

            my $new_biosample_name = $biosample_prefix . '_' . $barcode_identifier;

            if (defined $replicate_identifier) {
              $new_biosample_name .=  '_' . $replicate_identifier;
            }

            my $desc_with_barcode =
              $description . ' - barcode ' . $barcode->identifier();

            # big hack for Becky's samples
            $new_biosample_name =~ s/SL342_(2\.\d+)/$sl342_codes{$1}/e;
            $new_biosample_name =~ s/SL371_(2\.\d+)/$sl371_codes{$1}/e;

            if (biosample_exists($new_biosample_name)) {
              warn "a biosample exists for $new_biosample_name - skipping\n";
              return;
            }

            if (!defined $sequencing_sample) {
              if ($solexa_library =~ /(SL38[123])/) {
                if (exists $becky_hack_seq_samples{$1}) {
                  $sequencing_sample = $becky_hack_seq_samples{$1};
                } else {
                  $sequencing_sample =
                    create_sequencing_sample($1, $person_obj);
                  $becky_hack_seq_samples{$1} = $sequencing_sample;
                }
              } else {
                $sequencing_sample =
                  create_sequencing_sample($solexa_library, $person_obj);
              }
            }

            $biosample =
              create_biosample($proj, $new_biosample_name,
                               $desc_with_barcode, $molecule_type,
                               [@ecotypes], $do_processing, $biosample_type);

            push @all_biosamples, $biosample;

            create_library($biosample, $sequencing_sample,
                           $is_replicate, $barcode, $adaptor);
          }
        } else {
          my $biosample_name = $biosample_prefix;

          if (defined $replicate_identifier) {
            $biosample_name .= '_' . $replicate_identifier;
          }

          my $biosample = create_biosample($proj, $biosample_name, $description,
                                           $molecule_type,
                                           [@ecotypes], $do_processing, $biosample_type);
          push @all_biosamples, $biosample;
          $sequencing_sample =
            create_sequencing_sample($solexa_library, $person_obj);
          create_library($biosample, $sequencing_sample, $is_replicate, undef, $adaptor);
        }

        if (defined $file_name) {
          my $seq_centre_name;

          if ($sheet_seq_centre_name eq 'CRI' || $sheet_seq_centre_name eq 'Sirocco') {
            $seq_centre_name = 'CRUK CRI';
          } else {
            if ($sheet_seq_centre_name eq 'Norwich') {
              $seq_centre_name = 'Sainsbury';
            } else {
              if ($sheet_seq_centre_name eq 'BGI' ||
                    $sheet_seq_centre_name eq 'CSHL' ||
                      $sheet_seq_centre_name eq 'Edinburgh' ||
                        $sheet_seq_centre_name eq 'Unknown') {
                $seq_centre_name = $sheet_seq_centre_name;
              } else {
                croak "unknown sequencing centre name: $sheet_seq_centre_name\n";
              }
            }
          }

          my $sequencing_run =
            create_sequencing_run($sequencing_run_identifier, $seq_centre_name,
                                  $sequencing_sample, $date_submitted, $date_received);

          my $pipedata =
            $loader->create_initial_pipedata($config, $sequencing_run, $file_name,
                                             $molecule_type, \@all_biosamples);

          $pipedata->update();

          my $pipeprocess = $pipedata->generating_pipeprocess();

          my $biosamples_str = join ', ', map { $_->name() } @all_biosamples;

          my $new_description =
            $pipeprocess->description() . ' for: ' . $biosamples_str;
          $pipeprocess->description($new_description);
          $pipeprocess->update();
        }
      }
    } else {
      warn "library identifier doesn't match expected: $solexa_library from line: @columns\n";
    }
}

sub process
{
  while (my $columns_ref = $csv->getline($io)) {
    process_row(@$columns_ref);
  }

  # geo
  opendir DIR, "/data/pipeline/data/fasta/" or die;

  while (defined (my $filename = readdir(DIR))) {
    next if ($filename eq '.' or $filename eq '..');

    (my $geo_id = $filename) =~ s/geo_(.*).txt.fasta/$1/;

    process_row($filename, $geo_id, '', '', 'NO', '', 'Unknown',
                "GEO entry $geo_id", 'Arabidosis thaliana', '',
                '', '', '', 'Unknown Unknown', 'Unknown', '',
                '', '', '', '', '', 'smallRNA', '', '', '');
  }

  closedir(DIR);

}

# test data
process_row('T1.test_data.fasta', 'T1', '', '', 'NO', '', 'CRI', 'Test data', 'Arabidosis thaliana', '', 'Kim Rutherford', 'DCB', '', '', '', '', '', 'smallRNA', '', '', '');
process_row('T2.test_data.fasta', 'T2', '', '', 'NO', '', 'CRI', 'Test data', 'Arabidosis thaliana', '', 'Kim Rutherford', 'DCB', '', '', '', '', '', 'smallRNA', '', '', '');

eval {
  $schema->txn_do(\&process);
};
if ($@) {
  die "ROLLBACK called: $@\n";
}

# print "SL identifiers missing from the spreadsheet:\n";
# for my $sl (sort keys %sl_to_slx) {
#   print "$sl\n" if not exists $used_sl_slx_ids{$sl};
# }
