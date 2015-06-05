SCHEDULER.every '5m', :first_in => 10 do

  send_event('application-errors', current: ApplicationErrors.count )

end
