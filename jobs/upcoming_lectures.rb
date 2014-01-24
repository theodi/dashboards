SCHEDULER.every '1h', :first_at => $start_time do
  
  send_event('upcoming-lectures', LectureList.update("Live") )

end