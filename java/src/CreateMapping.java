import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.*;
import java.lang.Exception;
import java.lang.String;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class CreateMapping {

    static final String REST_URL = "http://data.bioontology.org";
    private static final String API_KEY = "";
    private static final ObjectMapper mapper = new ObjectMapper();

    public static void main(String[] args) throws Exception {
        Mapping mapping = new Mapping();
        mapping.setCreator("http://data.bioontology.org/user/{your username here}");
        mapping.setRelation("http://www.w3.org/2002/07/owl#sameAs");
        mapping.setSource("MY_USER");
        mapping.setSource_name("MyUsers's Mapping Data");
        mapping.setComment("This mapping creates a same as mapping between melanoma (NCIT) and melanoma (SNOMEDCT)");

        // Create terms
        List<Term> terms = new ArrayList<Term>();
        Term ncitMelanoma = new Term();
        ncitMelanoma.setOntology("NCIT");
        List<String> ncitTermIds = new ArrayList<String>();
        ncitTermIds.add("http://ncicb.nci.nih.gov/xml/owl/EVS/Thesaurus.owl#C8711");
        ncitMelanoma.setTerm(ncitTermIds);
        terms.add(ncitMelanoma);
        Term snomedMelanoma = new Term();
        snomedMelanoma.setOntology("SNOMEDCT");
        List<String> snomedTermIds = new ArrayList<String>();
        snomedTermIds.add("http://purl.bioontology.org/ontology/SNOMEDCT/372244006");
        snomedMelanoma.setTerm(snomedTermIds);
        terms.add(snomedMelanoma);
        mapping.setTerms(terms);

        // Convert mapping to JSON
        String prettyJSON = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(mapping);
        String bodyJSON = mapper.writeValueAsString(mapping);
        System.out.println("Mapping as JSON:");
        System.out.println(prettyJSON);
        System.out.println("\n\n");

        // POST to web service
        postJSON(REST_URL + "/mappings", bodyJSON);

        // Success
        System.out.println("Added mapping successfully");
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

    private static String postJSON(String urlToGet, String body) {
        URL url;
        HttpURLConnection conn;

        String line;
        String result = "";
        try {
            url = new URL(urlToGet);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setInstanceFollowRedirects(false);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "apikey token=" + API_KEY);
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("charset", "utf-8");
            conn.setUseCaches(false);

            DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
            wr.write(body.getBytes());
            wr.flush();
            wr.close();
            conn.disconnect();

            InputStream is;
            boolean error = false;
            if (conn.getResponseCode() >= 200 && conn.getResponseCode() < 400) {
                is = conn.getInputStream();
            } else {
                error = true;
                is = conn.getErrorStream();
            }

            BufferedReader rd = new BufferedReader(
                    new InputStreamReader(is));
            while ((line = rd.readLine()) != null) {
                result += line;
            }
            rd.close();

            if (error) throw new Exception(result);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    static class Term {
        private String ontology;
        private List<String> term;

        public String getOntology() {
            return ontology;
        }

        public void setOntology(String ontology) {
            this.ontology = ontology;
        }

        public List<String> getTerm() {
            return term;
        }

        public void setTerm(List<String> term) {
            this.term = term;
        }
    }

    static class Mapping {
        private String creator;
        private String relation;
        private String source;
        private String source_name;
        private String comment;
        private List<Term> terms;

        public String getCreator() {
            return creator;
        }

        public void setCreator(String creator) {
            this.creator = creator;
        }

        public String getRelation() {
            return relation;
        }

        public void setRelation(String relation) {
            this.relation = relation;
        }

        public String getSource() {
            return source;
        }

        public void setSource(String source) {
            this.source = source;
        }

        public String getSource_name() {
            return source_name;
        }

        public void setSource_name(String source_name) {
            this.source_name = source_name;
        }

        public String getComment() {
            return comment;
        }

        public void setComment(String comment) {
            this.comment = comment;
        }

        public List<Term> getTerms() {
            return terms;
        }

        public void setTerms(List<Term> terms) {
            this.terms = terms;
        }
    }
}
