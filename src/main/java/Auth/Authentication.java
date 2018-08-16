package Auth;

import com.github.restdriver.serverdriver.http.response.Response;
import org.json.JSONObject;

import static com.github.restdriver.serverdriver.RestServerDriver.*;

public class Authentication{
    protected static Response response;
    public static JSONObject salesforceJSONValues = new JSONObject();

    public static void getSalesforceToken(String host, String user, String pass, String id, String secret) {
        response = post(host + "/services/oauth2/token?grant_type=password&client_id=" + id + "&client_secret=" + secret + "&username=" + user + "&password=" + pass);
        salesforceJSONValues.put("access_token", String.valueOf(response.asJson().get("access_token")).split("\"")[1]);
        salesforceJSONValues.put("refresh_token", "");
        salesforceJSONValues.put("signature", String.valueOf(response.asJson().get("signature")).split("\"")[1]);
        salesforceJSONValues.put("scope", "refresh_token visualforce web openid id api");
        salesforceJSONValues.put("id_token", "");
        salesforceJSONValues.put("instance_url", String.valueOf(response.asJson().get("instance_url")).split("\"")[1]);
        salesforceJSONValues.put("id", String.valueOf(response.asJson().get("id")).split("\"")[1]);
        salesforceJSONValues.put("token_type", "Bearer");
        salesforceJSONValues.put("issued_at", String.valueOf(response.asJson().get("issued_at")).split("\"")[1]);
    }

    public static String getAptoToken() {
        String apiHost="https://project-nibbler.herokuapp.com";
        String salesforceUrl="https://login.salesforce.com";
        String salesforceUser="matt@spoke-qa.com";
        String salesforcePass="Apt0tude";
        String sfID="3MVG9CEn_O3jvv0xyklUN8Y0iq4.ltwwmIxebjkLNRz_.S50g1X.h_yXXHwNE_3__G.pJ8zLyPHHCaVX9R0IE";
        String sfSecret="6071967490328930623";

        getSalesforceToken(salesforceUrl, salesforceUser, salesforcePass, sfID, sfSecret);
        System.out.print(salesforceJSONValues.toString());
        response = post(apiHost + "/oauth/webtoken", body(salesforceJSONValues.toString(), "application/json"), header("Accept", "application/json"), header("User-Agent", "apto-automation"));
        return String.valueOf(response.asJson().get("token")).split("\"")[1];
    }

}
