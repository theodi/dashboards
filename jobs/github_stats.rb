SCHEDULER.every '1h', :first_at => Time.now do
  
  issues = GithubDashboard.issues
  external_pulls = GithubDashboard.externalpulls
  
  send_event('pull-requests', issues[:pull_requests] )
  send_event('issues', issues[:open_issues] )
  send_event('external-pulls', external_pulls[:total_pulls] )
  send_event('external-pulls-merged', external_pulls[:merged_pulls] )
  send_event('milestone', GithubDashboard.milestone )
  
  
end