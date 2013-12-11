require 'httparty'

class MembershipDashboard
  
  def self.count
    response = load_metric("membership-count")
    response["value"]["total"]
  end
  
  def self.by_level
    response = load_metric("membership-count")
    
    levels = {}
    response["value"]["by_level"].each { |k,v| levels[k] = v  }
    
    return levels
  end
  
  def self.load_metric(type)
    JSON.parse HTTParty.get("#{ENV['METRICS_API_BASE_URL']}metrics/#{type}", 
                            :headers => { 'Accept' => 'application/json' } ).body
  end
  
end