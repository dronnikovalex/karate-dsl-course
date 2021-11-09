
Feature: working with Db
  Background: 
    * def DbHandler = Java.type('helpers.DbHandler')
  Scenario: Seed database with a new item
    * eval DbHandler.addNewPerson("KEks")
  @debug
  Scenario: Get min and max salary
    * def salary = DbHandler.getSalary("KEks")

    And match salary.minSalary == '40000'
    And match salary.maxSalary == '60000'
