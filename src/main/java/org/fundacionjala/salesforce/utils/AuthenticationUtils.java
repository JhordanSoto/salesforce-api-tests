package org.fundacionjala.salesforce.utils;
import com.fasterxml.jackson.core.JsonProcessingException;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import org.fundacionjala.salesforce.config.PropertiesHandler;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.Map;

public final class AuthenticationUtils {
    private static final String BASE_LOGIN_URL = PropertiesHandler.getInstance().getBaseUrl();
    private static final String PATH = "services/oauth2/token";
    private static final String GRANT_TYPE_KEY = "grant_type";
    private static final String GRANT_TYPE_VAL = PropertiesHandler.getInstance().getGrantType();
    private static final String CLIENT_ID_KEY = "client_id";
    private static final String CLIENT_ID_VAL = PropertiesHandler.getInstance().getClientId();
    private static final String CLIENT_SECRET_KEY = "client_secret";
    private static final String CLIENT_SECRET_VAL = PropertiesHandler.getInstance().getClientSecret();
    private static final String USERNAME_KEY = "username";
    private static final String USERNAME_VAL = PropertiesHandler.getInstance().getUsername();
    private static final String PASSWORD_KEY = "password";
    private static final String PASSWORD_VAL = PropertiesHandler.getInstance().getPassword();

    /**
     * Private secure Constructor.
     */
    private AuthenticationUtils() {
    }

    /**
     * It try to get the credentials from salesforce, sending a request for that purpose.
     * @return the authentication response from salesforce as a Map.
     */
    public static Map getMappedResponse() {
        RestAssured.baseURI = BASE_LOGIN_URL;
        Response response = RestAssured
                .given()
                .param(GRANT_TYPE_KEY, GRANT_TYPE_VAL)
                .param(CLIENT_ID_KEY, CLIENT_ID_VAL)
                .param(CLIENT_SECRET_KEY, CLIENT_SECRET_VAL)
                .param(USERNAME_KEY, USERNAME_VAL)
                .param(PASSWORD_KEY, PASSWORD_VAL)
                .when()
                .post(PATH);
        try {
            ObjectMapper mapper = new ObjectMapper();
            return mapper.readValue(response.asPrettyString(), Map.class);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }
}
