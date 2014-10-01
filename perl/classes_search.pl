#!/usr/bin/perl

use LWP::Simple;                # From CPAN
use JSON qw( decode_json );     # From CPAN
use Data::Dumper;               # Perl core module
use strict;                     # Good practice
use warnings;                   # Good practice

my $rest_url = "http://data.bioontology.org/";
my $api_key = "";

# Get the top-level resources
my $json = get( $rest_url . "?apikey=" . $api_key );
die "Could not get $rest_url!" unless defined $json;
my $resources = decode_json( $json );

# Follow the links to the ontologies
my $search_link = $resources->{'links'}->{'search'};

# Get the ontologies
my $search_json = get( $search_link . "?q=heart&apikey=" . $api_key );
die "Could not get $search_link!" unless defined $search_json;
my $results = decode_json( $search_json );
my @classes = @{ $results->{'collection'} };

foreach my $cls (@classes) {
  print $cls->{'prefLabel'} . "\t" . $cls->{'@id'} . "\t" . $cls->{'links'}->{'ontology'} . "\n";
}
