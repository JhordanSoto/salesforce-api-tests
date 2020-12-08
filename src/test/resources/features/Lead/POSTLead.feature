Feature: Create Lead

  In order to create a Lead in Salesforce
  Authenticated as valid Salesforce API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @deleteLead
  Scenario: Verify lead is created with minimum required parameters
    When The user sends a POST request to "/Lead" with the following Json data
      """
      {
        "LastName": "Mulroney",
        "Company": "KlondikeQuarry"
       }
      """
    And the record id is saved
    Then verifies response should have the "201" status code
    And verifies response body should match with "Lead/successResponse.json" JSON schema
    And verifies response should contain the following values
      | success | true |
      | errors  | []   |

  @negative
  Scenario: Verify that is not possible to create a new lead with empty values
    When The user sends a POST request to "/Lead" with the following Json data
    """
    {
      "LastName": "",
      "Company": ""
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "Lead/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Faltan campos obligatorios: [LastName, Company] |
      | [0].errorCode | REQUIRED_FIELD_MISSING                          |
      | [0].fields    | [LastName, Company]                             |

  @negative
  Scenario: Verify that is not possible to create a new lead with Company with blank spaces
    When The user sends a POST request to "/lead" with the following Json data
    """
    {
      "LastName": "Mulroney",
      "Company": " "
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "Lead/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Faltan campos obligatorios: [Company] |
      | [0].errorCode | REQUIRED_FIELD_MISSING                |
      | [0].fields    | [Company]                             |


  @negative
  Scenario: Verify that is not possible to create a new lead with LastName with blank spaces
    When The user sends a POST request to "/lead" with the following Json data
    """
    {
      "LastName": "",
      "Company": "KlondikeQuarry"
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "Lead/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Faltan campos obligatorios: [LastName] |
      | [0].errorCode | REQUIRED_FIELD_MISSING                 |
      | [0].fields    | [LastName]                             |

  @negative
  Scenario: Verify that is not possible to create a new campaign with name with more than 80 characters
    When The user sends a POST request to "/Lead" with the following Json data
    """
    {
      "LastName": "Create a new Lead with name with more than 80 characters would be get a message error instead a success",
      "Company": "new Company"
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "Lead/tooLongResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Apellidos: valor de datos demasiado grande: Create a new Lead with name with more than 80 characters would be get a message error instead a success (max length=80) |
      | [0].errorCode | STRING_TOO_LONG                                                                                                                                                      |
      | [0].fields    | [LastName]                                                                                                                                                           |

