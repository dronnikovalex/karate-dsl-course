
Feature: Hooks
  #Все что помещено в Background секции, будет выполнено перед каждым Scenario
  Background: before
    # Выполняется один раз
    # * def result = callonce read('classpath:helpers/Dummy.feature')
    # Будет выполнено перед каждым Scenario
    # * def result = call read('classpath:helpers/Dummy.feature')
    # * def username = result.randomUsername
    
    # after hooks
    * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature'); }   
    * configure afterFeature = 
    """
      function() { 
        karate.log('kek')
      }   
    """ 
  Scenario: First scenario'
    * print 'First scenario'   
    # * print username
  Scenario: Second scenario'
    * print 'Second scenario' 
    # * print username 