Feature: Company Dashboard

  Scenario: root should redirect to 2013 company dashboard
    When I visit "/"
    Then I should see "2014 Company"

  Scenario: '/company' should redirect to 2013 company dashboard
    When I visit "/company"
    Then I should see "2014 Company"

  Scenario: 2014 Company dashboard should appear at '/company/2014'
    When I visit "/company/2014"
    Then I should see "2014 Company"

  Scenario: 2014 Company dashboard should appear at '/company/2014'
    When I visit "/company/2013"
    Then I should see "2013 Company"

  Scenario: Cumulative dashboard should appear at /company/all
    When I visit "/company/all"
    Then I should see "Lifetime Company"
