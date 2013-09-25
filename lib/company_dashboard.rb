require 'dotenv'
require 'trello'
require 'httparty'
require 'csv'

Dotenv.load

Trello.configure do |config|
    config.developer_public_key = ENV['TRELLO_DEV_KEY']
    config.member_token = ENV['TRELLO_MEMBER_TOKEN']
end

class CompanyDashboard
  
  def self.progress
    
    board_ids = {
      :q1 => ENV['TRELLO_2013Q1'],
      :q2 => ENV['TRELLO_2013Q2'],
      :q3 => ENV['TRELLO_2013Q3']
    }
    
    totals = {}
    
    board_ids.each do |q, id|
      progress = get_board_progress(id)        
      totals[q] = (100 * (progress.inject{ |sum,element| sum += element } / progress.size )).round(1)
    end
    
    totals
  end
  
  def self.odcs
    response = HTTParty.get("https://certificates.theodi.org/status.csv").body
    csv = CSV.parse(response)
    csv.last[4]
  end
  def self.get_board_progress(id)    
    progress = []
    board = Trello::Board.find(id)
    
    board.cards.each do |card|
      card.checklists.each do |checklist|
        total = checklist.check_items.count
        unless total == 0
          complete = checklist.check_items.select{|item| item["state"]=="complete"}.count
    			task_progress =  complete.to_f/total.to_f
    			progress << task_progress
			  end
      end
    end
    
    progress
  end
  
end
