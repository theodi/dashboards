def schedule(time='1h', first_in=10)
  
  SCHEDULER.every time, :first_in => first_in+rand(30) do
    yield
  end
end

def send_metric_with_targets event, data, options = {}
  if data == 0 || data.nil?
    data = {
      'actual' => 0,
      'annual_target' => 0,
      'ytd_target' => 0
    }
  end
  send_event event, { current: data['actual'], annual_target: data['annual_target'], ytd_target: data['ytd_target']}.merge(options)
end