schedule do
  send_event('dependencies', value: Dependencies.pie, colours: ['#0DBC37','#F9BC26','#D60303'], width:200, height:200, radius:100 )
end

schedule do
  send_event('dependency-alerts', current: Dependencies.alerts )
end
