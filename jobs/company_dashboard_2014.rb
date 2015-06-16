#!/bin/env ruby
# encoding: utf-8

# 2014 Company

schedule do
  send_event '2014-Reach', current: CompanyDashboard.reach(2014), link: "/reach/2014"
end

schedule do
  send_event '2014-Value', current: CompanyDashboard.value(2014), currency: "GBP"
end

schedule do
  send_metric_with_targets '2014-commercial-bookings',     CompanyDashboard.commercial_bookings(2014),    link: "/research-projects-training/2014", currency: "GBP"
end

schedule do
  send_metric_with_targets '2014-non-commercial-bookings', CompanyDashboard.noncommercial_bookings(2014), link: "/research-projects-training/2014", currency: "GBP"
end

schedule do
  send_metric_with_targets '2014-grant-funding',           CompanyDashboard.grant_funding(2014),          currency: "GBP"
end

schedule do
  send_metric_with_targets '2014-network-size',            CompanyDashboard.network_size(2014),           link: "/network/2014"
end

schedule do
  data = []
  CompanyDashboard.bookings_by_sector(2014).each do |k, v|
    data << { label: k, value: v['commercial']['actual'] + v['non_commercial']['actual'] }
  end
  send_event '2014-revenue-by-sector', value: data, currency: "GBP"
end

# 2014 Reach

schedule do
  send_event '2014-Reach',         current:       CompanyDashboard.reach(2014)
end

schedule do
  send_event '2014-Active-reach',  current:       CompanyDashboard.active_reach(2014)
end

schedule do
  send_event '2014-Passive-reach', current:       CompanyDashboard.passive_reach(2014)
end

schedule do
  send_event '2014-Articles',      current:       CompanyDashboard.articles(2014)
end

schedule do
  send_event '2014-Events',        current:       CompanyDashboard.events_hosted(2014)
end

schedule do
  send_metric_with_targets '2014-People-trained', CompanyDashboard.people_trained(2014)
end

# 2014 Network

schedule do
  send_metric_with_targets '2014-Active-members',    CompanyDashboard.network_size(2014, [:partners, :supporters, :sponsors])
end

schedule do
  send_metric_with_targets '2014-Partners',          CompanyDashboard.network_size(2014, [:partners])
end

schedule do
  send_metric_with_targets '2014-Sponsors',          CompanyDashboard.network_size(2014, [:sponsors])
end

schedule do
  send_metric_with_targets '2014-Supporters',        CompanyDashboard.network_size(2014, [:supporters])
end

schedule do
  send_metric_with_targets '2014-Nodes',             CompanyDashboard.network_size(2014, [:nodes])
end

schedule do
  send_metric_with_targets '2014-Startups',          CompanyDashboard.network_size(2014, [:startups])
end

# 2014 Research, Projects & Training board

schedule do
  bookings_by_sector = CompanyDashboard.bookings_by_sector(2014)
  send_metric_with_targets '2014-Commercial-research',     bookings_by_sector['research']['commercial'], currency: "GBP"
  send_metric_with_targets '2014-Commercial-training',     bookings_by_sector['training']['commercial'], currency: "GBP"
  send_metric_with_targets '2014-Commercial-projects',     bookings_by_sector['projects']['commercial'], currency: "GBP"
  send_metric_with_targets '2014-Non-commercial-research', bookings_by_sector['research']['non_commercial'], currency: "GBP"
  send_metric_with_targets '2014-Non-commercial-training', bookings_by_sector['training']['non_commercial'], currency: "GBP"
  send_metric_with_targets '2014-Non-commercial-projects', bookings_by_sector['projects']['non_commercial'], currency: "GBP"
end

# 2014 OpExs

schedule do
  send_metric_with_targets '2014-Income',      CompanyDashboard.income(2014),  currency: "GBP"
end

schedule do
  send_event '2014-Headcount',        current: CompanyDashboard.headcount(2014)['actual']
end

schedule do
  send_event '2014-EBITDA-YTD',       current: CompanyDashboard.ebitda(2014)['actual'], currency: "GBP"
end

schedule do
  send_event '2014-EBITDA',           current: CompanyDashboard.ebitda(2014)['latest'], currency: "GBP"
end

schedule do
  send_metric_with_targets '2014-Total-Costs', CompanyDashboard.total_costs(2014), currency: "GBP"
end

schedule do
  send_event '2014-Burn',  current:            CompanyDashboard.burn(2014), currency: "GBP"
end

schedule do
  send_event '2014-Cash-Reserves',  current:   CompanyDashboard.cash_reserves(2014), currency: "GBP"
end

schedule do
  pie = CompanyDashboard.cost_breakdown(2014, 'fixed').map do |key, value|
    {label: key.humanize, value: value}
  end
  send_event '2014-Fixed-cost-breakdown', value: pie, currency: "GBP"
end