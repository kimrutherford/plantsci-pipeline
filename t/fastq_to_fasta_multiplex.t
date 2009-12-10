use strict;
use warnings;
use Test::More tests => 8;
use File::Temp qw(tempdir);

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::TrimProcess';
  use_ok 'SmallRNA::Runable::TrimRunable';
}

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNATest;

my $in_fastq_file = 't/data/SL234_BCF.090202.30W8NAAXX.s_1.fq';

my $tempdir = tempdir("/tmp/remove_adaptors_test_$$.XXXXX", CLEANUP => 0);

my $config = SmallRNA::Config->new('t/test_config.yaml');
my $schema = SmallRNA::DB->schema($config);
SmallRNATest::setup($schema, $config);

my %barcodes_map =
  SmallRNA::Runable::TrimRunable::_get_barcodes($schema,
                                                        'DCB small RNA barcode set');

my ($reject_file_name, $n_reject_file_name, $fasta_file_name, $output) =
  SmallRNA::Process::TrimProcess::run(
    output_dir_name => $tempdir,
    input_file_name => $in_fastq_file,
    processing_type => 'remove_adaptors',
    barcodes => \%barcodes_map,
    barcode_position => '3-prime'
  );

ok(-s "$tempdir/$reject_file_name", "looking for $tempdir/$reject_file_name");
ok(-f "$tempdir/$n_reject_file_name", "looking for $tempdir/$n_reject_file_name");

is(scalar(keys %$output), 3, 'two output files');

ok($output->{TACGA} eq 'SL234_BCF.090202.30W8NAAXX.s_1.B.fasta');
ok($output->{TAGCA} eq 'SL234_BCF.090202.30W8NAAXX.s_1.C.fasta');
ok($output->{TACCT} eq 'SL234_BCF.090202.30W8NAAXX.s_1.A.fasta');
