require 'trello'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_DEV_KEY']
  config.member_token = ENV['TRELLO_MEMBER_KEY']
end

class Progress

  def initialize(board_id)
    @board = Trello::Board.find(board_id)
    @discuss_list = discuss_list
    @done_list = done_list
  end

  def current_month
    cards = []
    @board.cards.each do |card|
      if current_month?(card) && card.closed == false && card.list.id != @discuss_list
        cards << get_progress(card)
      end
    end
    cards
  end

  def rest_of_quarter
    cards = []
    @board.cards.each do |card|
      unless current_month?(card)
        cards << get_progress(card) if (card.list.id != @done_list && card.list.id != @discuss_list)
      end
    end
    cards
  end

  def to_discuss
    cards = []
    @board.cards.each do |card|
      if card.list.id == @discuss_list
        cards << get_progress(card)
      end
    end
    cards
  end

  def done
    cards = []
    @board.cards.each do |card|
      if card.list.id == @done_list
        cards << get_progress(card)
      end
    end
    cards
  end

  def discuss_list
    get_list("to discuss")
  end

  def done_list
    get_list("done")
  end

  def get_list(name)
    @board.lists.select { |l| l.name.downcase == name.downcase }.first.id rescue nil
  end

  def current_month?(card)
    return false if card.due.nil?
    card.due.month == DateTime.now.month && card.due.year == DateTime.now.year
  end

  def get_progress(card)
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

end
