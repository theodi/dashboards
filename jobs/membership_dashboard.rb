SCHEDULER.every '5m', :first_in => 0 do
  by_level = MembershipDashboard.by_level
  renewals = MembershipDashboard.renewals
  send_event('total-members', { current: MembershipDashboard.count })
  send_event('member-members', { current: by_level['member'], suffix: '%' })
  send_event('partner-members', { current: by_level['partner'], suffix: '%' })
  send_event('sponsor-members', { current: by_level['sponsor'], suffix: '%' })
  send_event('supporter-members', { current: by_level['supporter'], suffix: '%' })
  send_event('renewals', { lists: renewals })
end