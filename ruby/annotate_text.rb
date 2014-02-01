require 'json'
require 'open-uri'
require 'cgi'

REST_URL = "http://data.bioontology.org"
API_KEY = ""

def get_json(url)
  JSON.parse(open(url, "Authorization" => "apikey token=#{API_KEY}").read)
end

def puts_annotations(annotations)
  annotations.each do |result|
    class_details = get_json(result["annotatedClass"]["links"]["self"])
    puts "Class details"
    puts "\tid: " + class_details["@id"]
    puts "\tprefLabel: " + class_details["prefLabel"]
    puts "\tontology: " + class_details["links"]["ontology"]

    puts "Annotation details"
    result["annotations"].each do |annotation|
      puts "\tfrom: #{annotation["from"]}"
      puts "\tto: #{annotation["to"]}"
      puts "\tmatch type: #{annotation["matchType"]}"
    end

    if !result["hierarchy"].empty?
      puts "\n\tHierarchy annotations"
      result["hierarchy"].each do |annotation|
        class_details = get_json(annotation["annotatedClass"]["links"]["self"])
        pref_label = class_details["prefLabel"] or "no label"
        puts "\t\tClass details"
        puts "\t\t\tid: " + class_details["@id"]
        puts "\t\t\tprefLabel: " + class_details["prefLabel"]
        puts "\t\t\tontology: " + class_details["links"]["ontology"]
        puts "\t\t\tdistance from originally annotated class: " + annotation["distance"].to_s
      end
    end

    puts "\n\n"
  end
end

# Annotate using the provided text
text_to_annotate = "Melanoma is a malignant tumor of melanocytes which are found predominantly in skin but also in the bowel and the eye."
annotations = get_json(REST_URL + "/annotator?text=" + CGI.escape(text_to_annotate))

# puts out annotation details
puts_annotations(annotations)

# Annotate with hierarchy information
annotations = get_json(REST_URL + "/annotator?max_level=3&text=" + CGI.escape(text_to_annotate))
puts_annotations(annotations)
