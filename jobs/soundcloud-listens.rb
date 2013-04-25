SCHEDULER.every '30m', :first_at => Time.now do
  
  send_event('soundcloud-listens', SoundcloudListens.update )

end