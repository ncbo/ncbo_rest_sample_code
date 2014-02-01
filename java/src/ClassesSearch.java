
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Scanner;
import java.io.FileReader;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

public class ClassesSearch {

    static final String REST_URL = "http://data.bioontology.org";
    static final String API_KEY = "";
    static final ObjectMapper mapper = new ObjectMapper();
    static final ObjectWriter writer = mapper.writerWithDefaultPrettyPrinter();

    public static void main(String[] args) throws Exception {
        ArrayList<String> terms = new ArrayList<String>();

        String currentDir = System.getProperty("user.dir");
        Scanner in = new Scanner(new FileReader(currentDir + "/src/classes_search_terms.txt"));

        while (in.hasNextLine()) {
            terms.add(in.nextLine());
        }

        ArrayList<JsonNode> searchResults = new ArrayList<JsonNode>();
        for (String term : terms) {
            JsonNode searchResult = jsonToNode(get(REST_URL + "/search?q=" + term)).get("collection");
            searchResults.add(searchResult);
        }

        for (JsonNode result : searchResults) {
            System.out.println(writer.writeValueAsString(result));
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
