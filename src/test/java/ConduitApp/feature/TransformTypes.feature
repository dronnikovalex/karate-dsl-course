
Feature: Transform type
  Scenario: number to string
    # will fail
    * def foo = 10
    * def json = {"bar": #(foo+'')}
    * match json == {"bar": '10'}
  Scenario: String to Number
    * def foo = '10'
    * def json = {"bar": #(parseInt(foo))}
    * match json == {"bar": 10}