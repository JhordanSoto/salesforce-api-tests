Feature: Create Campaign

  In order to create a Campaign in Salesforce
  Authenticated as valid Salesforce API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @deleteCampaign
  Scenario: Verify campaign is created with minimum required parameters
    When the user sends a POST request to "/Campaign" with the following Json data
      """
      {
        "Name" : "New Campaigne"
      }
      """
    Then verifies response should have the "201" status code
    And verifies response body should match with "common/successResponse.json" JSON schema
    And verifies response should contain the following values
      | success | true |
      | errors  | []   |

  @negative
  Scenario: Verify that is not possible to create a new campaign with empty values
    When the user sends a POST request to "/Campaign" with the following Json data
    """
    {
      "Name" : " "
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "common/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Faltan campos obligatorios: [Name] |
      | [0].errorCode | REQUIRED_FIELD_MISSING             |
      | [0].fields    | [Name]                             |

  @negative
  Scenario: Verify that is not possible to create a new campaign with name with blank spaces
    When the user sends a POST request to "/Campaign" with the following Json data
    """
    {
      "Name" : "  "
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "common/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Faltan campos obligatorios: [Name] |
      | [0].errorCode | REQUIRED_FIELD_MISSING             |
      | [0].fields    | [Name]                             |

  @negative
  Scenario: Verify that is not possible to create a new campaign with name with more than 80 characters
    When the user sends a POST request to "/Campaign" with the following Json data
    """
    {
      "Name" : "Create a new campaign with more than 80 characters would be get a message error instead a success"
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "common/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Nombre: valor de datos demasiado grande: Create a new campaign with more than 80 characters would be get a message error instead a success (max length=80) |
      | [0].errorCode | STRING_TOO_LONG                                                                                                                                            |
      | [0].fields    | [Name]                                                                                                                                                     |

  @functional @deleteCampaign
  Scenario: Verify campaign is created with special characters in the name
    When the user sends a POST request to "/Campaign" with the following Json data
      """
      {
        "Name" : "New _+@%^''./,"
      }
      """
    Then verifies response should have the "201" status code
    And verifies response body should match with "common/successResponse.json" JSON schema
    And verifies response should contain the following values
      | success | true |
      | errors  | []   |

