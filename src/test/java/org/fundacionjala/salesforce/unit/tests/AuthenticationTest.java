package org.fundacionjala.salesforce.unit.tests;

import org.fundacionjala.salesforce.utils.AuthenticationUtils;
import org.junit.Assert;
import org.testng.annotations.Test;

public class AuthenticationTest {

    /**
     * Test for getToken method of AuthenticationUtils class.
     */
    @Test
    public void getTokenTest() {
        String actual = AuthenticationUtils.getToken();
        Assert.assertTrue(actual.startsWith("00D4x00000"));
    }
}
