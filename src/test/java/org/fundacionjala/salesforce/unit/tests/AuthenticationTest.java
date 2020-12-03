package org.fundacionjala.salesforce.unit.tests;

import org.fundacionjala.salesforce.utils.AuthenticationUtils;
import org.junit.Assert;
import org.testng.annotations.Test;
import java.util.Map;

public class AuthenticationTest {

    /**
     * Test for getToken method of AuthenticationUtils class.
     */
    @Test
    public void getTokenTest() {
        Map<String, String> actual = AuthenticationUtils.getMappedResponse();
        Assert.assertTrue(actual.get("access_token").startsWith("00D4x00000"));
    }
}
