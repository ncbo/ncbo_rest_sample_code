using ncbo.Common;
using System;
using System.Collections.Generic;
using System.Text;
using ncbo.DataTypes; 

namespace ncbo
{
    public static class AnnotateText
    {
        private static void PrintAnnotations(AnnotationResult[] annotationResults)
        {
            foreach(AnnotationResult annotationResult in annotationResults)
            {
                AnnotationPage annotationPage = 
                    Network.GetResponseAs<AnnotationPage>(annotationResult.AnnotatedClass.Link.Self);

                Console.WriteLine("Class details");
                Console.WriteLine("\tID: " + annotationPage.ID);
                Console.WriteLine("\tPrefLabel: " + annotationPage.PrefLabel);
                Console.WriteLine("\tOntology: " + annotationPage.Links?.Ontology);

                Console.WriteLine("Annotation details"); 
                foreach(Annotation annotation in annotationResult.Annotations)
                {
                    Console.WriteLine("\tFrom: " + annotation.From);
                    Console.WriteLine("\tTo: " + annotation.To);
                    Console.WriteLine("\tMatch type: " + annotation.MatchType); 
                }

                if(annotationResult.Hierarchy!=null && annotationResult.Hierarchy.Count > 0)
                {
                    Console.WriteLine("Hierachy Annotations"); 
                    foreach (AnnotatedClass annotatedClass in annotationResult.Hierarchy)
                    {
                        AnnotationPage annotationHierarchyPage =
                            Network.GetResponseAs<AnnotationPage>(annotationResult.AnnotatedClass.Link.Self);

                        Console.WriteLine("\tClass details");
                        Console.WriteLine("\t\tID: " + annotationHierarchyPage.ID);
                        Console.WriteLine("\t\tPrefLabel: " + annotationHierarchyPage.PrefLabel);
                        Console.WriteLine("\t\tOntology: " + annotationHierarchyPage.Links.Ontology);
                        Console.WriteLine("\t\tDistance from originally annotated class: : " + annotatedClass.Distance);
                    }
                }

                Console.WriteLine("===="); 
            }
        }

        public static void DoIt()
        {
            string textToAnnotate =
                "Melanoma is a malignant tumor of melanocytes which are found " + 
                 "predominantly in skin but also in the bowel and the eye.";

            AnnotationResult[] annotationResults = 
                Network.GetResponseAs<AnnotationResult[]>(Constants.BaseUrl + "/annotator?text=" + textToAnnotate);

            PrintAnnotations(annotationResults); 
        }
    }
}
    