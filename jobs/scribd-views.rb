SCHEDULER.every '1m', :first_at => Time.now do
  
  send_event('scribd-views', ScribdViews.update )

end