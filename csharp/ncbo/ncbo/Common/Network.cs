using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace ncbo.Common
{
    public static class Network
    {
        public static string GetJsonResponse(string url)
        {
            HttpClient web = new HttpClient();
            web.DefaultRequestHeaders.Add("Authorization", "apikey token=5cddf159-a650-4458-b802-cb5936567668");
            Task<HttpResponseMessage> asyncResponse = web.GetAsync(url);
            asyncResponse.Wait();
            HttpResponseMessage response = asyncResponse.Result;

            Task<string> asyncString = response.Content.ReadAsStringAsync();
            asyncString.Wait();

            return asyncString.Result;
        }

        public static T GetResponseAs<T>(string url)
        {
            string jsonResponse = GetJsonResponse(url);
            return JsonConvert.DeserializeObject<T>(jsonResponse);
        }
    }
}
