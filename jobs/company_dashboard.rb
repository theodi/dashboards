#!/bin/env ruby
# encoding: utf-8

def send_metric_with_targets event, data
  send_event(event, { current: data['actual'], annual_target: data['annual_target'], ytd_target: data['ytd_target']})
end

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

SCHEDULER.every '10s', :first_at => $start_time do
  bookings_by_sector = CompanyDashboard.bookings_by_sector(2014)

  # 2013
  send_event('2013-Reach', { current: CompanyDashboard.reach(2013) })
  #send_event('2013-Bookings', { current: CompanyDashboard.bookings(2013), prefix: "£" })
  send_event('2013-Members', { current: CompanyDashboard.members(2013), link: "http://directory.theodi.org/members" })
  send_event('2013-Value', { current: CompanyDashboard.value(2013), prefix: "£" })
  send_event('2013-ODCs', { current: CompanyDashboard.odcs(2013), link: "https://certificates.theodi.org/status" })
  send_event('2013-KPIs', { current: CompanyDashboard.kpis(2013), suffix: "%" })
  # 2014
  send_event('2014-Reach', { current: CompanyDashboard.reach(2014) })
  send_event('2014-Active-reach', { current: CompanyDashboard.active_reach(2014) })
  send_event('2014-Passive-reach', { current: CompanyDashboard.passive_reach(2014) })
  send_event('2014-Articles', { current: CompanyDashboard.articles(2014) })
  send_metric_with_targets '2014-People-trained', CompanyDashboard.people_trained(2014)

  send_metric_with_targets '2014-commercial-bookings', CompanyDashboard.commercial_bookings(2014)
  send_metric_with_targets '2014-non-commercial-bookings', CompanyDashboard.noncommercial_bookings(2014)
  send_metric_with_targets '2014-grant-funding', CompanyDashboard.grant_funding(2014)

  send_event('2014-Members', { current: CompanyDashboard.members(2014), link: "http://directory.theodi.org/members" })
  send_event('2014-Value', { current: CompanyDashboard.value(2014), prefix: "£" })
  send_event('2014-ODCs', { current: CompanyDashboard.odcs(2014), link: "https://certificates.theodi.org/status" })
  send_event('2014-KPIs', { current: CompanyDashboard.kpis(2014), suffix: "%" })
  data = []
  bookings_by_sector.each { |k, v| data << { label: k, value: v['commercial']['actual'] + v['non_commercial']['actual'] } }
  send_event('2014-revenue-by-sector', { value: data })

  send_metric_with_targets '2014-Commercial-research', bookings_by_sector['research']['commercial']
  send_metric_with_targets '2014-Commercial-training', bookings_by_sector['training']['commercial']
  send_metric_with_targets '2014-Commercial-projects', bookings_by_sector['projects']['commercial']
  send_metric_with_targets '2014-Non-commercial-research', bookings_by_sector['research']['non_commercial']
  send_metric_with_targets '2014-Non-commercial-training', bookings_by_sector['training']['non_commercial']
  send_metric_with_targets '2014-Non-commercial-projects', bookings_by_sector['projects']['non_commercial']



  # Lifetime
  send_event('Lifetime-Reach', { current: CompanyDashboard.reach })
  send_event('Lifetime-Bookings', { current: CompanyDashboard.bookings, prefix: "£" })
  send_event('Lifetime-Members', { current: CompanyDashboard.members, link: "http://directory.theodi.org/members" })
  send_event('Lifetime-Value', { current: CompanyDashboard.value, prefix: "£" })
  send_event('Lifetime-ODCs', { current: CompanyDashboard.odcs, link: "https://certificates.theodi.org/status" })

  #Opex
  send_metric_with_targets('2014-Headcount', CompanyDashboard.headcount(2014))
  send_event('2014-Burn', { current: CompanyDashboard.burn(2014) })
  send_metric_with_targets('2014-EBITDA', CompanyDashboard.ebitda(2014))
  send_metric_with_targets('2014-Total-Costs', CompanyDashboard.total_costs(2014))
  pie = CompanyDashboard.fixed_cost_breakdown(2014).map do |key, value|
    {label: key.humanize, value: value}
  end
  send_event('2014-Fixed-cost-breakdown', { value: pie })
end