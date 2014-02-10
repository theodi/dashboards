SCHEDULER.every '1m', :first_in => 0 do
  
  send_event('pingdom-status', Pingdom.perform )

end

