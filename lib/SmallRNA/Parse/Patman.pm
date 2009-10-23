package SmallRNA::Parse::Patman;

=head1 NAME

SmallRNA::Parse::Patman - A parser for PatMaN output

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Parse::Patman

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

=cut

use strict;
use warnings;
use Carp;
use Params::Validate;

=head2 new

 Usage   : my $parser = SmallRNA::Parse::Patman->new(input_file_handle => $fh);
 Function: Create and return a new parser, reading from the given file handle
 Args    : input_file_handle - file handler to read from
           format - "standard" for the default Patman output, or "pf" for the
                    output when using the -pf Patman flag

=cut
sub new
{
  my $class = shift;

  my %params = validate(@_, { input_file_handle => 1 });

  my $self = { fh => $params{input_file_handle}};

  return bless $self, $class;
}

sub _next
{
  my $self = shift;

  my $fh = $self->{fh};

  while (defined (my $line = <$fh>)) {
    my @bits = split /\t/, $line;
    if (@bits == 6) {
      my $subject_id = $bits[0];
      my $query_id = $bits[1];
      my $sstart = $bits[2];
      my $send = $bits[3];
      my $strand = $bits[4];
      my $edit_distance = $bits[5];

      $subject_id =~ s/^(\S+).*/$1/;
      $query_id =~ s/^(\S+).*/$1/;

      my $sid = $3;

      my $qlength = ($send - $sstart) + 1;

      return { forward_match => ($strand eq '+'),
               qid => $query_id,
               qstart => 1,
               qend => $qlength,
               qlength => $qlength,
               sid => $subject_id,
               sstart => $sstart,
               send => $send,
               matching_base_count => $qlength,
               percent_id => 100.0,
             }
    } else {
      die "line doesn't have 6 fields: $line\n";
    }
  }

  return undef;

}

=head2 next

 Usage   : my $match = $parser->next();
 Function: return information about the next match from the input Patman stream
 Args    : None
 Returns : a hash ref containing with these keys:
               qid - query id
               qstart - query start
               qend - query end
               sid - subject id
               sstart - subject start
               send - subject end
               forward_match - true iff the query hit the forward strand of the
                               subject
               matching_base_count - the number of matching bases
               percent_id - the percentage identity in the match
           or undef if there are no more matches

=cut
sub next
{
  my $self = shift;

  my $fh = $self->{fh};

  if (!defined $fh) {
    # last call to next() hit EOF
    return undef;
  }

  my $result = $self->_next();

  if (defined $result) {
    return $result;
  } else {
    $self->{fh} = undef;
    return undef;
  }
}


1;

