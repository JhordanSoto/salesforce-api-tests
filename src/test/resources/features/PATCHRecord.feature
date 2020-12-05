Feature: Update Record
  In order to update a record in salesforce
  Authenticated as a valid SaleForce consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createAccount @deleteAccount
  Scenario: Verify record is updated with the required parameters
    When Update the record sending request to "/Account/{recordId}" with the following Json data
      """
      {
        "BillingCity" : "San Francisco"
      }
      """
    Then verifies response should have the "204" status code


  @negative  @createAccount
  Scenario: Verify record is not created without JSON parameters
    When Update the record sending request to "/Account/{recordId}" with the following Json data
    """

    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "common/messageErrorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | The HTTP entity body is required, but this request has no entity body. |
      | [0].errorCode | JSON_PARSER_ERROR                                                      |