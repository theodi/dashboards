require 'httparty'
require 'date'
require 'active_support/all'

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

    JSON.parse HTTParty.get(url, :headers => { 'Accept' => 'application/json' }).body
  end

  def self.year_to_time year = nil
    year ? DateTime.new(year).end_of_year : nil
  end

  def self.select_metric metric, year = nil
    metric = year ? "current-year-#{metric}" : "cumulative-#{metric}"
    time   = year_to_time year
    (load_metric metric, time)['value']
  end

  def self.google_drive
    GoogleDrive.login(ENV['GAPPS_USER_EMAIL'], ENV['GAPPS_PASSWORD'])
  end
end
