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
