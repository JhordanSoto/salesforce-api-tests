package org.fundacionjala.salesforce.hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.response.Response;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.core.utils.Mapper;
import org.fundacionjala.salesforce.context.Context;

public class LeadHooks {

    private final Context context;

    /**
     * Adding Dependency injection to share Account id.
     * @param commonContext
     */
    public LeadHooks(final Context commonContext) {
        context = commonContext;
    }

    /**
     * BeforeHook that creates a Lead for scenarios that require it.
     */
    @Before(value = "@createLead")
    public void createLead() {
        Response response = RequestManager.post("Lead/",
                "{\"LastName\" : \"leadlastname\", \"Company\" : \"Company test\"}");
        this.context.getDataMap().put("recordId", response.jsonPath().getString("id"));
    }

    /**
     * AfterHook that deletes a created Account.
     */
    @After(value = "@deleteLead")
    public void deleteLead() {
        RequestManager.delete(Mapper.mapValue("Lead/{recordId}", context.getDataMap()));
    }
}
