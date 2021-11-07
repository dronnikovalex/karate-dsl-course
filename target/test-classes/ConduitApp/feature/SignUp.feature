
Feature: Client SignUp
  Background:
    Given url apiUrl
    * def userData = Java.type('helpers.DataGenerator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * def randomEmail = userData.getRandomEmail()
    * def randomUsername = userData.getRandomUsername()

  Scenario: Client SignUp
    Given path 'users'
    And request 
    """
      {
        "user": {
          "username": #(randomUsername),
          "email": #(randomEmail),
          "password": "test"
        }
      }
    """
    When method Post
    Then status 200
    And match response == 
    """
      {
        "user": {
          "username": #(randomUsername),
          "email": #(randomEmail),
          "token": "#string",
          "bio": "#string",
          "image": "#string"
        }
      }
    """

  Scenario Outline: SignUp with wrong user data
    Given path 'users'
    And request 
    """
      {
        "user": {
          "username": <username>,
          "email": <email>,
          "password": <password>
        }
      }
    """
    When method Post
    Then status 404
    And match response == <errResponse>

    Examples:
      | username           | email           | password | errResponse                       |
      | newuser            | #(randomEmail)  | test     | "error: 404 Not Found /api/users" |
      | #(randomUsername)  | newuser@mail.ru | test     | "error: 404 Not Found /api/users" |
      | #(randomUsername)  | newuser@mail.ru | ""       | "error: 404 Not Found /api/users" |
      | #(randomUsername)  | ""              | test     | "error: 404 Not Found /api/users" |
      | ""                 | #(randomEmail)  | test     | "error: 404 Not Found /api/users" |
      | a                  | #(randomEmail)  | test     | "error: 404 Not Found /api/users" |
      | #(randomUsername)  | s               | test     | "error: 404 Not Found /api/users" |