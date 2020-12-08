Feature: Trying to access to an Lead without authorization
  The user is not authenticated

  Background: Does not set authentication
    Given The user does not set valid authentication to request

  @negative
  Scenario: Verify that is not possible to create an lead when the user is not authorized
    When The user sends a POST request to "/Lead" with the following Json data
      """
      {
        "Name" : "Express Logistics and Transport"
      }
      """
    Then verifies response should have the "401" status code
    And verifies response should contain the following values
      | [0].message   | Session expired or invalid |
      | [0].errorCode | INVALID_SESSION_ID         |

  @negative @createLead @deleteLead
  Scenario: Verify that is not possible to retrieve information of an lead when the user is not authorized
    When The user sends a GET request to "/Lead/{recordId}" with the following Json data
    Then verifies response should have the "401" status code
    And verifies response should contain the following values
      | [0].message   | Session expired or invalid |
      | [0].errorCode | INVALID_SESSION_ID         |

  @negative @createLead @deleteLead
  Scenario: Verify that is not possible to edit the information of an lead when the user is not authorized
    When The user sends a PATCH request to "/Lead/{recordId}" with the following Json data
     """
      {
        "Name" : "New name to Lead"
      }
      """
    Then verifies response should have the "401" status code
    And verifies response should contain the following values
      | [0].message   | Session expired or invalid |
      | [0].errorCode | INVALID_SESSION_ID         |

  @negative @createLead @deleteLead
  Scenario: Verify that is not possible to delete an lead when the user is not authorized
    And The user sends a DELETE request to "/Lead/{recordId}" with the following Json data
    Then verifies response should have the "401" status code
    And verifies response should contain the following values
      | [0].message   | Session expired or invalid |
      | [0].errorCode | INVALID_SESSION_ID         |