Feature: Company Dashboard

  Scenario: '/company' appears at '/'
    When I visit "/"
    Then I should see "Company Dashboard"