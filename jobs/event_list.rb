SCHEDULER.every '1h', :first_at => Time.now do
  
  send_event('event-list', EventList.update )

end