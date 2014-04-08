SCHEDULER.every '1h', :first_in => Time.now + 10 do
  q2_progress = Progress.new("sFETRDq0")
  send_event('2014-q2-current-month', items: q2_progress.current_month)
  send_event('2014-q2-rest-of-quarter', items: q2_progress.rest_of_quarter)
  send_event('2014-q2-discuss', items: q2_progress.to_discuss)
  send_event('2014-q2-done', items: q2_progress.done)
end
