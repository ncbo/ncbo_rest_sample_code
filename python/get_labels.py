import urllib2
import json

REST_URL = "http://data.bioontology.org"
API_KEY = ""


def get_json(url):
    opener = urllib2.build_opener()
    opener.addheaders = [('Authorization', 'apikey token=' + API_KEY)]
    return json.loads(opener.open(url).read())

# Get all ontologies from the REST service and parse the JSON
ontologies = get_json(REST_URL+"/ontologies")

# Iterate looking for ontology with acronym BRO
bro = None
for ontology in ontologies:
    if ontology["acronym"] == "BRO":
        bro = ontology

labels = []

# Using the hypermedia link called `classes`, get the first page
page = get_json(bro["links"]["classes"])

# Iterate over the available pages adding labels from all classes
# When we hit the last page, the while loop will exit
next_page = page
while next_page:
    next_page = page["links"]["nextPage"]
    for bro_class in page["collection"]:
        labels.append(bro_class["prefLabel"])
    if next_page:
        page = get_json(next_page)

# Output the labels
for label in labels:
    print label
