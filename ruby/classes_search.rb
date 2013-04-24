require 'json'
require 'open-uri'

REST_URL = "http://stagedata.bioontology.org"
API_KEY = ""

def get_json(url)
  JSON.parse(open(url, "Authorization" => "apikey token=#{API_KEY}").read)
end

# Get list of search terms
path = File.expand_path('../classes_search_terms.txt', __FILE__)
terms_file = open(path, "r")
terms = []
terms_file.each {|line| terms << line}

# Do a search for every term
search_results = []
terms.each do |term|
  search_results << get_json(REST_URL + "/search?q=" + term)["collection"]
end
    
# Print the results
require 'pp'
pp search_results
