require 'trello'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_DEV_KEY']
  config.member_token = ENV['TRELLO_MEMBER_KEY']
end

class Progress

  def self.current_month(board_id)
    cards = []
    board = Trello::Board.find(board_id)
    board.cards.each do |card|
      if current_month?(card)
        cards << get_progress(card)
      end
    end
    cards
  end

  def self.rest_of_quarter(board_id)
    cards = []
    board = Trello::Board.find(board_id)
    board.cards.each do |card|
      unless current_month?(card)
        cards << get_progress(card)
      end
    end
    cards
  end

  def self.get_progress(card)
    progress = []
    total = 0
    complete = 0
    card.checklists.each do |checklist|
      unless checklist.check_items.count == 0
        total    += checklist.check_items.count
        complete += checklist.check_items.select { |item| item["state"]=="complete" }.count
      end
    end
    progress = complete.to_f / total.to_f
    progress = 0 if progress.nan?
    {title: card.name, progress: progress}
  end

  def self.current_month?(card)
    return false if card.due.nil?
    card.due.month == DateTime.now.month && card.due.year == DateTime.now.year
  end

end
