#!/bin/env ruby
# encoding: utf-8

SCHEDULER.every '1h', :first_at => $start_time do
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

SCHEDULER.every '5m', :first_at => $start_time do
  income_by_sector = CompanyDashboard.income_by_sector(2014)
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
  send_event('2014-non-commercial-bookings', { current: CompanyDashboard.noncommercial_bookings(2014)["actual"], prefix: "£" })
  send_event('2014-Members', { current: CompanyDashboard.members(2014), link: "http://directory.theodi.org/members" })
  send_event('2014-Value', { current: CompanyDashboard.value(2014), prefix: "£" })
  send_event('2014-ODCs', { current: CompanyDashboard.odcs(2014), link: "https://certificates.theodi.org/status" })
  send_event('2014-KPIs', { current: CompanyDashboard.kpis(2014), suffix: "%" })
  data = []
  income_by_sector.each { |k,v| data << { label: k, value: v['commercial']['actual'] + v['non_commercial']['actual'] } }
  send_event('2014-revenue-by-sector', { value: data })

  send_event('2014-Commercial-research', {value: income_by_sector['research']['commercial']['actual]']})
  send_event('2014-Commercial-training', {value: income_by_sector['training']['commercial']['actual]']})
  send_event('2014-Commercial-projects', {value: income_by_sector['projects']['commercial']['actual]']})
  send_event('2014-Non-commercial-research', {value: income_by_sector['research']['non_commercial']['actual]']})
  send_event('2014-Non-commercial-training', {value: income_by_sector['training']['non_commercial']['actual]']})
  send_event('2014-Non-commercial-projects', {value: income_by_sector['projects']['non_commercial']['actual]']})

  # Lifetime
  send_event('Lifetime-Reach', { current: CompanyDashboard.reach })
  send_event('Lifetime-Bookings', { current: CompanyDashboard.bookings, prefix: "£" })
  send_event('Lifetime-Members', { current: CompanyDashboard.members, link: "http://directory.theodi.org/members" })
  send_event('Lifetime-Value', { current: CompanyDashboard.value, prefix: "£" })
  send_event('Lifetime-ODCs', { current: CompanyDashboard.odcs, link: "https://certificates.theodi.org/status" })
end