@debug
Feature: Article

  Background: Define url
    Given url apiUrl

  Scenario: Create a New Article
    Given path 'articles'
    And request {article: {title: "Article12", description: "Article12", body: "Article12", tagList: ["Article12"]}}
    When method Post
    Then status 200
    And match response.article.title == 'Article12'

  Scenario: Crete and Delete existed article
    Given path 'articles'
    And request {article: {title: "ArticleToDelete", description: "ArticleToDelete", body: "ArticleToDelete", tagList: ["ArticleToDelete"]}}
    When method Post
    Then status 200 
    * def articleId = response.article.slug

    # получаем список статей и забираем slug созданной статьи
    Given path 'articles'
    Given params { limit: 10, offset: 0 }
    When method Get
    Then status 200
    And match response.articles[0].title == "ArticleToDelete"

    # удаляем статью
    Given path 'articles', articleId
    When method Delete
    Then status 204
    
    # Проверяем, что в списке статей больше нету удаленной статьи
    Given path 'articles'
    Given params { limit: 10, offset: 0 }
    When method Get
    Then status 200
    And match response.articles[0].title != "ArticleToDelete"

