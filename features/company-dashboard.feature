Feature: Company Dashboard

  Scenario: root should redirect to 2013 performance dashboard
    When I visit "/"
    Then I should see "2014 Performance"

  Scenario: '/company' should redirect to 2013 performance dashboard
    When I visit "/company"
    Then I should see "2014 Performance"

  Scenario: 2013 performance dashboard should appear at '/company/2013'
    When I visit "/company/2013"
    Then I should see "2013 Performance"

  Scenario: 2014 performance dashboard should appear at '/company/2014'
    When I visit "/company/2014"
    Then I should see "2014 Performance"

  Scenario: 2015 performance dashboard should appear at '/company/2015'
    When I visit "/company/2015"
    Then I should see "2015 Performance"

  Scenario: Cumulative dashboard should appear at /company/all
    When I visit "/company/all"
    Then I should see "Lifetime impact"
