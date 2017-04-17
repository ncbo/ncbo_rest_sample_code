using ncbo.Common;
using ncbo.DataTypes;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace ncbo
{
    public static class ClassesSearch
    {
        public static void DoIt()
        {
            string[] lines = File.ReadAllLines("classes_search_terms.txt");

            List<PageCollection> allCollections = new List<PageCollection>(); 
            foreach(string line in lines)
            {
                Page page = 
                    Network.GetResponseAs<Page>("http://data.bioontology.org/search?q=" + line);

                foreach(PageCollection collection in page.Collections)
                {
                    allCollections.Add(collection); 
                }
            }

            foreach(PageCollection collection in allCollections)
            {
                Console.WriteLine(collection.ID); 
            }
            return; 
        }
    }
}
