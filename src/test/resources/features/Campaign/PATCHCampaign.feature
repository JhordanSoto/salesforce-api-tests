Feature: Update Campaign

  In order to update a Campaign in Salesforce
  Authenticated as valid Salesforce API consumer

  Background: Sets authentication
    Given the user sets valid authentication to request

  @functional @createCampaign @deleteCampaign
  Scenario: Verify that is possible to update the campaign information
    When the user sends a PATCH request to "/Campaign/{recordId}" with the following Json data
      """
      {
        "Name" : "New name to Campaign"
      }
      """
    Then verifies response should have the "204" status code

  @negative
  Scenario: Verify that is not possible to update the campaign information using an invalid id
    When the user sends a PATCH request to "/Campaign/-1" with the following Json data
      """
      {
        "Name" : "New name to Campaign"
      }
      """
    Then verifies response should have the "404" status code
    And verifies response body should match with "common/notFoundResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Provided external ID field does not exist or is not accessible: -1 |
      | [0].errorCode | NOT_FOUND                                                          |

  @functional @createCampaign @deleteCampaign
  Scenario: Verify that is possible to update information with name with special characters
    When the user sends a PATCH request to "/Campaign/{recordId}" with the following Json data
      """
      {
        "Name" : "New _+@%^''./,"
      }
      """
    Then verifies response should have the "204" status code


  @negative @createCampaign @deleteCampaign
  Scenario: Verify that is not possible to update the campaign information with empty values
    When the user sends a PATCH request to "/Campaign/{recordId}" with the following Json data
    """
    {
      "Name" : ""
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "common/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Faltan campos obligatorios: [Name] |
      | [0].errorCode | REQUIRED_FIELD_MISSING             |
      | [0].fields    | ["Name"]                           |

  @negative @createCampaign @deleteCampaign
  Scenario: Verify that is not possible to update the campaign information with name with blank spaces
    When the user sends a PATCH request to "/Campaign/{recordId}" with the following Json data
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
      | [0].fields    | ["Name"]                           |

  @negative @createCampaign @deleteCampaign
  Scenario: Verify that is not possible to update the campaign information with name with more than 80 characters
    When the user sends a PATCH request to "/Campaign/{recordId}" with the following Json data
    """
    {
      "Name" : "Upadate information of a campaign with more than 80 characters would be get a message error instead a success"
    }
    """
    Then verifies response should have the "400" status code
    And verifies response body should match with "common/errorResponse.json" JSON schema
    And verifies response should contain the following values
      | [0].message   | Nombre: valor de datos demasiado grande: Upadate information of a campaign with more than 80 characters would be get a message error instead a success (max length=80) |
      | [0].errorCode | STRING_TOO_LONG                                                                                                                                                        |
      | [0].fields    | [Name]                                                                                                                                                                 |
