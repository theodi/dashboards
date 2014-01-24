SCHEDULER.every '1m', :first_at => Time.now do
    
  send_event('jenkins-builds', JenkinsBuilds.update)
  send_event('jenkins-build-image', JenkinsBuilds.build_images)

end