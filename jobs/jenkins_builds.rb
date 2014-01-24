SCHEDULER.every '1m', :first_at => $start_time do
    
  send_event('jenkins-builds', JenkinsBuilds.update)
  send_event('jenkins-build-image', JenkinsBuilds.build_images)

end