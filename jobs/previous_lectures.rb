SCHEDULER.every '1h', :first_at => $start_time do
  
  send_event('previous-lectures', LectureList.update("Completed") )

end