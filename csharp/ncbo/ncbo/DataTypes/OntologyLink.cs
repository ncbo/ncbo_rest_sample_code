using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ncbo.DataTypes
{
    public class OntologyLink
    {
        [JsonProperty("submissions")]
        public string Submissions { get; set; }
        [JsonProperty("properties")]
        public string Properties { get; set; }
        [JsonProperty("classes")]
        public string Classes { get; set; }
        [JsonProperty("single_class")]
        public string SingleClass { get; set; }
        [JsonProperty("roots")]
        public string Roots { get; set; }
        [JsonProperty("instances")]
        public string Instances { get; set; }
        [JsonProperty("metrics")]
        public string Metrics { get; set; }
        [JsonProperty("reviews")]
        public string Reviews { get; set; }
        [JsonProperty("notes")]
        public string Notes { get; set; }
        [JsonProperty("groups")]
        public string Groups { get; set; }
        [JsonProperty("categories")]
        public string Categories { get; set; }
        [JsonProperty("latest_submission")]
        public string LatestSubmission { get; set; }
        [JsonProperty("projects")]
        public string Projects { get; set; }
        [JsonProperty("download")]
        public string Download { get; set; }
        [JsonProperty("views")]
        public string Views { get; set; }
        [JsonProperty("analytics")]
        public string Analytics { get; set; }
        [JsonProperty("ui")]
        public string UI { get; set; }
    }
}
