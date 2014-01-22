Feature: Company Dashboard

  Scenario: Company dashboard should appear at '/'
    When I visit "/"
    Then I should see "Company Dashboard"

  Scenario: Company dashboard should appear at '/2013/company'
    When I visit "/2013/company"
    Then I should see "Company Dashboard"