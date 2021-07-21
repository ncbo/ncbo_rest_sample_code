#!/usr/bin/env ruby

# Script for creating a new ontology submission and uploading an ontology file.
#
# Script requires APIKEY which is your bioportal.bioontology.org or ontoportal API key,
# existing ontology and an onotology file.

require 'rest-client'
# APIKEY of the BioPortal/Ontoportal account
APIKEY = 'YOUR-API-KEY'

# URL of the BioPortal/Ontoportal API
TARGET_API = 'https://data.bioontology.org'

# The acronym of existing ontology
ONTOLOGY = 'ABCD'

# New Submission Details
# hasOntologyLanguage options: OWL, UMLS, SKOS, OBO
# status: alpha, beta, production, retired
SUBMISSION_DETAILS = {
  'contact': { 'name': 'Joe Blow', 'email': 'joe@example.com' },
  'hasOntologyLanguage': 'OWL',
  'released': '2021-01-01',
  file: File.new("/path/to/your/ontology/file.owl.gz", 'rb'),
  'description': 'Super Duper Ontology',
  'status': 'production',
  'version': '1.0'
}

response = RestClient::Request.execute(
  method: :post,
  url: "#{TARGET_API}/ontologies/#{ONTOLOGY}/submissions",
  payload: SUBMISSION_DETAILS,
  headers: { Authorization: "apikey token=#{APIKEY}" }
)

puts response.code
puts response
