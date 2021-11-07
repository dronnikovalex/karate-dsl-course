
Feature: Article

  Background: Define url
    Given url apiUrl
    * def articleFixture = read('classpath:ConduitApp/json/article.json')
    * def DataGenerator = Java.type('helpers.DataGenerator')
    * set articleFixture.article.title = DataGenerator.getRandomArticle().title
    * set articleFixture.article.description = DataGenerator.getRandomArticle().description
    * set articleFixture.article.body = DataGenerator.getRandomArticle().body

  Scenario: Create a New Article
    Given path 'articles'
    And request articleFixture
    When method Post
    Then status 200
    And match response.article.title == articleFixture.article.title

  Scenario: Crete and Delete existed article
    Given path 'articles'
    And request articleFixture
    When method Post
    Then status 200 
    * def articleId = response.article.slug

    # получаем список статей и забираем slug созданной статьи
    Given path 'articles'
    Given params { limit: 10, offset: 0 }
    When method Get
    Then status 200
    And match response.articles[0].title == articleFixture.article.title

    # удаляем статью
    Given path 'articles', articleId
    When method Delete
    Then status 204
    
    # Проверяем, что в списке статей больше нету удаленной статьи
    Given path 'articles'
    Given params { limit: 10, offset: 0 }
    When method Get
    Then status 200
    And match response.articles[0].title != articleFixture.article.title

