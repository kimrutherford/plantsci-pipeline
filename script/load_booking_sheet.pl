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

my $file = shift;

my $csv = Text::CSV->new({binary => 1});

open my $io, '<', $file;

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
  my $project_name = shift;
  my $owner = shift;

  $project_name = 'P_' . $project_name;

  if (!defined $owner) {
    croak "no owner passed to get_project()\n";
  }

  if (!exists $projects{$project_name}) {
    $projects{$project_name} =
      create('Pipeproject', {
                             name => $project_name,
                             description => $project_name,
                             owner => $owner
                           });
  }
  return $projects{$project_name};
}

sub create_sample
{
  my $project = shift;
  my $sample_name = shift;
  my $description = shift;
  my $molecule_type = shift;
  my $ecotypes_ref = shift;
  my @ecotypes = @$ecotypes_ref;
  my $do_processing = shift;
  my $sample_type = shift;

  if (length $sample_type == 0) {
    $sample_type = 'smallRNA';
  }

  my $protocol = find('Protocol', name => 'unknown');
  my $molecule_type_term = find('Cvterm', name => $molecule_type);
  my %sample_type_map = (
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
  my $sample_type_cvterm_name = $sample_type_map{$sample_type};

  if (!defined $sample_type_cvterm_name) {
    croak(qq(can't find cvterm name for "$sample_type" from the spreadsheet));
  }

  my $sample_type_term = find('Cvterm', name => $sample_type_cvterm_name);
  my $processing_type_term = find('Cvterm',
                                  name => ($do_processing ?
                                           'needs processing' :
                                           'no processing'));

  die "can't find term for $molecule_type" unless defined $molecule_type_term;

  my $sample_args = {
                     name => $sample_name,
                     description => $description,
                     molecule_type => $molecule_type_term,
                     processing_requirement => $processing_type_term,
                     protocol => $protocol,
                     sample_type => $sample_type_term
                    };

  my $sample = create('Sample', $sample_args);

  map { $sample->add_to_ecotypes($_); } @ecotypes;
  $sample->add_to_pipeprojects($project);

  return $sample;
}

sub create_coded_sample
{
  my $sample = shift;
  my $sequencing_sample = shift;
  my $is_replicate = shift;
  my $barcode = shift;
  my $adaptor = shift;

  my %coded_sample_args = (
                        sample => $sample,
                        sequencing_sample => $sequencing_sample,
                       );

  if (defined $barcode) {
    $coded_sample_args{barcode} = $barcode;
    $coded_sample_args{description} =
      'barcoded sample for: ' . $sample->name() . ' using barcode: '
        . $barcode->identifier();
  } else {
    $coded_sample_args{description} = 'non-barcoded sample for: ' . $sample->name();
  }

  if ($is_replicate) {
    $coded_sample_args{coded_sample_type} = find('Cvterm',
                                                 name => 'technical replicate');
  } else {
    $coded_sample_args{coded_sample_type} = find('Cvterm',
                                                 name => 'initial run');
  }

  $coded_sample_args{adaptor} = $adaptor;

  return create('CodedSample', {%coded_sample_args});
}

my %file_name_to_sequencingrun = ();

sub run_exists
{
  my $run_identifier = shift;

  my $existing_run =
    $schema->resultset('Sequencingrun')->find({identifier => $run_identifier});

  if (defined $existing_run) {
    return 1;
  } else {
    return 0;
  }
}

# process a file and make a sequencingrun object for it
sub create_sequencing_run
{
  my $run_identifier = shift;
  my $seq_centre_name = shift;
  my $sequencing_sample = shift;
  my $multiplexed = shift;
  my $date_submitted = shift;
  my $date_received = shift;

  my $multiplexing_type_name;

  if ($multiplexed) {
    $multiplexing_type_name = 'multiplexed';
  } else {
    $multiplexing_type_name = 'non-multiplexed';
  }

  my $sequencing_run = $loader->add_sequencingrun(run_identifier => $run_identifier,
                                                  sequencing_centre_name => $seq_centre_name,
                                                  multiplexing_type_name => $multiplexing_type_name,
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

sub create_pipedata
{
  my $sequencing_run = shift;
  my $file_name = shift;
  my $molecule_type = shift;
  my $samples = shift;

  my @samples = @$samples;

  my ($pipedata, $pipeprocess) =
    $loader->add_sequencingrun_pipedata($config, $sequencing_run,
                                        $file_name, $molecule_type);

  $sequencing_run->initial_pipedata($pipedata);
  $sequencing_run->initial_pipeprocess($pipeprocess);

  map { $pipedata->add_to_samples($_); } @samples;

  $sequencing_run->update();

  return $pipedata;
}

sub fix_date
{
  my $date = shift;
  $date =~ s|(\d+)/(\d+)/(0\d)|20$3-$2-${1}T00:00:00|;
  return $date;
}

sub fix_name
{
  my $file_name = shift;
  $file_name =~ s/(?:\.gz)?$//;
  return $file_name;
}

my %dir_files = ();

my @sub_dirs = qw(fastq T1 T2 SL4 SL9 SL11 SL12 SL18 SL19 SL21 SL22 SL1000 SL1001 SL1002 SL1007 SL1008 SL1009 SL1010);

if ($test_mode) {
  unshift @sub_dirs, 'srf';
}

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
      warn "can't find file for $booking_sheet_file_name ($test_file_name)\n";

      $test_file_name =~ s/^SL\d+\.//;

      if (exists $dir_files{$test_file_name}) {
#      warn "found file: ", $dir_files{$test_file_name}, " - $test_file_name\n";
        return $dir_files{$test_file_name};
      } else {
        warn "can't find file for $booking_sheet_file_name ($test_file_name)\n";
        return undef;
      }
    }
  }
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

  return create('SequencingSample', { name => "CRI_$solexa_library_name" });
}

sub process_row
{
    my @columns = @_;

    my $barcodes = undef;

    my ($file_names_column, $solexa_library, 
        $project_desc, $do_processing,
        $dcb_validated, $funding,
        $sheet_seq_centre_name,
        $description, $organism_name, $genotype, 
        $barcode, $barcode_set, $submitter, $institution,
        $date_submitted, $date_received, $time_taken,
        $quality, $quality_note, $smallrna_adaptor, $sample_type, $run_type,
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

    my $ecotype = get_ecotype_by_org($org_obj);

    my @ecotypes = ($ecotype);

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

    # match SL + (_num)? + (_letters)?
    if ($solexa_library =~ /((?:T|SL)\d+)(?:_([A-Z]+))?(?:_(\d+))?/) {
      my $sample_prefix = $1;
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

      $smallrna_adaptor =~ s/^\s+//;
      $smallrna_adaptor =~ s/\s+$//;

      my $adaptor;

      if ($smallrna_adaptor eq 'v1.5') {
        $adaptor = $v1_5_adaptor;
      } else {
        if ($smallrna_adaptor eq '') {
          $adaptor = $old_adaptor;
        } else {
          die "unknown adaptor: $smallrna_adaptor\n";
        }
      }

      my $replicate_identifier = $3;

      my $is_replicate = 0;

      my $molecule_type;

      if ($solexa_library eq 'SL54' || $solexa_library eq 'SL55' ||
          $sample_type eq 'DNA' || $sample_type eq 'ChipSeq' || 
          $sample_type eq 'Expression') {
        $molecule_type = 'DNA';
      } else {
        $molecule_type = 'RNA';
      }

      if (defined $replicate_identifier && $replicate_identifier > 1) {
        $is_replicate = 1;
      }

      my $proj = get_project($solexa_library, $person_obj);

      my $multiplexed;

      if (defined $barcodes) {
        $multiplexed = 1;
      } else {
        $multiplexed = 0;
      }

      for my $file_name (@file_names) {
        if ($file_name =~ /unusable/) {
          warn "skipping: $file_name\n";
          return;
        }

        $file_name =~ s/\s+$//;
        $file_name =~ s/^\s+//;

        if (length $file_name == 0) {
          return;
        }

        $file_name = find_real_file_name($config, $file_name);

        if (!defined $file_name) {
          return;
        }

        die "$file_name\n" unless -e $config->data_directory() . '/' . $file_name;

        my $seq_centre_name;

        if ($sheet_seq_centre_name eq 'CRI' || $sheet_seq_centre_name eq 'Sirocco') {
          $seq_centre_name = 'CRUK CRI';
        } else {
          if ($sheet_seq_centre_name eq 'Norwich') {
            $seq_centre_name = 'Sainsbury';
          } else {
            if ($sheet_seq_centre_name eq 'BGI' ||
                $sheet_seq_centre_name eq 'CSHL' ||
                $sheet_seq_centre_name eq 'Edinburgh') {
              $seq_centre_name = $sheet_seq_centre_name;
            } else {
              croak "unknown sequencing centre name: $sheet_seq_centre_name\n";
            }
          }
        }

        my $sequencing_run_identifier = 'RUN_' . $solexa_library;

        if (run_exists($sequencing_run_identifier)) {
          warn "a sequencingrun entry exists for $solexa_library - skipping\n";
          return;
        }

        my $sequencing_sample = create_sequencing_sample($solexa_library);

        my @all_samples = ();

        if ($multiplexed) {
          my @barcode_identifiers = ($barcodes =~ /(\w)/g);
          for my $barcode_identifier (@barcode_identifiers) {
            my $barcode_set_name;

            if ($solexa_library =~ /^(SL28[345])/) {
              $barcode_set_name = "Dmitry's barcode set";
            } else {
              if ($solexa_library =~ /^(SL322)/) {
                $barcode_set_name = "Natasha's barcode set";
              } else {
                $barcode_set_name = "DCB small RNA barcode set";
              }
            }

            my $barcode_set = find('BarcodeSet', name => $barcode_set_name);
            my $barcode = find('Barcode', 
                               {
                                 identifier => $barcode_identifier,
                                 barcode_set => $barcode_set
                               }
                              );

            my $new_sample_name = $sample_prefix . '_' . $barcode_identifier;

            if (defined $replicate_identifier) {
              $new_sample_name .=  '_' . $replicate_identifier;
            }

            my $desc_with_barcode =
              $description . ' - barcode ' . $barcode->identifier();

            my $sample = create_sample($proj, $new_sample_name,
                                       $desc_with_barcode, $molecule_type,
                                       [@ecotypes], $do_processing, $sample_type);

            push @all_samples, $sample;
            create_coded_sample($sample, $sequencing_sample, $is_replicate, $barcode, $adaptor);
          }
        } else {
          my $sample_name = $sample_prefix;

          if (defined $replicate_identifier) {
            $sample_name .= '_' . $replicate_identifier;
          }

          my $sample = create_sample($proj, $sample_name, $description,
                                     $molecule_type,
                                     [@ecotypes], $do_processing, $sample_type);
          push @all_samples, $sample;
          create_coded_sample($sample, $sequencing_sample, $is_replicate, undef, $adaptor);
        }

        my $sequencing_run =
          create_sequencing_run($sequencing_run_identifier, $seq_centre_name,
                                $sequencing_sample, $multiplexed,
                                $date_submitted, $date_received);

        my $pipedata = create_pipedata($sequencing_run, $file_name, $molecule_type,
                                       \@all_samples);

        $pipedata->update();

        my $pipeprocess = $pipedata->generating_pipeprocess();

        my $samples_str = join ', ', map { $_->name() } @all_samples;

        my $new_description =
          $pipeprocess->description() . ' for: ' . $samples_str;
        $pipeprocess->description($new_description);
        $pipeprocess->update();
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
