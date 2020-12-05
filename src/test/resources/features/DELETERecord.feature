Feature: Delete Record
  In order to delete a record in salesforce
  Authenticated as a valid SaleForce consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createAccount
  Scenario: Verify record is updated with the required parameters
    When Delete the record sending request to "/Account/{recordId}" with the following Json data
    Then verifies response should have the "204" status code
    When  select the record sending request to "/Account/{recordId}" with the following Json data
    Then verifies response should have the "404" status code