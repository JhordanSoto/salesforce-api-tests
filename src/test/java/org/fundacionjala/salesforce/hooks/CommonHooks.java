package org.fundacionjala.salesforce.hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.response.Response;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.core.utils.Mapper;
import org.fundacionjala.salesforce.context.Context;

public class CommonHooks {

    private final Context context;

    /**
     * Adding Dependency injection to share Account id.
     * @param commonContext
     */
    public CommonHooks(final Context commonContext) {
        context = commonContext;
    }

    /**
     * BeforeHook that creates an Account for scenarios that require it.
     */
    @Before(value = "@createAccount")
    public void createAccount() {
        Response response = RequestManager.post("Account/", "{\"Name\" : \"Example Account\"}");
        this.context.getDataMap().put("accountId", response.jsonPath().getString("id"));
    }

    /**
     * AfterHook that deletes a created Account.
     */
    @After(value = "@deleteAccount")
    public void deleteAccount() {
        RequestManager.delete(Mapper.mapValue("Account/{accountId}", context.getDataMap()));
    }
}
