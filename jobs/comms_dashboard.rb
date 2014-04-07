#!/bin/env ruby
# encoding: utf-8

SCHEDULER.every '10s', :first_in => Time.now + 10 do
  send_event 'comms-spokespeople', items: CommsDashboard.spokespeople(2014).first(10)
  send_event 'comms-sectors', items: CommsDashboard.sectors(2014).first(10)
  send_event 'comms-geographies', items: CommsDashboard.geographies(2014).first(22)
  send_event 'comms-sentiment', value: CommsDashboard.sentiment(2014), colours: ['#67EF67','#F9BC26','#ff6700','#D60303']
  send_event 'comms-odi-volume', current: CommsDashboard.volume(2014, "ODI")
  send_event 'comms-odi-value', current: CommsDashboard.value(2014, "ODI")
  send_event 'comms-odi-reach', current: CommsDashboard.reach(2014, "ODI")
  send_event 'comms-opendata-volume', current: CommsDashboard.volume(2014, "OpenData")
  send_event 'comms-opendata-value', current: CommsDashboard.value(2014, "OpenData")
  send_event 'comms-opendata-reach', current: CommsDashboard.reach(2014, "OpenData")
end
