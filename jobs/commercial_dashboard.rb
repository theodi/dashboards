SCHEDULER.every '1h', :first_at => Time.now do
  send_event('members', { current: CommercialDashboard.members })
  send_event('age', { current: CommercialDashboard.age })
  send_event('old-opportunities', { current: CommercialDashboard.old_opportunities })
end