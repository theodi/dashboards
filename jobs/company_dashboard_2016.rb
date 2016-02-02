#!/bin/env ruby
# encoding: utf-8

# 2016 Company

schedule do
  size = CompanyDashboard.network_size(2016)['actual'] rescue 0
  send_event               '2016-network-size', current: size
end

schedule do
  send_metric_with_targets '2016-people-trained', CompanyDashboard.people_trained(2016)
end

schedule do
  send_metric_with_targets '2016-trainers-trained', CompanyDashboard.trainers_trained(2016)
end

schedule do
  send_metric_with_targets '2016-Reach', CompanyDashboard.reach(2016)
end

schedule do
  send_metric_with_targets '2016-flagship-stories', CompanyDashboard.flagship_stories(2016)
end

schedule do
  send_metric_with_targets '2016-bookings', CompanyDashboard.bookings(2016), currency: "GBP"
end

schedule do
  legend = {
    "network" => "Global Network",
    "innovation" => "Innovation Unit",
    "core" => "Core",
  }
  data = []
  CompanyDashboard.bookings_by_sector(2016).each do |k, v|
    data << { label: legend.fetch(k, k), value: v['actual'] }
  end
  send_event '2016-revenue-by-sector', value: data, currency: "GBP"
end

# 2016 OpExs

schedule do
  send_metric_with_targets '2016-Income',      CompanyDashboard.income(2016),  currency: "GBP"
end

schedule do
  send_metric_with_targets '2016-Headcount',   CompanyDashboard.headcount(2016)
end

schedule do
  send_metric_with_targets '2016-EBITDA-YTD',  CompanyDashboard.ebitda(2016), currency: "GBP"
end

schedule do
  ebitda = CompanyDashboard.ebitda(2016)['latest'] rescue 0
  send_event '2016-EBITDA',           current: ebitda, currency: "GBP"
end

schedule do
  send_metric_with_targets '2016-Total-Costs', CompanyDashboard.total_costs(2016), currency: "GBP"
end

schedule do
  send_event '2016-Burn',             current: CompanyDashboard.burn(2016), currency: "GBP"
end

schedule do
  send_event '2016-Cash-Reserves',    current: CompanyDashboard.cash_reserves(2016), currency: "GBP"
end

schedule do
  pie = CompanyDashboard.cost_breakdown(2016).map do |key, value|
    {label: key.humanize, value: value}
  end
  send_event '2016-cost-breakdown', value: pie, currency: "GBP"
end