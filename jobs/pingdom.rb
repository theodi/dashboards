schedule('1m') do
  send_event('pingdom-status', Pingdom.perform )
end
