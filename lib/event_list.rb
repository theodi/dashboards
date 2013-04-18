require 'json'
require 'net/http'
require 'active_support/core_ext/date/conversions'

class EventList
  
  def self.update
    
    json = Net::HTTP.get URI.parse("http://www.theodi.org/sites/default/files/courses.json")
    events = JSON.parse(json)

    event_list = events.map do |url, data|
      {url: url, text: "event name (#{Date.parse(data['startDate']).to_formatted_s(:short)})" }
    end

    { items: event_list }

  end
  
end