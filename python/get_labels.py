import urllib2
import json

REST_URL = "http://stagedata.bioontology.org"

ontologies = json.loads(urllib2.urlopen(REST_URL+"/ontologies").read())
bro = None
for ontology in ontologies:
    if ontology["acronym"] == "BRO":
        bro = ontology

labels = []

page = json.loads(urllib2.urlopen(bro["links"]["classes"]).read())
next_page = page
while next_page:
    next_page = page["links"]["next_page"]
    for bro_class in page["class"]:
        labels.append(bro_class["prefLabel"])
    if next_page:
        page = json.loads(urllib2.urlopen(next_page).read())
        
print labels