SCHEDULER.every '1m', :first_at => Time.now do
  
  send_event('pingdom-status', Pingdom.perform )

end

