@ignore
Feature: Tests for the home page
  
  Background: Define url for tests
    Given url apiUrl  

  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['article', 'story']
    And match response.tags !contains 'kek'
    And match response.tags == "#array"
    And match each response.tags == "#string"

  Scenario: Get all articles
    Given path 'articles'
    Given params { limit: 10, offset: 0 }
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 13


  