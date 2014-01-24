SCHEDULER.every '1h', :first_at => $start_time do
  
  send_event('event-list', EventList.update )

end