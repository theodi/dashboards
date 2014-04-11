SCHEDULER.every '1h', :first_in => Time.now + 10 do
    
  issues = GithubDashboard.issues
  external_pulls = GithubDashboard.externalpulls
  
  send_event('pull-requests', { current: issues[:pull_requests] })
  send_event('issues-graph', { current: issues[:open_issues] } )
  send_event('external-pulls', { current: external_pulls[:total_pulls] } )
  send_event('external-pulls-merged', { current: external_pulls[:merged_pulls] } )
  send_event('milestone', GithubDashboard.milestone )
  
  
end