package SmallRNA::DB::ProcessConf;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("process_conf");
__PACKAGE__->add_columns(
  "process_conf_id",
  {
    data_type => "integer",
    default_value => "nextval('process_conf_process_conf_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "created_stamp",
  {
    data_type => "timestamp without time zone",
    default_value => "now()",
    is_nullable => 0,
    size => 8,
  },
  "runable_name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "detail",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "type",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("process_conf_id");
__PACKAGE__->add_unique_constraint("process_conf_id_pk", ["process_conf_id"]);
__PACKAGE__->has_many(
  "pipeprocesses",
  "SmallRNA::DB::Pipeprocess",
  { "foreign.process_conf" => "self.process_conf_id" },
);
__PACKAGE__->belongs_to("type", "SmallRNA::DB::Cvterm", { cvterm_id => "type" });
__PACKAGE__->has_many(
  "process_conf_inputs",
  "SmallRNA::DB::ProcessConfInput",
  { "foreign.process_conf" => "self.process_conf_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QYMtqBKKB9dLLxbmuhqnHw

sub long_description
{
  my $self = shift;

  my $ret = $self->type()->name();
  my $detail = $self->detail();

  if (defined $detail && length $detail > 0) {
    $ret .= ", $detail";
  }

  my @inputs = $self->process_conf_inputs();

  if (@inputs) {
    $ret .= ', input' . (@inputs == 1 ? '' : 's') . ': [';

    $ret .= join '], [', map {
      my $description = '';
      if (defined $_->content_type()) {
        $description .= $_->content_type()->name();
      }
      if (defined $_->format_type()) {
        if (length $description > 0) {
          $description .= ', ';
        }
        $description .= $_->format_type()->name()
      }
      if (defined $_->ecotype()) {
        if (length $description > 0) {
          $description .= ', ';
        }
        $description .= $_->ecotype()->long_description();
      }
      if (defined $_->biosample_type()) {
        if (length $description > 0) {
          $description .= ', ';
        }
        $description .= $_->biosample_type()->name();
      }
      $description;
    } @inputs;

    $ret .= ']';
  }

  return $ret;
}

# You can replace this text with custom content, and it will be preserved on regeneration
1;
