use strict;
use warnings;
use Test::More tests => 13;
use File::Temp qw(tempdir);

use Test::Files;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::TrimProcess';
  use_ok 'SmallRNA::Runable::TrimRunable';
}

use SmallRNA::Config;
use SmallRNA::DB;
use SmallRNATest;

my $in_fastq_file = 't/data/SL283_H3.090805.42L0HAAXX.s_3.fq';

my $tempdir = tempdir("/tmp/remove_adaptors_test_$$.XXXXX", CLEANUP => 0);

my $config = SmallRNA::Config->new('t/test_config.yaml');
my $schema = SmallRNA::DB->new($config);
SmallRNATest::setup($schema, $config);

my %barcodes_map =
  SmallRNA::Runable::TrimRunable::_get_barcodes($schema,
                                                        "Dmitry's barcode set");

my ($reject_file_name, $n_reject_file_name, $fasta_file_name, $output,
    $output_fastq) =
  SmallRNA::Process::TrimProcess::run(
    output_dir_name => $tempdir,
    input_file_name => $in_fastq_file,
    processing_type => 'passthrough',
    adaptor_sequence => 'TCGTATGCCGTCTTCTGCTTGT',
    barcodes => \%barcodes_map,
    barcode_position => '5-prime',
    create_fastq => 1
  );

ok(-s "$tempdir/$reject_file_name");

is(scalar(keys %$output), 2, 'two output files');

is($output->{ATCT}, 'SL283_H3.090805.42L0HAAXX.s_3.B.fasta');

is($output_fastq->{ATCT}, 'SL283_H3.090805.42L0HAAXX.s_3.B.fastq');
is($output_fastq->{CTAT}, 'SL283_H3.090805.42L0HAAXX.s_3.N.fastq');

for my $fastq_filename (values %$output_fastq) {
  ok(-s "$tempdir/$fastq_filename");
}


compare_ok($tempdir . '/' . $output->{ATCT}, "t/data/fastq_to_fasta_multiplex_5_prime_results/SL283_H3.090805.42L0HAAXX.s_3.B.fasta");
compare_ok($tempdir . '/' . $output->{CTAT}, "t/data/fastq_to_fasta_multiplex_5_prime_results/SL283_H3.090805.42L0HAAXX.s_3.N.fasta");
compare_ok($tempdir . '/' . $output_fastq->{ATCT}, "t/data/fastq_to_fasta_multiplex_5_prime_results/SL283_H3.090805.42L0HAAXX.s_3.B.fastq");
compare_ok($tempdir . '/' . $output_fastq->{CTAT}, "t/data/fastq_to_fasta_multiplex_5_prime_results/SL283_H3.090805.42L0HAAXX.s_3.N.fastq");

