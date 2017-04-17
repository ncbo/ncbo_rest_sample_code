using ncbo.Common;
using ncbo.DataTypes;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;
using System.Linq; 

namespace ncbo
{
    public static class GetLabels
    {
        public static void DoIt()
        {
            // Get all ontologies from the REST service and parse the JSON
            Ontology[] ontology = Network.GetResponseAs<Ontology[]>(Constants.BaseUrl + "/ontologies"); 

            Ontology broOntology = ontology.Where(n => n.Acronym == "BRO").FirstOrDefault();

            string classesPageUrl = broOntology.Links.Classes;

            Page page = Network.GetResponseAs<Page>(classesPageUrl);

            List<string> labels = new List<string>(); 
            for(;;)
            {
                string nextPageUrl = page.Link.NextPageUrl;
                foreach(PageCollection collection in page.Collections)
                {
                    labels.Add(collection.PrefLabel); 
                }

                if(!string.IsNullOrEmpty(nextPageUrl))
                {
                    page = Network.GetResponseAs<Page>(nextPageUrl);
                }
                else
                {
                    break; 
                }
            }

            foreach(string label in labels)
            {
                Console.WriteLine(label); 
            }
        }
    }
}
