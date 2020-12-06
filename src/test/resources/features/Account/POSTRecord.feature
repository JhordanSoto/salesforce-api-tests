Feature: Create Record
  In order to create a record in salesforce
  Authenticated as valid SaleForce consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional
  Scenario: Verifies record is created with minimum required parameters
    When The user sends a POST request to "/Account" with the following Json data
      """
      {
        "Name" : "Express Logistics and Transport"
      }
      """
    Then verifies response should have the "201" status code
    And verifies response body should match with "common/messageAccountPostResponse.json" JSON schema
    And verifies response should contain the following values
      | success | true |


  @negative
  Scenario: Verifies record is not created without JSON parameters
    When The user sends a POST request to "/Account" with the following Json data
    """

    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "common/messageErrorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | The HTTP entity body is required, but this request has no entity body. |
      | [0].errorCode | JSON_PARSER_ERROR                                                      |

  @functional
  Scenario: Verifies record is created with special characters parameters
    When The user sends a POST request to "/Account" with the following Json data
      """
      {
        "Name" : "$!@"
      }
      """
    Then verifies response should have the "201" status code
    And verifies response body should match with "common/messageAccountPostResponse.json" JSON schema
    And verifies response should contain the following values
      | success | true |
