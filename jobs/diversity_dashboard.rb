#!/bin/env ruby
# encoding: utf-8

schedule do
  send_event 'Diversity-gender-total', value: DiversityDashboard.gender_total
end

schedule do
  send_event 'Diversity-gender-board', value: DiversityDashboard.gender_board
end

schedule do
  send_event 'Diversity-gender-leadership', value: DiversityDashboard.gender_leadership
end

schedule do
  send_event 'Diversity-gender-international', value: DiversityDashboard.gender_international
end

schedule do
  send_event 'Diversity-gender-core', value: DiversityDashboard.gender_core
end

schedule do
  send_event 'Diversity-gender-innovation', value: DiversityDashboard.gender_innovation
end
