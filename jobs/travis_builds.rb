SCHEDULER.every '30s', :first_in => 10 do

  send_event('travis-builds', TravisBuilds.update)
  send_event('travis-build-image', TravisBuilds.build_images)

end
