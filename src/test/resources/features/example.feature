Feature: Example
  @createAccount
  Scenario: Test createUser Hook and dependency injection
    When the user sends a GET request to "Account/{accountId}"
    Then verifies response should have the "200" status code
