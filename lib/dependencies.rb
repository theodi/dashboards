class Dependencies < MetricsHelper
  
  def self.pie
    data = []
    load_metric('gemnasium-dependencies')['value'].each_pair do |label, value|
      data << {label: label, value: value} unless label == 'alerts'
    end
    data
  end
  
  def self.alerts
    load_metric('gemnasium-dependencies')['value']['alerts']
  end
  
  
end