#!/bin/env ruby
# encoding: utf-8

schedule do
  send_event('members', { current: CommercialDashboard.members, currency: "GBP" })
end

schedule do
  send_event('age', { current: CommercialDashboard.age, suffix: " days" })
end

schedule do
  send_event('old-opportunities', { current: CommercialDashboard.old_opportunities })
end

schedule do
  send_event('pipeline', { current: CommercialDashboard.pipeline, currency: "GBP" })
end

schedule do
  send_event('weighted-pipeline', { current: CommercialDashboard.weighted, currency: "GBP" })
end

schedule do
  send_event('three-year-pipeline', { current: CommercialDashboard.three_year, currency: "GBP" })
end
