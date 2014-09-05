class DiversityDashboard < MetricsHelper
  
  def self.gender_total
    data = []
    (load_metric 'diversity-gender')['value']['total'].each_pair do |gender, value|
      data << {label: gender, value: value}
    end
    data
  end
  
  def self.gender_board
    team("board")
  end
  
  def self.gender_smt
    team("smt")
  end
  
  def self.gender_commercial
    team("commercial")
  end
  
  def self.gender_international
    team("international")
  end
  
  def self.gender_operations
    team("operations")
  end
  
  def self.gender_technical
    team("technical")
  end
  
  def self.team(name)
    data = []
    puts load_metric 'diversity-gender'
    (load_metric 'diversity-gender')['value']['teams'][name].each_pair do |gender, value|
      data << {label: gender, value: value}
    end
    data
  end
  
end