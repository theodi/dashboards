# SCHEDULER.every '1h', :first_in => Time.now + 10 do
#   
#   send_event('upcoming-lectures', LectureList.update("Live") )
# 
# end