Feature: Article

Background: Define url
  Given url apiUrl
  * def articleFixture = read('classpath:ConduitApp/json/article.json')
  * def DataGenerator = Java.type('helpers.DataGenerator')
  * set articleFixture.article.title = DataGenerator.getRandomArticle().title
  * set articleFixture.article.description = DataGenerator.getRandomArticle().description
  * set articleFixture.article.body = DataGenerator.getRandomArticle().body

  # Инициализация переменной для возможности выставлять delay между командами
  * def sleep = function(ms) { java.lang.Thread.sleep(ms) }
  * def pause = karate.get('__gatling.pause', sleep) 
Scenario: Create a New Article
  Given path 'articles'
  And request articleFixture
  And header karate-name = 'Requested title:' + articleFixture.article.title
  When method Post
  Then status 200
  And match response.article.title == articleFixture.article.title
  * def articleId = response.article.slug

  * pause(5000)

  Given path 'articles', articleId
  When method Delete
  Then status 204
