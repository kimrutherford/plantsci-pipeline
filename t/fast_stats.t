use strict;
use warnings;
use Test::More tests => 9;
use File::Temp qw(tempfile);
use YAML qw(LoadFile);
use Data::Compare;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::FastStatsProcess';
}

my @inputs = ({ file_name => 't/data/reads_fasta_summary_test.fasta',
                count => 15,
                gc_count => 149,
                expected_file_name => 't/data/expected_fasta_stats.txt'
              },
              { file_name => 't/data/fastfastq.fq',
                count => 9,
                gc_count => 171,
                expected_file_name => 't/data/expected_fastq_stats.txt'
              });

for my $input (@inputs) {
  my $input_file_name = $input->{file_name};

  my ($fh, $output_file_name) =
    tempfile('/tmp/reads_fast_stats_test.XXXXXX', UNLINK => 0);
  my ($fh_n_mer, $n_mer_file_name) =
    tempfile('/tmp/reads_fast_stats_test_n_mer.XXXXXX', UNLINK => 0);

  my $res = SmallRNA::Process::FastStatsProcess::run(
    output_file_name => $output_file_name,
    input_file_name => $input_file_name,
    n_mer_file_name => $n_mer_file_name,
    max_stats_n_mers => 1
  );

  is($res->{'sequence count'}, $input->{count});
  is($res->{'gc content'}, $input->{gc_count});

  my $expected_yaml = LoadFile($input->{expected_file_name});
  my $actual_yaml = LoadFile($output_file_name);

  use Data::Dumper;

#  print Dumper([$expected_yaml, $actual_yaml]);

  ok(Compare($actual_yaml, $expected_yaml), 'compare YAML for ' . $input->{expected_file_name});
  ok(defined $res->{'positional counts'});
}
