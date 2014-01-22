#!/bin/env ruby
# encoding: utf-8

SCHEDULER.every '1h', :first_at => Time.now do
  progress = CompanyDashboard.progress(2013)
  send_event('2013-q1-progress', { min: 0, max: 100, value: progress[:q1] })
  send_event('2013-q2-progress', { min: 0, max: 100, value: progress[:q2] })
  send_event('2013-q3-progress', { min: 0, max: 100, value: progress[:q3] })
  send_event('2013-q4-progress', { min: 0, max: 100, value: progress[:q4] })
  progress = CompanyDashboard.progress(2014)
  send_event('2014-q1-progress', { min: 0, max: 100, value: progress[:q1] })
  send_event('2014-q2-progress', { min: 0, max: 100, value: progress[:q2] })
  send_event('2014-q3-progress', { min: 0, max: 100, value: progress[:q3] })
  send_event('2014-q4-progress', { min: 0, max: 100, value: progress[:q4] })
end

SCHEDULER.every '5m', :first_at => Time.now do
  # 2013
  send_event('2013-Reach', { current: CompanyDashboard.reach(2013) })
  send_event('2013-Bookings', { current: CompanyDashboard.bookings(2013), prefix: "£" })
  send_event('2013-Members', { current: CompanyDashboard.members(2013), link: "http://directory.theodi.org/members" })
  send_event('2013-Value', { current: CompanyDashboard.value(2013), prefix: "£" })
  send_event('2013-ODCs', { current: CompanyDashboard.odcs(2013), link: "https://certificates.theodi.org/status" })
  send_event('2013-KPIs', { current: CompanyDashboard.kpis(2013), suffix: "%" })
  # 2014
  send_event('2014-Reach', { current: CompanyDashboard.reach(2014) })
  send_event('2014-Bookings', { current: CompanyDashboard.bookings(2014), prefix: "£" })
  send_event('2014-Members', { current: CompanyDashboard.members(2014), link: "http://directory.theodi.org/members" })
  send_event('2014-Value', { current: CompanyDashboard.value(2014), prefix: "£" })
  send_event('2014-ODCs', { current: CompanyDashboard.odcs(2014), link: "https://certificates.theodi.org/status" })
  send_event('2014-KPIs', { current: CompanyDashboard.kpis(2014), suffix: "%" })
end