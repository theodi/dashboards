SCHEDULER.every '30m', :first_in => 0 do
  
  send_event('soundcloud-listens', SoundcloudListens.update )

end