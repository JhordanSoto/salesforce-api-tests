Feature: Delete Campaign

  In order to delete a Campaign in Salesforce
  Authenticated as valid Salesforce API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createCampaign
  Scenario: Verify that is possible to delete a campaign
    When The user sends a DELETE request to "/Campaign/{recordId}" with the following Json data
    Then verifies response should have the "204" status code
    When  The user sends a GET request to "/Campaign/{recordId}" with the following Json data
    Then verifies response should have the "404" status code

  @negative
  Scenario: Verify that is not possible to delete a campaign using an invalid id
    When The user sends a DELETE request to "/Campaign/-1" with the following Json data
    Then verifies response should have the "404" status code
    And verifies response body should match with "Campaign/notFoundResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Provided external ID field does not exist or is not accessible: -1 |
      | [0].errorCode | NOT_FOUND                                                          |
