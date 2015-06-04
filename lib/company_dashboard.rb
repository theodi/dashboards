require_relative 'metrics_helper'

class Hash
  def sum
    inject({}) do |acc, values|
      if values[1].is_a? Hash
        values[1].each_pair do |k,v|
          acc[k] ||= 0
          acc[k] += v
        end
      end
      acc
    end
  end
end

class CompanyDashboard < MetricsHelper

  def self.progress(year)
    (load_metric 'quarterly-progress')['value'][year.to_s].symbolize_keys
  end

  def self.odcs(year = nil)
    time = year_to_time year
    (load_metric 'certificated-datasets', time)['value']
  end

  def self.members(year = nil)
    time = year_to_time year
    (load_metric 'membership-count', time)['value']['total']
  end

  def self.reach(year = nil)
    select_metric('reach', year)['total'] rescue select_metric('reach', year)
  end

  def self.active_reach(year = nil)
    select_metric('reach', year)['breakdown']['active']
  end

  def self.passive_reach(year = nil)
    select_metric('reach', year)['breakdown']['passive']
  end

  def self.headcount(year = nil)
    select_metric 'headcount', year
  end

  def self.ebitda(year = nil)
    select_metric 'ebitda', year
  end

  def self.total_costs(year = nil)
    select_metric 'total-costs', year
  end

  def self.cost_breakdown(year = nil, cost_type = nil)
    c = total_costs(year)['breakdown']
    if cost_type
      c = c[cost_type]
    end
    Hash[c.map { |x|
      [x[0], x[1]['actual']]
    }]
  end

  def self.burn(year = nil)
    select_metric 'burn', year
  end

  def self.bookings(year = nil)
    select_metric 'bookings', year
  end

  def self.commercial_bookings(year = nil)
    bookings_by_type(:commercial, year)
  end

  def self.noncommercial_bookings(year = nil)
    bookings_by_type(:non_commercial, year)
  end

  def self.bookings_by_type type, year = nil
    bookings = bookings_by_sector(year)
    bookings.inject({}) do |acc, values|
      values[1][type.to_s].each_pair do |k,v|
        acc[k] ||= 0
        acc[k] += v
      end
      acc
    end
  end

  def self.bookings_by_sector(year = nil)
    select_metric 'bookings-by-sector', year
  end

  def self.flagship_stories(year)
    select_metric 'flagship-stories', year
  end

  def self.value(year = nil)
    select_metric 'value-unlocked', year
  end

  def self.income(year = nil)
    select_metric 'income', year
  end

  def self.kpis(year)
    select_metric 'kpi-performance', year if year # year should never be nil for this
  end

  def self.grant_funding(year)
    select_metric 'grant-funding', year
  end

  def self.cash_reserves(year)
    time = year_to_time year
    (load_metric 'cash-reserves', time)['value']
  end

  def self.pipeline(year)
    time   = year_to_time year
    key =  "%s/%s" % [
        time.to_date.beginning_of_year,
        time.to_date.end_of_year
    ]
    (load_metric 'weighted-pipeline', time)['value'][key]
  end

  def self.articles(year)
    select_metric 'pr-pieces', year
  end

  def self.events_hosted(year)
    select_metric 'events-hosted', year
  end

  def self.people_trained(year = nil)
    data = select_metric 'people-trained', year
    if data.is_a? Hash
      if not data["total"].is_a? Hash
        total = data["total"]
      end
      data = year ? data.sum : data
      data["actual"] = total || data["actual"] # use override total if there. What a hack.
    end
    data
  end

  def self.trainers_trained(year = nil)
    select_metric 'trainers-trained', year
  end

  def self.network_size(year = nil, sections = nil)
    data = select_metric 'network-size', year
    if sections
      data.select!{|k,v| sections.include? k.to_sym }
    end
    year ? data.sum : data
  end

end
