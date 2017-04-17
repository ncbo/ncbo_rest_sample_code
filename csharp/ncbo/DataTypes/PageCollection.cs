using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ncbo.DataTypes
{
    public class PageCollection
    {
        [JsonProperty("@id")]
        public string ID { get; set; }
        [JsonProperty("prefLabel")]
        public string PrefLabel { get; set; }
        [JsonProperty("synonym")]
        public List<string> Synonym { get; set; }
        [JsonProperty("definition")]
        public List<string> Definition { get; set; }
        [JsonProperty("cui")]
        public List<string> CUI { get; set; }
        [JsonProperty("semanticType")]
        public List<string> SemanticType { get; set; }
        [JsonProperty("obsolete")]
        public bool Obsolete { get; set; }
        [JsonProperty("links")]
        public PageLinks Links { get; set; }
    }
}
