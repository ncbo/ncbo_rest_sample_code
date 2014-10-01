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
my $ont_link = $resources->{'links'}->{'ontologies'};

# Get the ontologies
my $ont_json = get( $ont_link . "?apikey=" . $api_key );
die "Could not get $ont_link!" unless defined $ont_json;
my @ontologies = @{ decode_json( $ont_json ) };

my $bro;
foreach my $ont (@ontologies) {
  if ($ont->{'acronym'} eq "BRO") {
    $bro = $ont;
  }
}

my $cls_page_link = $bro->{'links'}->{'classes'} . "?apikey=" . $api_key;

# Get the labels for BRO
my @classes;
while ($cls_page_link) {
  my $page_json = get( $cls_page_link );
  die "Could not get $cls_page_link!" unless defined $page_json;
  my $cls_page = decode_json( $page_json );
  push @classes, @{ $cls_page->{'collection'} };
  $cls_page_link = $cls_page->{'links'}->{'nextPage'};
}

foreach my $cls (@classes) {
  print $cls->{'prefLabel'} . "\n";
}

