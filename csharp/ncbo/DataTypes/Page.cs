using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ncbo.DataTypes
{
    public class Page
    {
        [JsonProperty("page")]
        public int PageNumber { get; set; }
        [JsonProperty("pageCount")]
        public int PageCount { get; set; }
        [JsonProperty("totalCount")]
        public int TotalCount { get; set; }
        [JsonProperty("prevPage")]
        public string PrevPage { get; set; }
        [JsonProperty("nextPage")]
        public int? NextPageNumber { get; set; }
        [JsonProperty("links")]
        public PageLinks Link { get; set; }
        [JsonProperty("collection")]
        public List<PageCollection> Collections { get; set; }
    }
}
