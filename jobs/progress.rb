(2013..DateTime.now.year).each do |year|
  ["q1", "q2", "q3", "q4"].each do |quarter|
    
    schedule do
      progress = CompanyDashboard.progress(year)
      send_event "#{year}-#{quarter}-progress", min: 0, max: 100, value: progress[quarter.to_sym], link: "/progress/#{year}/#{quarter}"
    end
    
    schedule do
      progress = Progress.new(year, quarter)
      send_event("#{year}-#{quarter}-current-month", items: progress.current_month)
      send_event("#{year}-#{quarter}-rest-of-quarter", items: progress.rest_of_quarter)
      send_event("#{year}-#{quarter}-discuss", items: progress.to_discuss)
      send_event("#{year}-#{quarter}-done", items: progress.done)
    end
    
  end
end
