use strict;
use warnings;
use Test::More tests => 3;
use File::Temp qw(tempfile);
use Test::Files;

use YAML;

use SmallRNA::Config;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::PatmanAlignmentProcess';
}

my $input_file_name = 't/data/reads_fasta_summary_test.fasta';
my $db_file_name = 't/data/arabidopsis_thaliana_test_genome.fasta';

my ($gff_fh, $output_gff_file_name) =
  tempfile('/tmp/patman_alignment_test_gff.XXXXXX', UNLINK => 0);

my $config = SmallRNA::Config->new('t/test_config.yaml')->{programs}{patman};

my $res = SmallRNA::Process::PatmanAlignmentProcess::run(
  executable_path => $config->{path},
  database_file_name => $db_file_name,
  input_file_name => $input_file_name,
  gff_source_name => 'test_source',
  output_gff_file_name => $output_gff_file_name,
);

ok(-s $output_gff_file_name, 'has gff output');

compare_ok($output_gff_file_name, "t/data/patman_alignment_results.gff3",
           'gff results comparison');
