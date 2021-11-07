Feature: HomeWork

  Background: 
    Given url apiUrl
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * def DataGenerator = Java.type('helpers.DataGenerator')
    * def rndComment = read('classpath:ConduitApp/json/comment.json')
    * set rndComment.comment.body = DataGenerator.randomComment()

  Scenario: Add article to favourite
    # Получаем список артиклей
    Given path 'articles'
    Given params { limit: 10, offset: 0 }
    When method Get
    Then status 200
    # Сохраняем в переменные slug и favouriteCount для первой статьи
    * def articleSlug = response.articles[0].slug
    * def initialCount = response.articles[0].favoritesCount
    # Добавляем первую статью в избранное
    Given path 'articles/', articleSlug ,'/favorite'
    When method POST
    Then status 200
    And match response.article == 
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
      }
    """
    And match response.article.favoritesCount == initialCount
    # Дергаем список избранного и проверяем, что в нем есть помеченная избранная статья
    Given path 'articles'
    Given params { limit: 10, offset: 0, favorited: ss }
    When method Get
    Then status 200
    And match response.articles[*].slug contains articleSlug

  @debug
  Scenario: Commnet article
    Given path 'articles'
    Given params { limit: 10, offset: 0 }
    When method Get
    Then status 200
    # Сохраняем в переменные slug для первой статьи
    * def articleSlug = response.articles[0].slug

    # Оставляем коммент под статьей
    Given path 'articles/', articleSlug, '/comments'
    And request rndComment
    When method Post
    Then status 200

    # Дергаем список комментов, валидируем схему и сохраняем количество комментов в переменную
    Given path 'articles/', articleSlug, '/comments'
    When method Get
    Then status 200
    And match each response.comments ==
    """
      {
        "id": "#number",
        "body": "#string",
        "createdAt": "#? timeValidator(_)",
        "updatedAt": "#? timeValidator(_)",
        "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string",
            "following": "#boolean"
        }
      }
    """
    * def initialCommentCount = response.comments.length

    #Публикуем новый коммент
    * set rndComment.comment.body = DataGenerator.randomComment()
    Given path 'articles/', articleSlug, '/comments'
    And request rndComment
    When method Post
    Then status 200
    And match response.comment.body == rndComment.comment.body
    #Сохраянм id коммента для последующего удаления
    * def commentId = response.comment.id

    #Дергаем список комментов и проверяем, что их количество увеличелось на 1
    Given path 'articles/', articleSlug, '/comments'
    When method Get
    Then status 200
    * def currentCommentCount = response.comments.length
    And match currentCommentCount == initialCommentCount + 1

    #Удаляем статью
    Given path 'articles/', articleSlug, '/comments', commentId
    When method Delete
    Then status 204

    #Дергаем список комментов и проверяем, что их количество уменьшилось на 1
    Given path 'articles/', articleSlug, '/comments'
    When method Get
    Then status 200
    * def currentCommentCount = response.comments.length
    And match currentCommentCount == initialCommentCount