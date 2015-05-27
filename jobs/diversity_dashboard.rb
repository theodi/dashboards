#!/bin/env ruby
# encoding: utf-8

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  send_event 'Diversity-gender-total', value: DiversityDashboard.gender_total
  send_event 'Diversity-gender-board', value: DiversityDashboard.gender_board
  send_event 'Diversity-gender-leadership', value: DiversityDashboard.gender_leadership
  send_event 'Diversity-gender-international', value: DiversityDashboard.gender_international
  send_event 'Diversity-gender-core', value: DiversityDashboard.gender_core
  send_event 'Diversity-gender-innovation', value: DiversityDashboard.gender_innovation
end
