using ncbo.Common;
using ncbo.DataTypes;
using System;
using System.Collections.Generic;
using System.Text;
using System.Linq; 

namespace ncbo
{
    public static class ListOntologies
    {
        public static void DoIt()
        {
            Resources resources = Network.GetResponseAs<Resources>("http://data.bioontology.org");

            Ontology[] ontologies = Network.GetResponseAs<Ontology[]>(resources.Links.Ontologies);

            IEnumerable<string> ontologyStrings = ontologies.Select(n => n.Name + Environment.NewLine + 
                n.ID + Environment.NewLine + Environment.NewLine); 

            foreach(string ontologyString in ontologyStrings)
            {
                Console.WriteLine(ontologyString); 
            }
        }
    }
}
