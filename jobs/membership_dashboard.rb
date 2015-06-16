schedule('5m') do
  by_level = MembershipDashboard.by_level
  send_event('member-members', { current: by_level['member'], suffix: '%' })
  send_event('partner-members', { current: by_level['partner'], suffix: '%' })
  send_event('sponsor-members', { current: by_level['sponsor'], suffix: '%' })
  send_event('supporter-members', { current: by_level['supporter'], suffix: '%' })
end

schedule('5m') do
  renewals = MembershipDashboard.renewals
  send_event('renewals', { lists: renewals })
end

schedule('5m') do
  send_event('total-members', { current: MembershipDashboard.count })
end

