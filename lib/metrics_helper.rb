require 'httparty'

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

    JSON.parse HTTParty.get(url,
                            :headers => { 'Accept' => 'application/json' }).body
  end

end