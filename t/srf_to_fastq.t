use strict;
use warnings;
use Test::More tests => 3;
use File::Temp qw(tempfile);
use Test::Files;

use SmallRNA::Config;

BEGIN {
  unshift @INC, 't';
  use_ok 'SmallRNA::Process::SRFToFastqProcess';
}

my $srf_gz_file_name = 't/data/SL136.080807.306AKAAXX.s_2.srf.bz2';

my ($srf_fh, $temp_srf_file_name) =
  tempfile('/tmp/gff3_to_sam_test.srf.XXXXXX', UNLINK => 0);

system ("bzip2 -d < $srf_gz_file_name > $temp_srf_file_name");

my ($out_fh, $temp_output_file_name) =
  tempfile('/tmp/gff3_to_sam_test.fastq.XXXXXX', UNLINK => 0);

my $config = SmallRNA::Config->new('t/test_config.yaml')->{programs}{srf2fastq};


SmallRNA::Process::SRFToFastqProcess::run(input_file_name => $temp_srf_file_name,
                                          output_file_name => $temp_output_file_name,
                                          exec_path => $config->{path},
                                         );

ok(-s $temp_output_file_name, 'has output');

compare_ok($temp_output_file_name, 't/data/srf_to_fastq_out.fastq');
