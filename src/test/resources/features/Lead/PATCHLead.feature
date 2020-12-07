Feature: Update Lead

  In order to update a Lead in Salesforce
  Authenticated as valid Salesforce API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createLead @deleteLead
  Scenario: Verify that is possible to update the lead information
    When The user sends a PATCH request to "/Lead/{recordId}" with the following Json data
      """
      {
        "LastName": "Mulroney",
        "Company": "KlondikeQuarry"
      }
      """
    Then verifies response should have the "204" status code

  @functional @createLead @deleteLead
  Scenario: Verify that is possible to update information with LastName with special characters
    When The user sends a PATCH request to "/Lead/{recordId}" with the following Json data
      """
      {
        "LastName": "Mulroney%%",
        "Company": "KlondikeQuarry"
      }
      """
    Then verifies response should have the "204" status code


  @negative @createLead @deleteLead
  Scenario: Verify that is not possible to update the lead information with empty values
    When The user sends a PATCH request to "/Lead/{recordId}" with the following Json data
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

  @negative @createLead @deleteLead
  Scenario: Verify that is not possible to update the lead information with name with blank spaces
    When The user sends a PATCH request to "/Lead/{recordId}" with the following Json data
    """
    {
      "LastName": " ",
      "Company": " "
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "Lead/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Faltan campos obligatorios: [LastName, Company] |
      | [0].errorCode | REQUIRED_FIELD_MISSING                          |
      | [0].fields    | [LastName, Company]                             |

  @negative @createLead @deleteLead
  Scenario: Verify that is not possible to update the lead information with name with more than 80 characters
    When The user sends a PATCH request to "/Lead/{recordId}" with the following Json data
    """
    {
      "LastName": "Update a Lead that exists with name with more than 80 characters would be get a message error instead a success",
      "Company": "Company Test"
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "Lead/tooLongResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Apellidos: valor de datos demasiado grande: Update a Lead that exists with name with more than 80 characters would be get a message error instead a success (max length=80) |
      | [0].errorCode | STRING_TOO_LONG                                                                                                                                                             |
      | [0].fields    | [LastName]                                                                                                                                                                  |

  @negative @createLead @deleteLead
  Scenario: Verify that is not possible to update the lead information using an invalid id
    When The user sends a PATCH request to "/Lead/-1" with the following Json data
      """
      {
        "LastName": "Mulroney",
        "Company": "KlondikeQuarry"
      }
      """
    Then verifies response should have the "404" status code
    And verifies response body should match with "common/notFoundResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Provided external ID field does not exist or is not accessible: -1 |
      | [0].errorCode | NOT_FOUND                                                          |