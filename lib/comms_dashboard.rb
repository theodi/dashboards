require_relative 'metrics_helper'

class CommsDashboard < MetricsHelper

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


end
