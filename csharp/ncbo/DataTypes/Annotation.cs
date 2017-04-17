using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ncbo.DataTypes
{
    public class Annotation
    {
        [JsonProperty("from")]
        public int From { get; set; }
        [JsonProperty("to")]
        public int To { get; set; }
        [JsonProperty("matchType")]
        public string MatchType { get; set; }
        [JsonProperty("text")]
        public string Text { get; set; }
    }
}
