package org.fundacionjala.salesforce.hooks;

import io.cucumber.java.Before;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.salesforce.context.Context;
import org.fundacionjala.salesforce.utils.AuthenticationUtils;

public class CommonHooks {

    private Context context;

    /**
     * Adding Dependency injection to share Account id.
     * @param context
     */
    public CommonHooks(final Context context) {
        this.context = context;
    }

    @Before(value = "@createAccount")
    public void createAccount() {
        RequestManager.setRequestSpec(AuthenticationUtils.getLoggedReqSpec());
        Response response = RequestManager.post("Account/", "{\"Name\" : \"Example Account\"}");
        this.context.getDataMap().put("accountId", response.jsonPath().getString("id"));
        System.out.println(context.getDataMap().toString());
    }
}
