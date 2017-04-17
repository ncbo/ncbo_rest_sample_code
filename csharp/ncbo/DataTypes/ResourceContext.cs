using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ncbo.DataTypes
{
    public class ResourceContext
    {
        [JsonProperty("submissions")]
        public string Submissions { get; set; }
        [JsonProperty("notes")]
        public string Notes { get; set; }
        [JsonProperty("categories")]
        public string Categories { get; set; }
        [JsonProperty("provisional_classes")]
        public string ProvisionalClasses { get; set; }
        [JsonProperty("slices")]
        public string Slices { get; set; }
        [JsonProperty("metrics")]
        public string Metrics { get; set; }
        [JsonProperty("mappings")]
        public string Mappings { get; set; }
        [JsonProperty("users")]
        public string Users { get; set; }
        [JsonProperty("projects")]
        public string Projects { get; set; }
        [JsonProperty("ontologies")]
        public string Ontologies { get; set; }
        [JsonProperty("groups")]
        public string Groups { get; set; }
        [JsonProperty("replies")]
        public string Replies { get; set; }
        [JsonProperty("provisional_relations")]
        public string ProvisionalRelations { get; set; }
        [JsonProperty("reviews")]
        public string Reviews { get; set; }
    }
}
