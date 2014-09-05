#!/bin/env ruby
# encoding: utf-8

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  send_event 'Diversity-gender-total', value: DiversityDashboard.gender_total
  send_event 'Diversity-gender-board', value: DiversityDashboard.gender_board
  send_event 'Diversity-gender-smt', value: DiversityDashboard.gender_smt
  send_event 'Diversity-gender-commercial', value: DiversityDashboard.gender_commercial
  send_event 'Diversity-gender-international', value: DiversityDashboard.gender_international
  send_event 'Diversity-gender-operations', value: DiversityDashboard.gender_operations
  send_event 'Diversity-gender-technical', value: DiversityDashboard.gender_technical
end