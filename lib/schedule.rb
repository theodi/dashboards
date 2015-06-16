def schedule(time='1h', first_in=10)
  
  SCHEDULER.every time, :first_in => first_in+rand(30) do
    yield
  end
end

def send_metric_with_targets event, data, options = {}
  send_event event, { current: data['actual'], annual_target: data['annual_target'], ytd_target: data['ytd_target']}.merge(options)
end