schedule('5m') do
  send_event('application-errors', current: ApplicationErrors.count )
end
