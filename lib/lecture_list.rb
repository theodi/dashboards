require 'json'
require 'net/http'
require 'active_support/core_ext/date/conversions'

class LectureList
  
  def self.update
    
    json = Net::HTTP.get URI.parse("http://theodi.org/lectures.json")
    lectures = JSON.parse(json)
    num = 0

    lecture_list = lectures.map do |url, data|
      tickets = get_tickets(data)
      num += 1
      {url: url, text: "#{data['name']} (#{Date.parse(data['startDate']).to_formatted_s(:short)})", tickets: tickets, capacity: data['capacity'], class: "item#{num}"}
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