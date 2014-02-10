SCHEDULER.every '1h', :first_in => 0 do
  
  send_event('upcoming-lectures', LectureList.update("Live") )

end