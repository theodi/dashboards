SCHEDULER.every '30m', :first_at => Time.now do
  
  send_event('scribd-views', ScribdViews.update )

end