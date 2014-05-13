require 'json'
require 'net/http'
require 'active_support/all'

class EventList

  def self.update

    json = Net::HTTP.get URI.parse("http://theodi.org/courses.json")
    events = JSON.parse(json)

    event_list = events.map do |url, data|
      if Date.parse(data['startDate']) >= Date.today
        {url: url, text: "#{data['name']} (#{Date.parse(data['startDate']).to_formatted_s(:short)})" }
      end
    end

    { items: event_list.compact }

  end

end
