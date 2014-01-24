Feature: Company Dashboard

  Scenario: 2013 Company dashboard should appear at '/'
    When I visit "/"
    Then I should see "2013 Company Dashboard"

  Scenario: 2013 Company dashboard should appear at '/company/2013'
    When I visit "/company/2013"
    Then I should see "2013 Company Dashboard"
    
  Scenario: 2014 Company dashboard should appear at '/company/2014'
    When I visit "/company/2014"
    Then I should see "2014 Company Dashboard"

  Scenario: Cumulative dashboard should appear at /company/all
    When I visit "/company/all"
    Then I should see "Lifetime Company Dashboard"