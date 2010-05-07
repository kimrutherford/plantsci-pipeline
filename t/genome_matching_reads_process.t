use strict;
use warnings;
use Test::More tests => 4;

use File::Temp qw(tempdir);
use File::Compare;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::GenomeMatchingReadsProcess';
}

my $input_gff3_file_name = 't/data/patman_alignment_results.gff3';

my $tempdir = tempdir("/tmp/genome_matching_reads_process_$$.XXXXX", CLEANUP => 0);

my $fasta_output_file_name = "$tempdir/out.fasta";
my $redundant_fasta_output_file_name = "$tempdir/redundant.fasta";
my $tsv_output_file_name = "$tempdir/out.tsv";

SmallRNA::Process::GenomeMatchingReadsProcess::run(
  input_gff3_file_name => $input_gff3_file_name,
  fasta_output_file_name => $fasta_output_file_name,
  redundant_fasta_output_file_name => $redundant_fasta_output_file_name,
  tsv_output_file_name => $tsv_output_file_name,
);

ok(-s $fasta_output_file_name, 'output file size');
ok(compare($fasta_output_file_name, "t/data/genome_matching_reads_process_out.fasta") == 0);
ok(compare($redundant_fasta_output_file_name, "t/data/genome_matching_reads_process_redundant_out.fasta") == 0);

