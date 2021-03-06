package SmallRNA::Process::TrimProcess;

=head1 NAME

SmallRNA::Process::TrimProcess - Code for removing adaptors and
                                 de-muliplexing fastq sequence

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Process::TrimProcess

You can also look for information at:

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

=cut

use strict;
use Bio::SeqIO;
use Params::Validate qw(:all);
use Carp;

sub _get_file_for_code
{
  my $code_out_files = shift;
  my $output_file_base = shift;
  my $code_from_seq = shift;
  my $barcodes_map_ref = shift;
  my $type = shift;

  for my $code (keys %$barcodes_map_ref) {
    if ($code_from_seq eq $code) {
      if (!exists $code_out_files->{$code}) {
        my $code_name = $barcodes_map_ref->{$code};
        my $new_fasta_file_name = "${output_file_base}.$code_name.$type";

        if (-e $new_fasta_file_name) {
          croak "won't overwrite: $new_fasta_file_name\n";
        }

        my $new_fasta_file;
        open $new_fasta_file, '>', $new_fasta_file_name
          or croak "can't open $new_fasta_file_name for writing: $!\n";
        $code_out_files->{$code} = { name => $new_fasta_file_name,
                                     file => $new_fasta_file};
      }
      return $code_out_files->{$code}{file};
    }
  }

  return undef;
}

sub _trim_quality
{
  my $quality_string = shift;
  my $trimmed_seq = shift;
  my $seq_offset = shift;

  return substr($quality_string, $seq_offset, length($trimmed_seq));
}

=head2 run

 Usage   : my $res = SmallRNA::Process::TrimProcess->run(input_file_name => $input,
                                                         output_dir_name => $out_dir,
                                                         processing_type => $type,
                                                         barcodes => $barcodes_map);
 Function: Remove adaptors and optionally de-multiplex
 Args    : input_file_name - a fastq file name
           output_dir_name - a directory to write output files to
           processing_type - one of 'remove_adaptors', 'trim' or 'passthrough'
                   - 'remove_adaptors' will remove the sequence adaptor
                   - 'trim' will trim reads to 25 bases (by default)
                   - 'passthrough' will do no processing apart from (optional)
                      de-multiplexing, just produce a FASTA file
           trim_bases - the maximum number of bases to output when trimming,
                        default 25
           trim_offset - offset from start of read to start trimming, eg. with
                         trim_bases set to 25 a value of 5 for trim_offset will
                         return bases 5..24 - base numbering starts at 0.
                         If non-zero any 5' barcode will be ignored.
                         default: 0
           barcodes - a map from barcode sequence to barcode id (TACCT => 'A',
                      TACGA => 'B', ...)
           barcode_position - "3-prime" if the barcode is between the sequence
                              and the adaptor, "5-prime" otherwise
           adaptor_sequence - if processing_type is remove_adaptors, this
                              specifies the adaptor sequence to trim
           create_fastq - if the barcodes map is set, this options forcing the
                          creation of a FastQ file for each barcode.  The
                          quality string will be trimmed to match the
                          de-multiplexed sequence
           keep_reads_with_n - if false (0), any read containing a non-ATGC
                               base will be filtered into a separate file, if
                               true they will be kept in the main output file

This method a two modes - multiplexed and non-multiplexed.

If there is no barcodes argument, non-multiplexed is assumed.  In that
mode run() returns an array with four file names as elements.  Each file
name is relative to the directory given by the output_dir_name argument.
The four files contain the following:
 1. the sequences that were rejected during processing for these reasons:
     - the sequence doesn't have a valid adaptor sequence
     - the sequence contains only one base, repeated
 2. the name of the file containing those sequences that were rejected because
    they contain "N"s
 3. the file name of a FASTA file containing _all_ the reads from the FastQ
    file, including those in the reject files
 4. the trimmed reads that haven't been rejected in FASTA format

If there is a barcodes argument, run() attempts to de-multiplex while
removing the adaptor.  The result in this case is an array with four
or five elements.  The first three elements are the same as those from
the non-multiplexed mode described above.  The fourth argument is a
map from the barcode identifier (from the barcodes map) to FASTA file
name.  There will be an entry in the map for each barcode seen during
de-multiplexing.  There will be a fifth argument if the create_fastq
flag is true, in which case it will map from the barcode identifier to
FastQ file name.

=cut
sub run
{
  my %params = validate(@_, { input_file_name => 1, output_dir_name => 1,
                              processing_type => 1, trim_bases => 0,
                              trim_offset => 0,
                              barcodes => 0, barcode_position => 0,
                              adaptor_sequence => 0, create_fastq => 0,
                              keep_reads_with_n => 0 });

  my $input_file_name = $params{input_file_name};
  my $output_dir_name = $params{output_dir_name};
  my $processing_type = $params{processing_type};
  my $trim_bases = $params{trim_bases} || 25;
  my $trim_offset = $params{trim_offset} || 0;
  my $barcodes_map_ref = $params{barcodes};
  my $barcode_position = $params{barcode_position};
  my $adaptor_sequence = $params{adaptor_sequence};
  my $create_fastq = $params{create_fastq};
  my $keep_reads_with_n = $params{keep_reads_with_n} || 0;

  if (defined $barcodes_map_ref && !defined $barcode_position) {
    croak "barcode_position must be passed as an argument if barcodes "
      . "argument is passed";
  }

  my $barcode_length = undef;

  if (defined $barcodes_map_ref) {
    my @barcodes = keys %$barcodes_map_ref;
    my $first_barcode = shift @barcodes;

    $barcode_length = length $first_barcode;

    for my $barcode (@barcodes) {
      if (defined $barcode_length) {
        if ($barcode_length != length $barcode) {
          croak "barcodes must be the same length: '$barcode' vs '$first_barcode'"
        }
      }
    }
  }

  my $_trim_filename = sub {
    my $file_name = shift;
    $file_name =~ s|^$output_dir_name/||;
    return $file_name;
  };

  my $reject_count = 0;
  my $good_sequence_count = 0;

  my $default_out_file_fasta;

  my $multiplexed = defined $barcodes_map_ref;

  my $output_file_base = $input_file_name;
  $output_file_base =~ s{.*/(.*?)(?:\.(?:fq|fastq))?$}{$output_dir_name/$1};

  my $fastq_seqio = Bio::SeqIO->new(-file => $input_file_name,
                                    -format => 'fastfastq');

  my $n_reject_file_name = "$output_file_base.n-rejects.fasta";
  my $reject_file_name = "$output_file_base.rejects.fasta";
  my $fasta_file_name = "$output_file_base.reads.fasta";

  # used when there is no multiplexing
  my $default_out_file_name = "$output_file_base.fasta";
  my $default_out_file;

  if (!$multiplexed || $trim_offset > 0) {
    if (-e $default_out_file_name) {
      croak "can't open $default_out_file_name for writing: file exists\n";
    }
    open $default_out_file, '>', $default_out_file_name
      or croak "can't open $default_out_file_name for writing: $!\n";
  }

  # used when there is multiplexing
  my $out_files_by_code = {};
  my $out_fastq_files_by_code = {};

  # for reads that contain 'N's
  open my $n_rej_file, '>', $n_reject_file_name
    or croak("can't open $n_reject_file_name for writing: $!\n");

  # for other reads that are rejected
  open my $rej_file, '>', $reject_file_name
    or croak("can't open $reject_file_name for writing: $!\n");

  open my $fasta_file, '>', $fasta_file_name
    or croak("can't open $fasta_file_name for writing: $!\n");

  my $five_prime_code_re = '';
  my $three_prime_code_re = '';
  if ($multiplexed && $trim_offset == 0) {
    my $code_re = join '|', keys %$barcodes_map_ref;
    if ($barcode_position eq '5-prime') {
      $five_prime_code_re = $code_re;
    } else {
      $three_prime_code_re = $code_re;
    }
  }

  my $process_re;

  if ($processing_type eq 'remove_adaptors') {
    my $adaptor_start;

    if ($multiplexed) {
      $adaptor_start = substr($adaptor_sequence, 0, 3);
    } else {
      $adaptor_start = substr($adaptor_sequence, 0, 8);
    }

    $process_re =  qr/^($five_prime_code_re)(.+)($three_prime_code_re)($adaptor_start.*)/;
  } else {
    if ($processing_type eq 'trim') {
      if ($trim_offset > 0) {
        $process_re = qr/^(.{$trim_offset})(.{$trim_bases})/;
      } else {
        $process_re = qr/^($five_prime_code_re)(.{$trim_bases})/;
      }
    } else {
      if ($processing_type eq 'passthrough') {
        $process_re =  qr/^($five_prime_code_re)(.+)($three_prime_code_re)/;
      } else {
        croak "unknown processing type: $processing_type\n";
      }
    }
  }

  while (defined (my $seq_obj = $fastq_seqio->next_seq())) {
    my $sequence = $seq_obj->{sequence};
    my $seq_len = length $sequence;
    my $id = $seq_obj->{id};

    print $fasta_file ">$id\n";
    print $fasta_file "$sequence\n";

    if ($sequence =~ m/$process_re/) {
      my $trimmed_seq = $2;
      my $code_from_seq;

      if ($multiplexed && $trim_offset == 0) {
        if ($barcode_position eq '5-prime') {
          $code_from_seq = $1;
        } else {
          $code_from_seq = $3;
        }
      } else {
        $code_from_seq = '';
      }

      if (!defined $code_from_seq) {
        croak "internal error - code_from_seq not defined for input: $sequence\n"
          . " input_file: $input_file_name\n"
          . " regex: $process_re\n"
          . " barcode position: $barcode_position\n";
      }

      # the start index in the original sequence of the sequence that we're
      # keeping
      my $seq_offset = $trim_offset + length($1);

        if ($keep_reads_with_n || $trimmed_seq =~ m/^([ACGT]*$)/i) {
          if ($multiplexed && $trim_offset == 0) {
            if (length $trimmed_seq == 0) {
              print $rej_file ">$id No sequence after removing bar code $code_from_seq\n";
              print $rej_file "$sequence\n";
            } else {
              if (length $trimmed_seq > 0) {
                my $out_file_fasta =
                  _get_file_for_code($out_files_by_code,
                                     $output_file_base,
                                     $code_from_seq,
                                     $barcodes_map_ref,
                                     'fasta');
                if (defined $out_file_fasta) {
                  print $out_file_fasta ">$id\n";
                  print $out_file_fasta "$trimmed_seq\n";

                  if ($create_fastq) {
                    my $out_file_fastq =
                      _get_file_for_code($out_fastq_files_by_code,
                                         $output_file_base,
                                         $code_from_seq,
                                         $barcodes_map_ref,
                                         'fastq');
                    my $trimmed_quality =
                      _trim_quality($seq_obj->{quality},
                                    $trimmed_seq, $seq_offset);
                    print $out_file_fastq "\@$id\n";
                    print $out_file_fastq "$trimmed_seq\n";
                    print $out_file_fastq "+$id\n";
                    print $out_file_fastq "$trimmed_quality\n";
                  }
                } else {
                  print $rej_file ">$id Does not match any barcodes, code: $code_from_seq\n";
                  print $rej_file "$sequence\n";
                }
              } else {
                print $rej_file ">$id Is zero length after removing the adaptor and bar code ($code_from_seq)\n";
                print $rej_file "$sequence\n";
              }
            }
          } else {
            print $default_out_file ">$id\n";
            print $default_out_file "$trimmed_seq\n";
            $good_sequence_count++;
          }
        } else {
          $reject_count++;
          print $n_rej_file ">$id Contains Ns\n";
          print $n_rej_file "$sequence\n";
        }
    } else {
      $reject_count++;
      my $message = undef;
      if ($processing_type eq 'remove_adaptors') {
        if ($multiplexed) {
          $message = "Does not match the barcode or does not match the adaptor";
        } else {
          $message = "Does not match the adaptor";
        }
      } else {
        $message = "Does not match the barcode";
      }

      print $rej_file ">$id $message\n";
      print $rej_file "$sequence\n";
    }

    if ($ENV{'SMALLRNA_PIPELINE_TEST'} &&
          ($good_sequence_count >= 10000 || $reject_count >= 10000)) {
      last;
    }
  }

  if (defined $default_out_file) {
    close $default_out_file or croak "can't close $default_out_file_name: $!\n";
  }

  for my $barcode_file (values %$out_files_by_code) {
    close $barcode_file->{file} or croak "can't close file: $!\n";
  }
  for my $fastq_barcode_file (values %$out_fastq_files_by_code) {
    close $fastq_barcode_file->{file} or croak "can't close file: $!\n";
  }

  close $rej_file or croak "can't close $reject_file_name: $!\n";
  close $n_rej_file or croak "can't close $n_reject_file_name: $!\n";
  close $fasta_file or croak "can't close $fasta_file_name: $!\n";

  if ($multiplexed && $trim_offset == 0) {
    return ($_trim_filename->($reject_file_name),
            $_trim_filename->($n_reject_file_name),
            $_trim_filename->($fasta_file_name),
            {
              map {
                ($_ => $_trim_filename->($out_files_by_code->{$_}{name}))
              } keys %$out_files_by_code
            },
            {
              map {
                ($_ => $_trim_filename->($out_fastq_files_by_code->{$_}{name}))
              } keys %$out_fastq_files_by_code
            });
  } else {
    return ($_trim_filename->($reject_file_name),
            $_trim_filename->($n_reject_file_name),
            $_trim_filename->($fasta_file_name),
            $_trim_filename->($default_out_file_name));
  }
}

1;
