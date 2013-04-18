require 'net/http'
require 'active_support/core_ext/date/conversions'

SCHEDULER.every '1h', :first_at => Time.now do

  json = Net::HTTP.get URI.parse("http://www.theodi.org/sites/default/files/courses.json")
  events = JSON.parse(json)

  event_data = events.map do |url, data|
    {url: url, text: "event name (#{Date.parse(data['startDate']).to_formatted_s(:short)})" }
  end

  send_event('event-list', { items: event_data })
end