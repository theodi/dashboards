require 'httparty'
require 'date'
require 'active_support/all'
require 'airbrake'

class MetricsHelper

  def self.load_metric(metric, time = nil)

    url = "%smetrics/%s" % [
        ENV['METRICS_API_BASE_URL'],
        metric
    ]

    if time
      url = "%s/%s" % [
          url,
          time.xmlschema
      ]
    end

    response = HTTParty.get(url, :headers => { 'Accept' => 'application/json' })
    if response.success? && response.body != "null"
      JSON.parse response.body
    else
      msg = "HTTP fail getting #{url}: #{response.code}"
      Airbrake.notify(error_class: "HTTP fail", error_message: msg, parameters: {metric: metric, time: time, url: url, code: response.code})
      raise Exception.new(msg)
    end
    
  end

  def self.year_to_time year = nil
    year ? DateTime.new(year).end_of_year : nil
  end

  def self.select_metric metric, year = nil
    metric = year ? "current-year-#{metric}" : "cumulative-#{metric}"
    time   = year_to_time year
    (load_metric metric, time)['value']
  end

end
