package org.fundacionjala.salesforce.context;

import io.restassured.specification.RequestSpecification;

import java.util.HashMap;
import java.util.Map;

public class Context {

    //private RequestSpecification requestSpecification;
    private Map<String, String> dataMap;

    /**
     * Constructor for Context class.
     */
    public Context() {
        dataMap = new HashMap<>();
        //requestSpecification = null;
    }
/*
    public RequestSpecification getRequestSpecification() {
        return requestSpecification;
    }

    public void setRequestSpecification(RequestSpecification requestSpecification) {
        this.requestSpecification = requestSpecification;
    }

    public void setDataMap(Map<String, String> requestMap) {
        this.dataMap = requestMap;
    }
*/
    /**
     * Gets requestMap map attribute.
     * @return requestAsMap.
     */
    public Map getDataMap() {
        return this.dataMap;
    }
}
