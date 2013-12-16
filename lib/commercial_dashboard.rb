require_relative 'metrics_helper'

class CommercialDashboard < MetricsHelper
    
  def self.pipeline
    
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
    
  end
  
end