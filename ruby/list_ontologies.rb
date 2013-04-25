require 'json'
require 'open-uri'

REST_URL = "http://stagedata.bioontology.org"
API_KEY = ""

def get_json(url)
  JSON.parse(open(url, "Authorization" => "apikey token=#{API_KEY}").read)
end

# Get the available resources
resources = get_json(REST_URL + "/")

# Follow the ontologies link by looking for the media type in the list of links
media_type = "http://data.bioontology.org/metadata/Ontology"
link = resources["links"]["@context"].keep_if {|link,type| type.eql?(media_type)}.keys.first

# Get the ontologies from the link we found
ontologies = get_json(resources["links"][link])

# Get the name and ontology id from the returned list
ontology_output = []
ontologies.each {|o| ontology_output << "#{o['name']}\n#{o['@id']}\n\n"}
    
# Print the first ontology in the list
require 'pp'
pp ontologies.first

# Print the names and ids
puts "\n\n"
ontology_output.each {|o| puts o}
