package org.fundacionjala.salesforce.config;

import org.fundacionjala.core.config.Environment;

public final class PropertiesHandler extends Environment {

    private static final String PATH = "gradle.properties";
    private static PropertiesHandler props;

    /**
     * Initializes an instance of properties files.
     */
    private PropertiesHandler() {
        super(PATH);
    }

    /**
     * Initiate a single instance of PropertiesHandler, if it's possible.
     * @return the instance of PropertiesHandler object created.
     */
    public static PropertiesHandler getInstance() {
        if (props == null) {
            props = new PropertiesHandler();
        }
        return props;
    }

    /**
     * Get the baseLoginUrl property.
     * @return baseLoginUrl from project's properties.
     */
    public String getBaseLoginUrl() {
        return super.getEnvProperty("baseLoginUrl");
    }

    /**
     * Get the clientId property.
     * @return clientId from project's properties.
     */
    public String getClientId() {
        return super.getEnvProperty("clientId");
    }

    /**
     * Get the clientSecret property.
     * @return clientSecret from project's properties.
     */
    public String getClientSecret() {
        return super.getEnvProperty("clientSecret");
    }

    /**
     * Get the grantType property.
     * @return grantType from project's properties.
     */
    public String getGrantType() {
        return super.getEnvProperty("grantType");
    }

    /**
     * Get the username property.
     * @return username from project's properties.
     */
    public String getUsername() {
        return super.getEnvProperty("username");
    }

    /**
     * Get the password property.
     * @return password from project's properties.
     */
    public String getPassword() {
        return super.getEnvProperty("password");
    }

    /**
     * Get the filterTags property.
     * @return filterTags from project's properties.
     */
    public String getFilterTags() {
        return super.getEnvProperty("filterTags");
    }
}
