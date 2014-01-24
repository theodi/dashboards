SCHEDULER.every '1h', :first_at => Time.now do
  
  send_event('upcoming-lectures', LectureList.update("Live") )

end