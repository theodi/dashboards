require_relative 'metrics_helper'

class ApplicationErrors < MetricsHelper
  
  def self.count
    load_metric('application-errors')['value']
  end
  
end