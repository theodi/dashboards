require_relative 'metrics_helper'

class Progress

  attr_accessor :done, :to_discuss

  def initialize(year, quarter)
    @outstanding = MetricsHelper.load_metric("#{year}-#{quarter}-outstanding-tasks")['value']
    @done = MetricsHelper.load_metric("#{year}-#{quarter}-completed-tasks")['value']
    @to_discuss = MetricsHelper.load_metric("#{year}-#{quarter}-tasks-to-discuss")['value']
  end

  def current_month
    @outstanding.select { |card| current_month?(card) }
  end

  def rest_of_quarter
    @outstanding.select { |card| !current_month?(card) }
  end

  def current_month?(card)
    return false if card["due"].nil?
    DateTime.parse(card["due"]).month == DateTime.now.month && DateTime.parse(card["due"]).year == DateTime.now.year
  end

end
