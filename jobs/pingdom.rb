SCHEDULER.every '1m', :first_at => $start_time do
  
  send_event('pingdom-status', Pingdom.perform )

end

