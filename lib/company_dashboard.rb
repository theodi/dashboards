require 'dotenv'
require 'trello'
require 'httparty'
require 'csv'
require 'google_drive'
require 'capsulecrm'
require 'date'
require 'active_support/core_ext/date/calculations'

require_relative 'metrics_helper'

Dotenv.load

CapsuleCRM.account_name = ENV['CAPSULECRM_ACCOUNT_NAME']
CapsuleCRM.api_token    = ENV['CAPSULECRM_API_TOKEN']
CapsuleCRM.initialize!

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_DEV_KEY']
  config.member_token         = ENV['TRELLO_MEMBER_KEY']
end

class CompanyDashboard < MetricsHelper

  def self.progress(year)

    board_ids = {
        2013 => {
            :q1 => 'cEwY2JHh',
            :q2 => 'm5Gxybf6',
            :q3 => 'wkIzhRE3',
            :q4 => '5IZH6yGG',
        },
        2014 => {
            :q1 => '8P2Hgzlh',
            :q2 => nil,
            :q3 => nil,
            :q4 => nil,
        },
    }

    totals = {}

    board_ids[year].each do |q, id|
      progress = get_board_progress(id)
      if progress.empty?
        totals[q] = 0
      else
        totals[q] = (100 * (progress.inject { |sum, element| sum += element } / progress.size)).round(1)
      end
    end

    totals

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

  def self.value(year = nil)
    select_metric 'value-unlocked', year
  end

  def self.kpis(year)
    select_metric 'kpi-performance', year if year # year should never be nil for this
  end

  def self.get_board_progress(id)
    return [] if id.nil?

    progress = []
    board    = Trello::Board.find(id)

    board.cards.each do |card|
      card.checklists.each do |checklist|
        total = checklist.check_items.count
        unless total == 0
          complete      = checklist.check_items.select { |item| item["state"]=="complete" }.count
          task_progress = complete.to_f/total.to_f
          progress << task_progress
        end
      end
    end

    progress
  end

  def self.google_drive
    GoogleDrive.login(ENV['GAPPS_USER_EMAIL'], ENV['GAPPS_PASSWORD'])
  end

  def self.metrics_spreadsheet(year)
    google_drive.spreadsheet_by_key(ENV['GAPPS_METRICS_SPREADSHEET_ID']).worksheet_by_title year.to_s
  end

  def self.years
    2013..Date.today.year
  end
end
