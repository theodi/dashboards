#!/bin/env ruby
# encoding: utf-8

schedule do
  send_event '2013-Reach',    current: CompanyDashboard.reach(2013)
end

schedule do
  send_event '2013-Members',  current: CompanyDashboard.members(2013), link: "http://directory.theodi.org/members"
end

schedule do
  send_event '2013-Value',    current: CompanyDashboard.value(2013),   currency: "GBP"
end

schedule do
  send_event '2013-ODCs',     current: CompanyDashboard.odcs(2013),    link: "https://certificates.theodi.org/status"
end

schedule do
  send_event '2013-KPIs',     current: CompanyDashboard.kpis(2013),    suffix: "%"
end

schedule do
  send_event '2013-Bookings', current: CompanyDashboard.bookings(2013), currency: "GBP" # derprecated metric
end