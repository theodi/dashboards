Feature: Company Dashboard

  Scenario: 2014 Company dashboard should appear at '/'
    When I visit "/"
    Then I should see "2014 Company Dashboard"

  Scenario: 2013 Company dashboard should appear at '/2013_company'
    When I visit "/2013_company"
    Then I should see "2013 Company Dashboard"
    
  Scenario: 2014 Company dashboard should appear at '/2014_company'
    When I visit "/2014_company"
    Then I should see "2014 Company Dashboard"