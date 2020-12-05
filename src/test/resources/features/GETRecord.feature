Feature: Get Record
  In order to update a record in salesforce
  Authenticated as a valid SaleForce consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createAccount @deleteAccount
  Scenario: Verifies record is updated with the required parameters
    When selects the record sending request to "/Account/{recordId}" with the following Json data
    Then verifies response should have the "200" status code
    And verifies response body should match with "common/messageAccountGetResponse.json" JSON schema
    And verifies response should contain the following values
      | IsDeleted | false |
