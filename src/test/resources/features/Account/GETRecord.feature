Feature: Get Record
  In order to update a record in salesforce
  Authenticated as a valid SaleForce consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createAccount @deleteAccount
  Scenario: Verifies record is retrieve with the required parameters
    When The user sends a GET request to "/Account/{recordId}" with the following Json data
    Then verifies response should have the "200" status code
    And verifies response body should match with "common/messageAccountGetResponse.json" JSON schema
    And verifies response should contain the following values
      | IsDeleted | false |

  @functional @createAccount @deleteAccount
  Scenario: Verify that is possible to retrieve information of an account
    When The user sends a GET request to "/Account/{recordId}" with the following Json data
    Then verifies response should have the "200" status code

  @negative
  Scenario: Verify that is not possible to retrieve information of an account using a invalid id
    When The user sends a GET request to "/Account/-1" with the following Json data
    Then verifies response should have the "404" status code
    And verifies response body should match with "common/notFoundResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Provided external ID field does not exist or is not accessible: -1 |
      | [0].errorCode | NOT_FOUND                                                          |