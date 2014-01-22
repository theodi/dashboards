Feature: Company Dashboard

  Scenario: Company dashboard should appear at '/'
    When I visit "/"
    Then I should see "Company Dashboard"

  Scenario: Company dashboard should appear at '/2013_company'
    When I visit "/2013_company"
    Then I should see "Company Dashboard"