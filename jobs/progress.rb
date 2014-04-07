SCHEDULER.every '1h', :first_in => Time.now + 10 do
  send_event('2014-q2-current-month', items: Progress.current_month("sFETRDq0"))
end
