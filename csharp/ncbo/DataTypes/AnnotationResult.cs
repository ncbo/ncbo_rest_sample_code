using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace ncbo.DataTypes
{
    public class AnnotationResult
    {
        [JsonProperty("annotatedClass")]
        public AnnotatedClass AnnotatedClass { get; set; }
        [JsonProperty("hierarchy")]
        public List<AnnotatedClass> Hierarchy { get; set; }
        [JsonProperty("annotations")]
        public List<Annotation> Annotations { get; set; }
        [JsonProperty("mappings")]
        public List<string> Mappings { get; set; }
    }
}
