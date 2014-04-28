#!/bin/env ruby
# encoding: utf-8

SCHEDULER.every '1h', :first_in => Time.now + 10 do
  send_event 'comms-spokespeople', items: NewsArticlesDashboard.spokespeople(2014).first(10)
  send_event 'comms-sectors', items: NewsArticlesDashboard.sectors(2014).first(10)
  send_event 'comms-geographies', items: NewsArticlesDashboard.geographies(2014).first(22)
  send_event 'comms-sentiment', value: NewsArticlesDashboard.sentiment(2014), colours: ['#67EF67','#F9BC26','#ff6700','#D60303'], width: 240, height: 200, radius: 100
  send_event 'comms-odi-volume', current: NewsArticlesDashboard.volume(2014, "ODI")
  send_event 'comms-odi-value', current: NewsArticlesDashboard.value(2014, "ODI"), currency: "GBP"
  send_event 'comms-odi-reach', current: NewsArticlesDashboard.reach(2014, "ODI")
  send_event 'comms-opendata-volume', current: NewsArticlesDashboard.volume(2014, "OpenData")
  send_event 'comms-opendata-value', current: NewsArticlesDashboard.value(2014, "OpenData"), currency: "GBP"
  send_event 'comms-opendata-reach', current: NewsArticlesDashboard.reach(2014, "OpenData")
end
