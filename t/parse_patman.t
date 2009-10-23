use strict;
use warnings;
use Test::More tests => 15;

BEGIN {
  use_ok 'SmallRNA::Parse::Patman';
}

sub test_output
{
  my $parser = shift;
  my $full = shift;

  my $match = $parser->next();

  ok($match->{qid} eq 'ACAAAGAGCTCGCCGCAGATAGGA');
  ok($match->{qstart} == 1);
  ok($match->{qend} == 24);
  ok($match->{sstart} == 8);
  ok($match->{send} == 31);
  ok($match->{forward_match} == 0);
  ok($match->{matching_base_count} == 24);
  ok($match->{percent_id} == 100.0);

  $match = $parser->next();

  ok($match->{qid} eq 'GAGCGACGACGAAGGATGAGTT');
  ok($match->{qstart} == 1);
  ok($match->{qend} == 22);
  ok($match->{sstart} == 420);
  ok($match->{send} == 441);
  ok($match->{matching_base_count} == 22);
}

my $in_file = 't/data/parse_patman_data.patman';
open my $fh, '<', $in_file or die "can't open $in_file: $!\n";

my $parser = SmallRNA::Parse::Patman->new(input_file_handle => $fh);
test_output($parser);
