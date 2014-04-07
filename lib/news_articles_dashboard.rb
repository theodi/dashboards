require_relative 'metrics_helper'

class NewsArticlesDashboard < MetricsHelper

  def self.spokespeople(year = nil)
    select_metric('press-spokespeople', year).map do |person|
      {label: person[0], value: person[1]}
    end
  end

  def self.sectors(year = nil)
    select_metric('press-sector-spread', year).map do |sector|
      {label: sector[0], value: sector[1]}
    end
  end

  def self.geographies(year = nil)
    select_metric('press-geographical-spread', year).map do |country|
      {label: country[0], value: country[1]}
    end
  end

  def self.sentiment(year = nil)
    select_metric('press-sentiment', year).map do |sentiment|
      {label: sentiment[0], value: sentiment[1]}
    end
  end

  def self.volume(year, term)
    select_metric('press-totals', year)[term]["volume"]
  end

  def self.value(year, term)
    select_metric('press-totals', year)[term]["value"]
  end

  def self.reach(year, term)
    select_metric('press-totals', year)[term]["reach"]
  end

end
