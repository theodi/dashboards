#!/bin/env ruby
# encoding: utf-8

schedule do
  send_event 'comms-spokespeople', items: NewsArticlesDashboard.spokespeople(2014).first(10)
end

schedule do
  send_event 'comms-sectors', items: NewsArticlesDashboard.sectors(2014).first(10)
end

schedule do
  send_event 'comms-geographies', items: NewsArticlesDashboard.geographies(2014).first(22)
end

schedule do
  send_event 'comms-sentiment', value: NewsArticlesDashboard.sentiment(2014), colours: ['#67EF67','#F9BC26','#ff6700','#D60303'], width: 240, height: 200, radius: 100
end

schedule do
  send_event 'comms-odi-volume', current: NewsArticlesDashboard.volume(2014, "ODI")
end

schedule do
  send_event 'comms-odi-value', current: NewsArticlesDashboard.value(2014, "ODI"), currency: "GBP"
end

schedule do
  send_event 'comms-odi-reach', current: NewsArticlesDashboard.reach(2014, "ODI")
end

schedule do
  send_event 'comms-opendata-volume', current: NewsArticlesDashboard.volume(2014, "OpenData")
end

schedule do
  send_event 'comms-opendata-value', current: NewsArticlesDashboard.value(2014, "OpenData"), currency: "GBP"
end

schedule do
  send_event 'comms-opendata-reach', current: NewsArticlesDashboard.reach(2014, "OpenData")
end

# 2015 Reach

schedule do
  send_event '2015-Active-reach',  current: CompanyDashboard.active_reach(2015)['actual']
end


schedule do
  send_event '2015-Passive-reach', current: CompanyDashboard.passive_reach(2015)['actual']
end

schedule do
  geo = NewsArticlesDashboard.geographies(2015)
  geo = geo.first(4) << { label: 'Other', value: geo[4..-1].inject(0){|sum, x| sum + x[:value] } }
  send_event '2015-Geographic-reach', value: geo
  # send_event '2014-Articles',      current:       CompanyDashboard.articles(2014)
  # send_event '2014-Events',        current:       CompanyDashboard.events_hosted(2014)
  # send_metric_with_targets '2014-People-trained', CompanyDashboard.people_trained(2014)
end

# 2016 Reach

schedule do
  reach = CompanyDashboard.active_reach(2016)['actual'] rescue 0
  send_event '2016-Active-reach',  current: reach
end


schedule do
  reach = CompanyDashboard.passive_reach(2016)['actual'] rescue 0
  send_event '2016-Passive-reach', current: reach
end

schedule do
  geo = NewsArticlesDashboard.geographies(2016)
  geo = geo.first(4) << { label: 'Other', value: geo[4..-1].inject(0){|sum, x| sum + x[:value] } }
  send_event '2016-Geographic-reach', value: geo
end
