SCHEDULER.every '30m', :first_at => $start_time do
  
  send_event('soundcloud-listens', SoundcloudListens.update )

end