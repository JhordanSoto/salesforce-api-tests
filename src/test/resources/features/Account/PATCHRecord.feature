Feature: Update Record
  In order to update a record in salesforce
  Authenticated as a valid SaleForce consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createAccount @deleteAccount
  Scenario: Verifies record is updated with the required parameters
    When The user sends a PATCH request to "/Account/{recordId}" with the following Json data
      """
      {
        "BillingCity" : "San Francisco"
      }
      """
    Then verifies response should have the "204" status code

  @negative
  Scenario: Verify that is not possible to update the campaign information using an invalid id
    When The user sends a PATCH request to "/Account/-1" with the following Json data
      """
      {
        "Name" : "New name to Account"
      }
      """
    Then verifies response should have the "404" status code
    And verifies response body should match with "common/notFoundResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Provided external ID field does not exist or is not accessible: -1 |
      | [0].errorCode | NOT_FOUND                                                          |

  @negative  @createAccount
  Scenario: Verifies record is not created without JSON parameters
    When The user sends a PATCH request to "/Account/{recordId}" with the following Json data
    """

    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "common/messageErrorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | The HTTP entity body is required, but this request has no entity body. |
      | [0].errorCode | JSON_PARSER_ERROR                                                      |