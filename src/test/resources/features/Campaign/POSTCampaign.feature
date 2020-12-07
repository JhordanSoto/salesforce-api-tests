Feature: Create Campaign

  In order to create a Campaign in Salesforce
  Authenticated as valid Salesforce API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional
  Scenario: Verify campaign is created with minimum required parameters
    When The user sends a POST request to "/Campaign" with the following Json data
      """
      {
        "Name" : "New Campaigne"
      }
      """
    Then verifies response should have the "201" status code
    And verifies response body should match with "Campaign/successResponse.json" JSON schema
    And verifies response should contain the following values
      | success | true |
      | errors  | []   |

  @negative
  Scenario: Verify that is not possible to create a new campaign with empty values
    When The user sends a POST request to "/Campaign" with the following Json data
    """
    {
      "Name" : " "
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "Campaign/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Faltan campos obligatorios: [Name] |
      | [0].errorCode | REQUIRED_FIELD_MISSING             |
      | [0].fields    | [Name]                             |

  @negative
  Scenario: Verify that is not possible to create a new campaign with name with blank spaces
    When The user sends a POST request to "/Campaign" with the following Json data
    """
    {
      "Name" : "  "
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "Campaign/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Faltan campos obligatorios: [Name] |
      | [0].errorCode | REQUIRED_FIELD_MISSING             |
      | [0].fields    | [Name]                             |

  @negative
  Scenario: Verify that is not possible to create a new campaign with name with more than 80 characters
    When The user sends a POST request to "/Campaign" with the following Json data
    """
    {
      "Name" : "Create a new campaign with more than 80 characters would be get a message error instead a success"
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "Campaign/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Nombre: valor de datos demasiado grande: Create a new campaign with more than 80 characters would be get a message error instead a success (max length=80) |
      | [0].errorCode | STRING_TOO_LONG                                                                                                                                            |
      | [0].fields    | [Name]                                                                                                                                                     |

  @functional
  Scenario: Verify campaign is created with special characters in the name
    When The user sends a POST request to "/Campaign" with the following Json data
      """
      {
        "Name" : "New _+@%^''./,"
      }
      """
    Then verifies response should have the "201" status code
    And verifies response body should match with "Campaign/successResponse.json" JSON schema
    And verifies response should contain the following values
      | success | true |
      | errors  | []   |

  @functional
  Scenario: Verifies is not possible to create a campaign when the user is not authorized
    When The user does not set valid authentication to request
    And The user sends a POST request to "/Campaign" with the following Json data
      """
      {
        "Name" : "Express Logistics and Transport"
      }
      """
    Then verifies response should have the "401" status code
    And verifies response should contain the following values
      | [0].message   | Session expired or invalid |
      | [0].errorCode | INVALID_SESSION_ID         |
