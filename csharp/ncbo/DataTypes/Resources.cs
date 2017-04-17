using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ncbo.DataTypes
{
    public class Resources
    {
        [JsonProperty("links")]
        public ResourceLinks Links { get; set; }
    }
}
