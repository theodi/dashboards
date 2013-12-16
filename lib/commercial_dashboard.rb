require_relative 'metrics_helper'

class CommercialDashboard < MetricsHelper
    
  def self.pipeline
    pipelines("total")
  end
  
  def self.weighted
    pipelines("weighted")
  end
  
  def self.three_year
    pipelines("total", 2)
  end
  
  def self.bookings
  
  end
  
  def self.revenue
    
  end
  
  def self.backlog
    
  end
  
  def self.members
    response = load_metric("membership-count")
    response["value"]["total"]
  end
  
  def self.age
    response = load_metric("average-opportunity-age")
    response["value"]
  end
  
  def self.old_opportunities
    response = load_metric("old-opportunity-count")
    response["value"]
  end
  
  def self.pipelines(type, years = 0)
    response = load_metric("#{type}-pipeline")
    start_end = Date.civil(Date.today.year, 1, 1).to_s + "/" +  Date.civil(Date.today.year + years, 12, 31).to_s
    response["value"][start_end]
  end
  
end