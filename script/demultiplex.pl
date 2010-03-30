#!/usr/bin/perl

use lib '/applications/pipeline/svn_trunk/lib';

use strict;
use warnings;

use File::Temp qw(tempdir);
use SmallRNA::Process::TrimProcess;

my $in_fastq_file = shift;

my %barcodes_map = (
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
);

SmallRNA::Process::TrimProcess::run(
  output_dir_name => '.',
  input_file_name => $in_fastq_file,
  processing_type => 'remove_adaptors',
  adaptor_sequence => 'TCGTATGCCGTCTTCTGCTTGT',
  barcodes => \%barcodes_map,
  barcode_position => '3-prime'
);

