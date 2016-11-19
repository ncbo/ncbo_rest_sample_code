#!/usr/bin/ruby

# A script by Vincent Emonet to auto import ontologies from a BioPortal appliance to another
# It will import the metadata too
# Fill the following variables with

# URL of the API and APIKEY of the BioPortal we want to import data FROM
SOURCE_API = "http://data.bioontology.org"
SOURCE_APIKEY = ""

# URL of the API and APIKEY of the BioPortal we want to import data TO
TARGET_API = "http://agroportal.lirmm.fr"
TARGET_APIKEY = ""

# The username of the user that will have the administration rights on the ontology on the target portal
TARGETED_PORTAL_USER = "admin"

# The list of acronyms of ontologies to import
ONTOLOGIES_TO_IMPORT = ["STY"]



require 'json'
require 'net/http'

# A function to create a new ontology (if already Acronym already existing on the portal it will return HTTPConflict)
def create_ontology(ont_info)
  uri = URI.parse(TARGET_API)
  http = Net::HTTP.new(uri.host, uri.port)

  req = Net::HTTP::Put.new("/ontologies/#{ont_info["acronym"]}")
  req['Content-Type'] = "application/json"
  req['Authorization'] = "apikey token=#{TARGET_APIKEY}"

  if (ont_info["viewingRestriction"] == "private")
    # In case of private ontology (acl: list of user that have the right to see the ontology)
    req.body = { "acronym": ont_info["acronym"], "name": ont_info["name"], "group": ont_info["group"], "hasDomain": ont_info["hasDomain"], "administeredBy": [TARGETED_PORTAL_USER], "viewingRestriction": "private", "acl": [TARGETED_PORTAL_USER]}.to_json
  else
    req.body = { "acronym": ont_info["acronym"], "name": ont_info["name"], "group": ont_info["group"], "hasDomain": ont_info["hasDomain"], "administeredBy": [TARGETED_PORTAL_USER]}.to_json
  end

  response = http.start do |http|
    http.request(req)
  end

  return response
end

# A function that take the submission informations from the source BioPortal to create a new submission
# 2 possibilities:
# - the source BioPortal pulls the ontology from an URL (pullLocation is filled), in this case we directly pull from this URL
# - Or it stores it directly in the portal, in this case we pull it from the portal download link
def upload_submission(sub_info)
  uri = URI.parse(TARGET_API)
  http = Net::HTTP.new(uri.host, uri.port)

  req = Net::HTTP::Post.new("/ontologies/#{sub_info["ontology"]["acronym"]}/submissions")
  req['Content-Type'] = "application/json"
  req['Authorization'] = "apikey token=#{TARGET_APIKEY}"

  # Check if the source BioPortal is pulling the ontology from an URL
  # If yes then we will pull the ontology from this place (allow auto update of the ontology when the ontology is changed in its source URL)
  if sub_info["pullLocation"].nil?
    pull_location = "#{sub_info["ontology"]["links"]["download"]}?apikey=#{SOURCE_APIKEY}"
  else
    pull_location = sub_info["pullLocation"]
  end

  # Extract contacts
  contacts = []
  sub_info["contact"].each do |contact|
    contacts.push({"name": contact["name"],"email": contact["email"]})
  end

  # Build the json body
  # hasOntologyLanguage options: OWL, UMLS, SKOS, OBO
  # status: alpha, beta, production, retired
  req.body = {
      "contact": contacts,
      "hasOntologyLanguage": sub_info["hasOntologyLanguage"],
      "released": sub_info["released"],
      "ontology": "#{TARGET_API}/ontologies/#{sub_info["ontology"]["acronym"]}",
      "description": sub_info["description"],
      "status": sub_info["status"],
      "version": sub_info["version"],
      "homepage": sub_info["homepage"],
      "documentation": sub_info["documentation"],
      "publication": sub_info["publication"],
      "naturalLanguage": sub_info["naturalLanguage"],
      "pullLocation": pull_location
  }.to_json

  #puts req.body.to_s
  response = http.start do |http|
    http.request(req)
  end

  return response
end


# Go through all ontologies acronym and get their latest_submission informations
ONTOLOGIES_TO_IMPORT.each do |ont|
  sub_info = JSON.parse(Net::HTTP.get(URI.parse("#{SOURCE_API}/ontologies/#{ont}/latest_submission?apikey=#{SOURCE_APIKEY}&display=all")))

  # if the ontology is already created then it will return HTTPConflict, no consequences
  puts create_ontology(sub_info["ontology"])

  puts upload_submission(sub_info)
end


