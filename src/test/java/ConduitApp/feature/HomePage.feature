Feature: Tests for the home page
  
  Background: Define url for tests
    Given url apiUrl  
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * def randomComment = read('classpath:helpers/timeValidator.js')

  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['article', 'story']
    And match response.tags contains any ['Article4', 'Article5']
    And match response.tags !contains 'kek'
    And match response.tags == "#array"
    And match each response.tags == "#string"

  Scenario: Get all articles
    Given path 'articles'
    Given params { limit: 10, offset: 0 }
    When method Get
    Then status 200
    And match response == { "articles": "#array", "articlesCount": "#number" }
    And match response.articles == '#[10]'
    And match response.articlesCount != 500
    # bio может быть строкой или null 
    And match each response..bio == "##string" 
    And match each response..following == "#boolean"
    And match response.articles[0].createdAt contains '2021'
    And match response.articles[*].favoritesCount contains 1
    And match each response.articles == 
    """
      {
          "slug": "#string",
          "title": "#string",
          "description": "#string",
          "body": "#string",
          "createdAt": "#? timeValidator(_)",
          "updatedAt": "#? timeValidator(_)",
          "tagList": "#array",
          "favorited": "#boolean",
          "favoritesCount": "#number",
          "author": {
              "username": "#string",
              "bio": "##string",
              "image": "#string",
              "following": "#boolean"
          }
      },
    """

  