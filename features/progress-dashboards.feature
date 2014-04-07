Feature: Progress Dashboard

  Scenario: Should redirect to current year and quarter
    Given the date is is "2014-02-01"
    When I visit "/progress"
    Then I should see "Progress 2014 Q1"

  Scenario: Should redirect to current quarter
    Given the date is is "2014-02-01"
    When I visit "/progress/2014"
    Then I should see "Progress 2014 Q1"
