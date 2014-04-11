require_relative 'metrics_helper'

class Hash
  def sum
    inject({}) do |acc, values|
      values[1].each_pair do |k,v|
        acc[k] ||= 0
        acc[k] += v
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

  def self.fixed_cost_breakdown(year = nil)
    c = total_costs year
    Hash[c['breakdown']['fixed'].map { |x|
      [x[0], x[1]['actual']]
    }]
  end

  def self.burn(year = nil)
    select_metric 'burn', year
  end

  def self.old_bookings(year = nil)
    select_metric 'bookings', year
  end

  def self.commercial_bookings(year = nil)
    bookings(:commercial, year)
  end

  def self.noncommercial_bookings(year = nil)
    bookings(:non_commercial, year)
  end

  def self.cumulative_bookings
    select_metric 'bookings',  nil
  end

  def self.bookings type, year = nil
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

  def self.cash_reserves
    load_metric('cash-reserves')["value"]
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
    year ? data.sum : data
  end

  def self.network_size(year = nil, sections = nil)
    data = select_metric 'network-size', year
    if sections
      data.select!{|k,v| sections.include? k.to_sym }
    end
    year ? data.sum : data
  end

end
