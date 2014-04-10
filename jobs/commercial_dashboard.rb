#!/bin/env ruby
# encoding: utf-8

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  send_event('members', { current: CommercialDashboard.members, currency: "GBP" })
  send_event('age', { current: CommercialDashboard.age, suffix: " days" })
  send_event('old-opportunities', { current: CommercialDashboard.old_opportunities })
  send_event('pipeline', { current: CommercialDashboard.pipeline, currency: "GBP" })
  send_event('weighted-pipeline', { current: CommercialDashboard.weighted, currency: "GBP" })
  send_event('three-year-pipeline', { current: CommercialDashboard.three_year, currency: "GBP" })
end
