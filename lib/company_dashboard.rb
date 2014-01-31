require_relative 'metrics_helper'

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
    select_metric 'reach', year
  end

  def self.bookings(year = nil)
    select_metric 'bookings', year
  end
  
  def self.noncommercial_bookings(year = nil)
    select_metric 'non-commercial-bookings', year
  end
  
  def self.income_by_sector(year = nil)
    select_metric 'income-by-sector', year
  end

  def self.value(year = nil)
    select_metric 'value-unlocked', year
  end

  def self.kpis(year)
    select_metric 'kpi-performance', year if year # year should never be nil for this
  end
end
