package org.fundacionjala.salesforce.unit.tests;

import io.restassured.specification.RequestSpecification;
import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.salesforce.utils.AuthenticationUtils;
import org.junit.Assert;
import org.testng.annotations.Test;

public class AuthenticationTest {

    private static final int OK_STATUS_CODE = 200;

    /**
     * Test to getLoggedReqSpec and send a request to Salesforce API.
     */
    @Test
    public void getResponseForAuthenticatedUserTest() {
        RequestSpecification request = AuthenticationUtils.getLoggedReqSpec();
        RequestManager.setRequestSpec(request);
        int actual = RequestManager.get("Account/0014x000003JAT8AAO").getStatusCode();
        int expected = OK_STATUS_CODE;
        Assert.assertEquals(actual, expected);
    }
}
