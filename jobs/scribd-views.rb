SCHEDULER.every '30m', :first_in => Time.now + 10 do
  
  send_event('scribd-views', ScribdViews.update )

end