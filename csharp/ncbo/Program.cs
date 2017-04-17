using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;

namespace ncbo
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("GetLabels:"); 
            GetLabels.DoIt();

            Console.WriteLine();
            Console.WriteLine("AnnotateText:"); 
            AnnotateText.DoIt();

            Console.WriteLine();
            Console.WriteLine("ClassesSearch"); 
            ClassesSearch.DoIt();

            Console.WriteLine();
            Console.WriteLine("ListOntologies");
            ListOntologies.DoIt();

            Console.WriteLine("Done"); 
            Console.ReadLine(); 
        }
    }
}