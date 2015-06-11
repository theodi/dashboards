#!/bin/env ruby
# encoding: utf-8

schedule do
  send_event 'Lifetime-Reach',          current: CompanyDashboard.reach
end

schedule do
  send_event 'Lifetime-Value',          current: CompanyDashboard.value,   currency: "GBP"
end

schedule do
  send_event 'Lifetime-ODCs',           current: CompanyDashboard.odcs,    link: "https://certificates.theodi.org/status"
end

schedule do
  send_event 'Lifetime-network-size',   current: CompanyDashboard.network_size
end

schedule do
  send_event 'Lifetime-people-trained', current: CompanyDashboard.people_trained
end

schedule do
  send_event 'Lifetime-bookings',       current: CompanyDashboard.bookings, currency: "GBP"
end