require 'json'
require 'open-uri'

REST_URL = "http://stagedata.bioontology.org"
API_KEY = ""

def get_json(url)
  JSON.parse(open(url, "Authorization" => "apikey token=#{API_KEY}").read)
end

# Get all ontologies from the REST service and parse the JSON
ontologies = get_json(REST_URL+"/ontologies")

# Iterate looking for ontology with acronym BRO
bro = ontologies.select {|o| o["acronym"] == "BRO"}.shift

labels = []

# Using the hypermedia link called `classes`, get the first page
page = get_json(bro["links"]["classes"])

# Iterate over the available pages adding labels from all classes
# When we hit the last page, the while loop will exit
next_page = page
while (next_page)
  next_page = page["links"]["nextPage"]
  page["class"].each do |cls|
    labels << cls["prefLabel"]
  end
  page = get_json(next_page) if next_page
end

# Output the labels
labels.compact.each {|l| puts l}