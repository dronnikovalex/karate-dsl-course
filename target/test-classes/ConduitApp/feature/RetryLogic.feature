
Feature: Retry

  Background:
    Given url apiUrl
  Scenario: Retry call
    # configuring retry ability
    * configure retry = { count: 10, interval: 5000 }

    Given path 'articles'
    Given params { limit: 10, offset: 0 }
    # configuration for retry should be place BEFORE declaring method type
    And retry until response.articles[0].favoritesCount == 1
    When method Get 
    Then status 200

  Scenario: Sleep call
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

    Given path 'articles'
    Given params { limit: 10, offset: 0 }
    When method Get 
    # Will wait for 5 sec before moving to status check
    * eval sleep(5000)
    Then status 200