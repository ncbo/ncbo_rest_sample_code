require 'json'
require 'open-uri'

$REST_URL = "http://stagedata.bioontology.org"

ontologies = JSON.parse(open($REST_URL+"/ontologies").read)

bro = ontologies.select {|o| o["acronym"] == "BRO"}.shift

labels = []

page = JSON.parse(open(bro["links"]["classes"]).read)
next_page = page
while (next_page)
  next_page = page["links"]["next_page"]
  page["class"].each do |cls|
    labels << cls["prefLabel"]
  end
  page = JSON.parse(open(next_page).read) if next_page
end

pp labels.compact