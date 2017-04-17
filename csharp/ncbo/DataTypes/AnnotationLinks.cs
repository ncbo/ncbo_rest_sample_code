using Newtonsoft.Json;

namespace ncbo.DataTypes
{
    public class AnnotationLinks
    {
        [JsonProperty("self")]
        public string Self { get; set; }
        [JsonProperty("ontology")]
        public string Ontology { get; set; }
        [JsonProperty("children")]
        public string Children { get; set; }
        [JsonProperty("parents")]
        public string Parents { get; set; }
        [JsonProperty("descendants")]
        public string Descendants { get; set; }
        [JsonProperty("ancestors")]
        public string Ancestors { get; set; }
        [JsonProperty("instances")]
        public string Instances { get; set; }
        [JsonProperty("tree")]
        public string Tree { get; set; }
        [JsonProperty("notes")]
        public string Notes { get; set; }
        [JsonProperty("mappings")]
        public string Mappings { get; set; }
        [JsonProperty("ui")]
        public string UI { get; set; }
    }
}