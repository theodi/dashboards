#!/bin/env ruby
# encoding: utf-8

def send_metric_with_targets event, data, options = {}
  send_event event, { current: data['actual'], annual_target: data['annual_target'], ytd_target: data['ytd_target']}.merge(options)
end

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  # 2013 Company
  send_event '2013-Reach',    current: CompanyDashboard.reach(2013)
  send_event '2013-Members',  current: CompanyDashboard.members(2013), link: "http://directory.theodi.org/members"
  send_event '2013-Value',    current: CompanyDashboard.value(2013),   currency: "GBP"
  send_event '2013-ODCs',     current: CompanyDashboard.odcs(2013),    link: "https://certificates.theodi.org/status"
  send_event '2013-KPIs',     current: CompanyDashboard.kpis(2013),    suffix: "%"
  send_event '2013-Bookings', current: CompanyDashboard.bookings(2013), currency: "GBP" # derprecated metric
end

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  # 2014 Company
  send_event '2014-Reach', current: CompanyDashboard.reach(2014), link: "/reach/2014"
  send_event '2014-Value', current: CompanyDashboard.value(2014), currency: "GBP"
  send_metric_with_targets '2014-commercial-bookings',     CompanyDashboard.commercial_bookings(2014),    link: "/research-projects-training/2014", currency: "GBP"
  send_metric_with_targets '2014-non-commercial-bookings', CompanyDashboard.noncommercial_bookings(2014), link: "/research-projects-training/2014", currency: "GBP"
  send_metric_with_targets '2014-grant-funding',           CompanyDashboard.grant_funding(2014),          currency: "GBP"
  send_metric_with_targets '2014-network-size',            CompanyDashboard.network_size(2014),           link: "/network/2014"
  data = []
  CompanyDashboard.bookings_by_sector(2014).each do |k, v|
    data << { label: k, value: v['commercial']['actual'] + v['non_commercial']['actual'] }
  end
  send_event '2014-revenue-by-sector', value: data

end

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  # 2014 Reach
  send_event '2014-Reach',         current:       CompanyDashboard.reach(2014)
  send_event '2014-Active-reach',  current:       CompanyDashboard.active_reach(2014)
  send_event '2014-Passive-reach', current:       CompanyDashboard.passive_reach(2014)
  send_event '2014-Articles',      current:       CompanyDashboard.articles(2014)
  send_event '2014-Events',        current:       CompanyDashboard.events_hosted(2014)
  send_metric_with_targets '2014-People-trained', CompanyDashboard.people_trained(2014)
end

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  # 2014 Reach
  send_metric_with_targets '2014-Active-members',    CompanyDashboard.network_size(2014, [:partners, :supporters, :sponsors])
  send_metric_with_targets '2014-Partners',          CompanyDashboard.network_size(2014, [:partners])
  send_metric_with_targets '2014-Sponsors',          CompanyDashboard.network_size(2014, [:sponsors])
  send_metric_with_targets '2014-Supporters',        CompanyDashboard.network_size(2014, [:supporters])
  send_metric_with_targets '2014-Nodes',             CompanyDashboard.network_size(2014, [:nodes])
  send_metric_with_targets '2014-Startups',          CompanyDashboard.network_size(2014, [:startups])
end

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  # 2014 Research, Projects & Training board
  bookings_by_sector = CompanyDashboard.bookings_by_sector(2014)
  send_metric_with_targets '2014-Commercial-research',     bookings_by_sector['research']['commercial'], currency: "GBP"
  send_metric_with_targets '2014-Commercial-training',     bookings_by_sector['training']['commercial'], currency: "GBP"
  send_metric_with_targets '2014-Commercial-projects',     bookings_by_sector['projects']['commercial'], currency: "GBP"
  send_metric_with_targets '2014-Non-commercial-research', bookings_by_sector['research']['non_commercial'], currency: "GBP"
  send_metric_with_targets '2014-Non-commercial-training', bookings_by_sector['training']['non_commercial'], currency: "GBP"
  send_metric_with_targets '2014-Non-commercial-projects', bookings_by_sector['projects']['non_commercial'], currency: "GBP"
end

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  # 2014 OpExs
  send_metric_with_targets '2014-Income',      CompanyDashboard.income(2014),  currency: "GBP"
  send_event '2014-Headcount',        current: CompanyDashboard.headcount(2014)['actual']
  send_event '2014-EBITDA-YTD',       current: CompanyDashboard.ebitda(2014)['actual'], currency: "GBP"
  send_event '2014-EBITDA',           current: CompanyDashboard.ebitda(2014)['latest'], currency: "GBP"
  send_metric_with_targets '2014-Total-Costs', CompanyDashboard.total_costs(2014), currency: "GBP"
  send_event '2014-Burn',  current:            CompanyDashboard.burn(2014), currency: "GBP"
  send_event '2014-Cash-Reserves',  current:   CompanyDashboard.cash_reserves, currency: "GBP"
  pie = CompanyDashboard.fixed_cost_breakdown(2014).map do |key, value|
    {label: key.humanize, value: value}
  end
  send_event '2014-Fixed-cost-breakdown', value: pie
end

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  # 2015 Company
  send_metric_with_targets '2015-people-trained', CompanyDashboard.people_trained(2015)
  send_metric_with_targets '2015-trainers-trained', CompanyDashboard.trainers_trained(2015)
  send_metric_with_targets '2015-Reach', CompanyDashboard.reach(2015)
  send_metric_with_targets '2015-flagship-stories', CompanyDashboard.flagship_stories(2015)
  send_metric_with_targets '2015-bookings', CompanyDashboard.bookings(2015), currency: "GBP"

  legend = {
    "network" => "Global Network",
    "innovation" => "Innovation Unit",
    "core" => "Core",
  }
  data = []
  CompanyDashboard.bookings_by_sector(2015).each do |k, v|
    data << { label: legend.fetch(k, k), value: v['actual'] }
  end
  send_event '2015-revenue-by-sector', value: data
end

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  # Lifetime
  send_event 'Lifetime-Reach',          current: CompanyDashboard.reach
  send_event 'Lifetime-Value',          current: CompanyDashboard.value,   currency: "GBP"
  send_event 'Lifetime-ODCs',           current: CompanyDashboard.odcs,    link: "https://certificates.theodi.org/status"
  send_event 'Lifetime-network-size',   current: CompanyDashboard.network_size
  send_event 'Lifetime-people-trained', current: CompanyDashboard.people_trained
  send_event 'Lifetime-bookings',       current: CompanyDashboard.bookings, currency: "GBP"

  (2013..DateTime.now.year).each do |year|
    [:q1, :q2, :q3, :q4].each do |quarter|
      progress = CompanyDashboard.progress(year)
      send_event "#{year}-#{quarter}-progress", min: 0, max: 100, value: progress[quarter], link: "/progress/#{year}/#{quarter}"
    end
  end
end
