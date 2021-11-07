Feature: Dummy
  Scenario: Dummy
    * def DataGenerator = Java.type('helpers.DataGenerator')
    * def username = DataGenerator.getRandomUsername()
    * print username