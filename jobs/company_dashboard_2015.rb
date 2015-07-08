#!/bin/env ruby
# encoding: utf-8

# 2015 Company

schedule do
  send_event               '2015-network-size', current: CompanyDashboard.network_size(2015)['actual']
end

schedule do
  send_metric_with_targets '2015-people-trained', CompanyDashboard.people_trained(2015)
end

schedule do
  send_metric_with_targets '2015-trainers-trained', CompanyDashboard.trainers_trained(2015)
end

schedule do
  send_metric_with_targets '2015-Reach', CompanyDashboard.reach(2015)
end

schedule do
  send_metric_with_targets '2015-flagship-stories', CompanyDashboard.flagship_stories(2015)
end

schedule do
  send_metric_with_targets '2015-bookings', CompanyDashboard.bookings(2015), currency: "GBP"
end

schedule do
  legend = {
    "network" => "Global Network",
    "innovation" => "Innovation Unit",
    "core" => "Core",
  }
  data = []
  CompanyDashboard.bookings_by_sector(2015).each do |k, v|
    data << { label: legend.fetch(k, k), value: v['actual'] }
  end
  send_event '2015-revenue-by-sector', value: data, currency: "GBP"
end

# 2015 OpExs

schedule do
  send_metric_with_targets '2015-Income',      CompanyDashboard.income(2015),  currency: "GBP"
end

schedule do
  send_metric_with_targets '2015-Headcount',   CompanyDashboard.headcount(2015)
end

schedule do
  send_metric_with_targets '2015-EBITDA-YTD',  CompanyDashboard.ebitda(2015), currency: "GBP"
end

schedule do
  send_event '2015-EBITDA',           current: CompanyDashboard.ebitda(2015)['latest'], currency: "GBP"
end

schedule do
  send_metric_with_targets '2015-Total-Costs', CompanyDashboard.total_costs(2015), currency: "GBP"
end

schedule do
  send_event '2015-Burn',             current: CompanyDashboard.burn(2015), currency: "GBP"
end

schedule do
  send_event '2015-Cash-Reserves',    current: CompanyDashboard.cash_reserves(2015), currency: "GBP"
end

schedule do
  pie = CompanyDashboard.cost_breakdown(2015).map do |key, value|
    {label: key.humanize, value: value}
  end
  send_event '2015-cost-breakdown', value: pie, currency: "GBP"
end