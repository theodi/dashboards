SCHEDULER.every '1h', :first_in => Time.now + 10 do
  
  send_event('event-list', EventList.update )

end