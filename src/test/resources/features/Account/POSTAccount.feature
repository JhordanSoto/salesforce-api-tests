Feature: Create Account
  In order to create an account in salesforce
  Authenticated as valid SaleForce consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @deleteAccount
  Scenario: Verify that an account is created with minimum required parameters
    When The user sends a POST request to "/Account" with the following Json data
      """
      {
        "Name" : "Express Logistics and Transport"
      }
      """
    And the record id is saved
    Then verifies response should have the "201" status code
    And verifies response body should match with "Account/messageAccountPostResponse.json" JSON schema
    And verifies response should contain the following values
      | success | true |


  @negative
  Scenario: Verify that an account is not created without JSON parameters
    When The user sends a POST request to "/Account" with the following Json data
    """

    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "Account/messageErrorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | The HTTP entity body is required, but this request has no entity body. |
      | [0].errorCode | JSON_PARSER_ERROR                                                      |

  @functional @deleteAccount
  Scenario: Verify that an account is created with special characters parameters
    When The user sends a POST request to "/Account" with the following Json data
      """
      {
        "Name" : "$!@"
      }
      """
    And the record id is saved
    Then verifies response should have the "201" status code
    And verifies response body should match with "Account/messageAccountPostResponse.json" JSON schema
    And verifies response should contain the following values
      | success | true |