import urllib.request, urllib.error, urllib.parse
import json
import os
from pprint import pprint

REST_URL = "http://data.bioontology.org"
API_KEY = ""

def get_json(url):
    opener = urllib.request.build_opener()
    opener.addheaders = [('Authorization', 'apikey token=' + API_KEY)]
    return json.loads(opener.open(url).read())

# Get the available resources
resources = get_json(REST_URL + "/")

# Get the ontologies from the `ontologies` link
ontologies = get_json(resources["links"]["ontologies"])

# Get the name and ontology id from the returned list
ontology_output = []
for ontology in ontologies:
    ontology_output.append(f"{ontology['name']}\n{ontology['@id']}\n")

# Print the first ontology in the list
pprint(ontologies[0])

# Print the names and ids
print("\n\n")
for ont in ontology_output:
    print(ont)

