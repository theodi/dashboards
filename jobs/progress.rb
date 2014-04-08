SCHEDULER.every '1h', :first_in => Time.now + 10 do
  boards = {
    "2013-q1" => "cEwY2JHh",
    "2013-q2" => "m5Gxybf6",
    "2013-q3" => "wkIzhRE3",
    "2013-q4" => "5IZH6yGG",
    "2014-q1" => "8P2Hgzlh",
    "2014-q2" => "sFETRDq0"
  }

  boards.each do |k,v|
    progress = Progress.new(v)
    send_event("#{k}-current-month", items: progress.current_month)
    send_event("#{k}-rest-of-quarter", items: progress.rest_of_quarter)
    send_event("#{k}-discuss", items: progress.to_discuss)
    send_event("#{k}-done", items: progress.done)
  end

end
