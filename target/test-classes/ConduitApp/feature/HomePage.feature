Feature: Tests for the home page

  Scenario: Get all tags
    Given url 'http://localhost:3000/api/tags'
    When method Get
    Then status 200
  
  Scenario: Get all articles
    Given url 'http://localhost:3000/api/articles'
    Given params { limit: 10, offset: 0 }
    When method Get
    Then status 200


  