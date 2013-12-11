SCHEDULER.every '5m', :first_at => Time.now do
  by_level = MembershipDashboard.by_level
  send_event('total-members', { current: MembershipDashboard.count })
  send_event('member-members', { current: by_level['member'] })
  send_event('partner-members', { current: by_level['partner'] })
  send_event('sponsor-members', { current: by_level['sponsor'] })
  send_event('supporter-members', { current: by_level['supporter'] })
end