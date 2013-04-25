SCHEDULER.every '1h', :first_at => Time.now do
  
  send_event('lecture-list', LectureList.update )

end