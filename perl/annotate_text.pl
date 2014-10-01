#!/usr/bin/perl

use LWP::Simple;                # From CPAN
use JSON qw( decode_json );     # From CPAN
use Data::Dumper;               # Perl core module
use strict;                     # Good practice
use warnings;                   # Good practice

my $rest_url = "http://data.bioontology.org/";
my $api_key = "";

my $text_to_annotate = "Melanoma is a malignant tumor of melanocytes which are found predominantly in skin but also in the bowel and the eye.";

# Get the top-level resources
my $json = get( $rest_url . "?apikey=" . $api_key );
die "Could not get $rest_url!" unless defined $json;
my $resources = decode_json( $json );

# Follow the links to the ontologies
my $annotate_link = $resources->{'links'}->{'annotator'};

# Get the ontologies
my $annotate_json = get( $annotate_link . "?text=" . $text_to_annotate . "&include=prefLabel&apikey=" . $api_key );
die "Could not get $annotate_link!" unless defined $annotate_json;
my @classes = @{ decode_json( $annotate_json ) };

foreach my $ann (@classes) {
  my $cls = $ann->{'annotatedClass'};
  print $cls->{'prefLabel'} . "\t" . $cls->{'@id'} . "\t" . $cls->{'links'}->{'ontology'} . "\n";
}
