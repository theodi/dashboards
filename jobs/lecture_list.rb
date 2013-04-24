SCHEDULER.every '1m', :first_at => Time.now do
  
  send_event('lecture-list', LectureList.update )

end