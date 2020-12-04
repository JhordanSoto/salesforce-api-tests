package org.fundacionjala.salesforce.context;

import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.salesforce.utils.AuthenticationUtils;
import java.util.HashMap;
import java.util.Map;

public class Context {
    private Map<String, String> dataMap;

    /**
     * Constructor for Context class.
     */
    public Context() {
        RequestManager.setRequestSpec(AuthenticationUtils.getLoggedReqSpec());
        dataMap = new HashMap<>();
    }

    /**
     * Gets requestMap map attribute.
     * @return requestAsMap.
     */
    public Map getDataMap() {
        return this.dataMap;
    }
}
