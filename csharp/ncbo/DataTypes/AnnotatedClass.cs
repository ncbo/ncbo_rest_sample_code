using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ncbo.DataTypes
{
    public class AnnotatedClass
    {
        [JsonProperty("links")]
        public AnnotationLinks Link { get; set; }
        [JsonProperty("distance")]
        public int Distance { get; set; }
    }
}
