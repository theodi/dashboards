require 'json'
require 'net/http'
require 'active_support/all'

class LectureList

  def self.update(status)

    json = Net::HTTP.get URI.parse("http://theodi.org/lectures.json")

    lectures = JSON.parse(json)

    lecture_list = lectures.map do |url, data|
      if data['status'] == status
        tickets = get_tickets(data)
        capacity = data['capacity']

        people = ""
        (capacity - tickets).times { people += "<span class='icon-user'></span>" }
        tickets.times { people += "<span class='icon-user available'></span>" }

        {url: url, text: data['name'], date: Date.parse(data['startDate']).to_formatted_s(:short).strip, people: people }
      end
    end

    list = lecture_list.compact

    dots = ""
    list.count.times { dots += "<span class='icon-circle'></span>" }

    { items: list, dots: dots }

  end

  def self.get_tickets(data)
    tickets = 0
    data['offers'].each do |offer|
      tickets += offer['inventoryLevel']
    end
    return tickets
  end


end
