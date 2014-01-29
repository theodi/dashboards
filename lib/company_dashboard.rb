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
    response = HTTParty.get("https://certificates.theodi.org/status.csv").body
    csv      = CSV.parse(response)
    csv.last[3].to_i
  end

  def self.members(year = nil)
    time = year ? DateTime.new(year).end_of_year : nil
    (load_metric 'membership-count', time)['value']['total']
  end

  def self.reach(year = nil)
    if year.nil?
      years.inject(0) { |total, year| total += reach(year) }
    else
      metrics_spreadsheet(year)[1, 2].to_i
    end
  end

  def self.bookings(year = nil)
    if year.nil?
      years.inject(0) { |total, year| total += bookings(year) }
    else
      metrics_spreadsheet(year)[4, 2].to_i
    end
  end

  def self.value(year = nil)
    if year.nil?
      years.inject(0) { |total, year| total += value(year) }
    else
      metrics_spreadsheet(year)[3, 2].to_i
    end
  end

  def self.kpis(year)
    metrics_spreadsheet(year)[2, 2].to_f.round(1)
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
