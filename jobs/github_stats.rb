schedule do
  issues = GithubDashboard.issues
  send_event('pull-requests', { current: issues[:pull_requests] })
  send_event('issues-graph', { current: issues[:open_issues] } )
end

schedule do
  external_pulls = GithubDashboard.externalpulls
  send_event('external-pulls', { current: external_pulls[:total_pulls] } )
  send_event('external-pulls-merged', { current: external_pulls[:merged_pulls] } )
end

schedule do
  send_event('milestone', GithubDashboard.milestone )
end
