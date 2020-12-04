package org.fundacionjala.salesforce.stepdefs;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.core.utils.Mapper;
import org.fundacionjala.salesforce.context.Context;
import org.testng.Assert;

public class exampleStepDef {

    Response response;
    private Context context;

    /**
     * Adding Dependency injection to share Account id.
     * @param context
     */
    public exampleStepDef(final Context context) {
        this.context = context;
    }

    @When("the user sends a GET request to {string}")
    public void theUserSendsAGETRequestTo(String endpoint) {
        String endpointMapped = Mapper.mapValue(endpoint, context.getDataMap());
        System.out.println(context.getDataMap().toString());
        response = RequestManager.get(endpointMapped);
    }

    @Then("verifies response should have the \"{int}\" status code")
    public void verifiesResponseShouldHaveTheStatusCode(int statusCode) {
        Assert.assertEquals(response.getStatusCode(), statusCode);
    }
}
