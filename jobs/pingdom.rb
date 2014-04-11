SCHEDULER.every '1m', :first_in => Time.now + 10 do
  
  send_event('pingdom-status', Pingdom.perform )

end

