SCHEDULER.every '1h', :first_in => Time.now + 10 do
  
  send_event('previous-lectures', LectureList.update("Completed") )

end