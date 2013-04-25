
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;

public class ListOntologies {

    static final String REST_URL = "http://stagedata.bioontology.org";
    static final String API_KEY = "";
    static final ObjectMapper mapper = new ObjectMapper();

    public static void main(String[] args) {
        // Get the available resources
        String resourcesString = get(REST_URL + "/");
        JsonNode resources = jsonToNode(resourcesString);

        // Follow the ontologies link by looking for the media type in the list of links
        String link = resources.get("links").findValue("ontologies").asText();

        // Get the ontologies from the link we found
        JsonNode ontologies = jsonToNode(get(link));

        // Get the name and ontology id from the returned list
        List<String> ontNames = new ArrayList<String>();
        for (JsonNode ontology : ontologies) {
            ontNames.add(ontology.get("name").asText() + "\n" + ontology.get("@id").asText() + "\n\n");
        }

        // Print the names and ids
        for (String ontName : ontNames) {
            System.out.println(ontName);
        }
    }

    private static JsonNode jsonToNode(String json) {
        JsonNode root = null;
        try {
            root = mapper.readTree(json);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return root;
    }

    private static String get(String urlToGet) {
        URL url;
        HttpURLConnection conn;
        BufferedReader rd;
        String line;
        String result = "";
        try {
            url = new URL(urlToGet);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "apikey token=" + API_KEY);
            conn.setRequestProperty("Accept", "application/json");
            rd = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()));
            while ((line = rd.readLine()) != null) {
                result += line;
            }
            rd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
