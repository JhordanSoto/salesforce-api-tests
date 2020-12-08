Feature: List Campaigns

  In order to List Campaigns in Salesforce
  Authenticated as valid Salesforce API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional
  Scenario: Verify that is possible to retrieve all campaigns as list
    When The user sends a GET request to "/Campaign" with the following Json data
    Then verifies response should have the "200" status code

  @functional @createCampaign @deleteCampaign
  Scenario: Verify that is possible to retrieve information of a campaign
    When The user sends a GET request to "/Campaign/{recordId}" with the following Json data
    Then verifies response should have the "200" status code

  @negative
  Scenario: Verify that is not possible to retrieve information of a campaign using a invalid id
    When The user sends a GET request to "/Campaign/-1" with the following Json data
    Then verifies response should have the "404" status code
    And verifies response body should match with "Campaign/notFoundResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Provided external ID field does not exist or is not accessible: -1 |
      | [0].errorCode | NOT_FOUND                                                          |