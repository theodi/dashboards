SCHEDULER.every '30m', :first_at => $start_time do
  
  send_event('scribd-views', ScribdViews.update )

end