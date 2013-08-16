require 'httparty'

class Pingdom
  
  def self.perform
    response = HTTParty.get("https://api.pingdom.com/api/2.0/checks", :basic_auth => {:username => ENV['PINGDOM_USERNAME'], :password => ENV['PINGDOM_PASSWORD']}, :headers => { "App-Key" => ENV['PINGDOM_APP_KEY'] })
    checks = []
    
    response["checks"].each do |check|
      checks << { label: check["hostname"], value: check["status"] }
    end
    
    {items: checks.compact, unordered: true}
  end
  
end