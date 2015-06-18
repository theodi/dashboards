class DiversityDashboard < MetricsHelper
  
  def self.gender_total
    data = []
    (load_metric 'diversity-gender')['value']['total'].each_pair do |gender, value|
      data << {label: gender, value: value}
    end
    data.sort_by { |d| d[:label] }
  end
  
  def self.gender_board
    team("board")
  end

  def self.gender_leadership
    team("leadership")
  end
  
  def self.gender_spt
    team("spt")
  end
  
  def self.gender_global_network
    team("global_network")
  end

  def self.gender_core
    team("core")
  end

  def self.gender_innovation_unit
    team("innovation_unit")
  end
  
  def self.team(name)
    data = []
    (load_metric 'diversity-gender')['value']['teams'][name].each_pair do |gender, value|
      data << {label: gender, value: value}
    end
    data.sort_by { |d| d[:label] }
  rescue Exception => e
    msg = "Team not found in gender diversity metrics data: #{name}"    
    puts msg
    Airbrake.notify(error_class: "Bad Team", error_message: msg, parameters: {name: name})
    []
  end
  
end