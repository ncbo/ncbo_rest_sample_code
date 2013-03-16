import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class GetLabels {
	static final String REST_URL = "http://stagedata.bioontology.org";
	static final ObjectMapper mapper = new ObjectMapper();

	public static void main(String[] args) {
		String ontologies_string = get(REST_URL + "/ontologies");
		JsonNode ontologies = jsonToNode(ontologies_string);
		JsonNode bro = null;
		for (JsonNode ontology : ontologies) {
			if (ontology.get("acronym").asText().equalsIgnoreCase("bro"))
				bro = ontology;
		}
		
		JsonNode page = jsonToNode(get(bro.get("links").get("classes").asText()));
		String nextPage = page.get("links").get("next_page").asText();
		ArrayList<String> labels = new ArrayList<String>();
		while (nextPage.length() != 0) {
			for (JsonNode cls : page.get("class")) {
				if (!cls.get("prefLabel").isNull())
					labels.add(cls.get("prefLabel").asText());
			}
			
			if (!page.get("links").get("next_page").isNull()) {
				nextPage = page.get("links").get("next_page").asText();
				page = jsonToNode(get(nextPage));
			} else {
				nextPage = "";
			}
		}
		
		for (String label : labels) {
			System.out.println(label);
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
