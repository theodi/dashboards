#!/bin/env ruby
# encoding: utf-8

SCHEDULER.every '10s', :first_in => Time.now + 10 do
  send_event 'spokespeople', items: CommsDashboard.spokespeople(2014).first(10)
end
