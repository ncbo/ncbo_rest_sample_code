import urllib2
import json

REST_URL = "http://stagedata.bioontology.org"

# Get all ontologies from the REST service and parse the JSON
ontologies = json.loads(urllib2.urlopen(REST_URL+"/ontologies").read())

# Iterate looking for ontology with acronym BRO
bro = None
for ontology in ontologies:
    if ontology["acronym"] == "BRO":
        bro = ontology

labels = []

# Using the hypermedia link called `classes`, get the first page
page = json.loads(urllib2.urlopen(bro["links"]["classes"]).read())

# Iterate over the available pages adding labels from all classes
# When we hit the last page, the while loop will exit
next_page = page
while next_page:
    next_page = page["links"]["nextPage"]
    for bro_class in page["class"]:
        labels.append(bro_class["prefLabel"])
    if next_page:
        page = json.loads(urllib2.urlopen(next_page).read())

# Output the labels
for label in labels:
    print label