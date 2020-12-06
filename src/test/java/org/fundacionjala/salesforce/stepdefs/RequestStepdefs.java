package org.fundacionjala.salesforce.stepdefs;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.core.utils.JsonSchemaValidator;
import org.fundacionjala.core.utils.Mapper;
import org.fundacionjala.salesforce.config.PropertiesHandler;
import org.fundacionjala.salesforce.context.Context;
import org.fundacionjala.salesforce.utils.AuthenticationUtils;
import org.fundacionjala.salesforce.utils.ResponseBodyValidator;
import org.testng.Assert;
import java.util.Map;

public class RequestStepdefs {

    private Response response;
    private Context context;

    /**
     * get the context.
     * @param contexts
     */
    public RequestStepdefs(final Context contexts) {
        this.context = contexts;
    }


    /**
     * Sets the valid authentication to request.
     */
    @Given("the user sets valid authentication to request")
    public void setValidAuthenticationToRequest() {
        RequestManager.setRequestSpec(AuthenticationUtils.getLoggedReqSpec());
    }

    /**
     * verifies response body should match with a string JSON schema.
     * @param schemaPath
     */
    @And("verifies response body should match with {string} JSON schema")
    public void verifyResponseBodyShouldMatchWithJSONSchema(final String schemaPath) {
        JsonSchemaValidator.validate(response, PropertiesHandler.getInstance().getSchemasPath() + schemaPath);
    }

    /**
     * verifies response should contain the following values.
     * @param expectedValues
     */
    @And("verifies response should contain the following values")
    public void verifyResponseShouldContainTheFollowingValues(final Map<String, String> expectedValues) {
        ResponseBodyValidator.validate(response, expectedValues);
    }

    /**
     * verifies the status code.
     * @param expectedStatusCode
     */
    @Then("verifies response should have the \"{int}\" status code")
    public void verifiesResponseShouldHaveTheStatusCode(final int expectedStatusCode) {
        Assert.assertEquals(response.getStatusCode(), expectedStatusCode);
    }



    /**
     * sends a DELETE request.
     * @param endpoint
     */

    @When("The user sends a DELETE request to {string} with the following Json data")
    public void theUserSendsADELETERequestToWithTheFollowingJsonData(final String endpoint) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getDataMap());
        response = RequestManager.delete(endpointMapped);
    }

    /**
     * sends a POST request.
     * @param endpoint
     * @param body
     */
    @When("The user sends a POST request to {string} with the following Json data")
    public void theUserSendsAPOSTRequestToWithTheFollowingJsonData(final String endpoint, final String body) {
        response = RequestManager.post(endpoint, body);
    }

    /**
     * Sends a GET request.
     * @param endpoint
     */
    @When("The user sends a GET request to {string} with the following Json data")
    public void theUserSendsAGETRequestToWithTheFollowingJsonData(final String endpoint) {
        String endpointMappxd = Mapper.mapValue(endpoint, context.getDataMap());
        response = RequestManager.get(endpointMappxd);
    }

    /**
     * sends a PATCH request.
     * @param endpoint
     * @param body
     */
    @When("The user sends a PATCH request to {string} with the following Json data")
    public void theUserSendsAPATCHRequestToWithTheFollowingJsonData(final String endpoint, final String body) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getDataMap());
        response = RequestManager.patch(endpointMapped, body);
    }
}
