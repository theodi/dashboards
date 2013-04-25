require 'json'
require 'net/http'
require 'active_support/core_ext/date/conversions'

class LectureList
  
  def self.update
    
    json = Net::HTTP.get URI.parse("http://theodi.org/lectures.json")
    lectures = JSON.parse(json)

    lecture_list = lectures.map do |url, data|
      tickets = get_tickets(data)
      capacity = data['capacity']
      
      people = ""
      (capacity - tickets).times { people += "<span class='icon-user'></span>" }
      tickets.times { people += "<span class='icon-user available'></span>" }
      
      {url: url, text: data['name'], date: Date.parse(data['startDate']).to_formatted_s(:short).strip, people: people }
    end

    { items: lecture_list }

  end
  
  def self.get_tickets(data)
    tickets = 0
    data['offers'].each do |offer|
      tickets += offer['inventoryLevel']
    end
    return tickets
  end

  
end