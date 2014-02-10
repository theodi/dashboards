SCHEDULER.every '30m', :first_in => 0 do
  
  send_event('scribd-views', ScribdViews.update )

end