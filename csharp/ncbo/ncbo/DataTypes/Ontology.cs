using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ncbo.DataTypes
{
    public class Ontology
    {
        [JsonProperty("administeredBy")]
        public string[] AdministeredBy { get; set; }
        [JsonProperty("acronym")]
        public string Acronym { get; set; }
        [JsonProperty("name")]
        public string Name { get; set; }
        [JsonProperty("summaryOnly")]
        public string SummaryOnly { get; set; }
        [JsonProperty("ontologyType")]
        public string OntologyType { get; set; }
        [JsonProperty("links")]
        public OntologyLink Links { get; set; }
    }
}
