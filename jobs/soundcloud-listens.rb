SCHEDULER.every '1m', :first_at => Time.now do
  
  send_event('soundcloud-listens', SoundcloudListens.update )

end