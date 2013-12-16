#!/bin/env ruby
# encoding: utf-8

SCHEDULER.every '1h', :first_at => Time.now do
  send_event('members', { current: CommercialDashboard.members })
  send_event('age', { current: CommercialDashboard.age, suffix: " days" })
  send_event('old-opportunities', { current: CommercialDashboard.old_opportunities })
  send_event('pipeline', { current: CommercialDashboard.pipeline, prefix: "£" })
end