require 'json'
require 'open-uri'

$REST_URL = "http://stagedata.bioontology.org"

# Get all ontologies from the REST service and parse the JSON
ontologies = JSON.parse(open($REST_URL+"/ontologies").read)

# Iterate looking for ontology with acronym BRO
bro = ontologies.select {|o| o["acronym"] == "BRO"}.shift

labels = []

# Using the hypermedia link called `classes`, get the first page
page = JSON.parse(open(bro["links"]["classes"]).read)

# Iterate over the available pages adding labels from all classes
# When we hit the last page, the while loop will exit
next_page = page
while (next_page)
  next_page = page["links"]["next_page"]
  page["class"].each do |cls|
    labels << cls["prefLabel"]
  end
  page = JSON.parse(open(next_page).read) if next_page
end

# Output the labels
labels.compact.each {|l| puts l}