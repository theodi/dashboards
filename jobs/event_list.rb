SCHEDULER.every '1h', :first_in => 0 do
  
  send_event('event-list', EventList.update )

end