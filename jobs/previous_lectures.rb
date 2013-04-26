SCHEDULER.every '1h', :first_at => Time.now do
  
  send_event('previous-lectures', LectureList.update("Completed") )

end