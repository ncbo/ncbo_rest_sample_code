#!/bin/bash
#===============================================================================
#
#          FILE:  batch_curl.sh
# 
#         USAGE:  ./batch_curl.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Darren L. Weber, Ph.D. <darren.weber@stanford.edu>
#       COMPANY:  Stanford University
#       VERSION:  1.0
#       CREATED:  03/04/2014 03:41:05 PM PST
#      REVISION:  ---
#===============================================================================


# TODO: add input arguments for APIKEY and json.txt file

APIKEY='YOUR_API_KEY'

# Example json content
cat > json.txt <<EOF
{
    "http://www.w3.org/2002/07/owl#Class": {
        "collection": [
            {
                "class": "http://bioontology.org/ontologies/BiomedicalResourceOntology.owl#Ontology_Development_and_Management",
                "ontology": "http://data.bioontology.org/ontologies/BRO"
            },
            {
                "class": "http://bioontology.org/ontologies/BiomedicalResourceOntology.owl#Modular_Component",
                "ontology": "http://data.bioontology.org/ontologies/BRO"
            },
            {
                "class": "http://bioontology.org/ontologies/BiomedicalResourceOntology.owl#Stimulator",
                "ontology": "http://data.bioontology.org/ontologies/BRO"
            }
        ],
        "include": "prefLabel,synonym,semanticTypes"
    }
}
EOF

#curl -v -X POST \
curl -X POST \
 -H "Authorization: apikey token=$APIKEY" \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 -d @json.txt \
 http://data.bioontology.org/batch
echo

# TODO: if using input argument, don't delete the file
rm json.txt

