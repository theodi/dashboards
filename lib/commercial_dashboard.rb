require_relative 'metrics_helper'

class CommercialDashboard < MetricsHelper
    
  def self.pipeline
    response = load_metric("total-pipeline")
    start_end = Date.civil(Date.today.year, 1, 1).to_s + "/" +  Date.civil(Date.today.year, 12, 31).to_s
    binding.pry
    response["value"][start_end]
  end
  
  def self.weighted
    
  end
  
  def self.three_year
    
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
  
end