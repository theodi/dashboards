#!/bin/env ruby
# encoding: utf-8

SCHEDULER.every '1h', :first_at => Time.now do
  progress = CompanyDashboard.progress
  send_event('q1-progress', { min: 0, max: 100, value: progress[:q1] })
  send_event('q2-progress', { min: 0, max: 100, value: progress[:q2] })
  send_event('q3-progress', { min: 0, max: 100, value: progress[:q3] })
  send_event('q4-progress', { min: 0, max: 100, value: progress[:q4] })
end

SCHEDULER.every '5m', :first_at => Time.now do
  send_event('Reach', { current: CompanyDashboard.reach })
  send_event('Bookings', { current: CompanyDashboard.bookings, prefix: "£" })
  send_event('Members', { current: CompanyDashboard.members })
  send_event('Value', { current: CompanyDashboard.value, prefix: "£" })
  send_event('ODCs', { current: CompanyDashboard.odcs })
  send_event('KPIs', { current: CompanyDashboard.kpis, suffix: "%" })
end