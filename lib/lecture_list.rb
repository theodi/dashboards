require 'json'
require 'net/http'
require 'active_support/core_ext/date/conversions'

class LectureList
  
  def self.update
    
    json = '
{
  "http://www.eventbrite.com/event/6339143549": {
    "name": "Friday lunchtime lectures: Something something data",
    "@type": "http://schema.org/EducationEvent",
    "startDate": "2013-05-31T13:00:00+00:00",
    "endDate": "2013-05-31T13:45:00+00:00",
    "capacity": 45,
    "additionalType": "http://linkedscience.org/teach/ns/#Lecture",
    "location": {
      "@type": "http://schema.org/Place",
      "name": "The ODI"
    },
    "offers": [
      {
        "@type": "http://schema.org/Offer",
        "name": "Guest",
        "price": 0.0,
        "priceCurrency": "GBP",
        "validThrough": "2013-05-31T12:00:00+00:00",
        "inventoryLevel": 40
      }
    ]
  },
  "http://www.eventbrite.com/event/6339320077": {
    "name": "Friday lunchtime lectures: We heard you like data...",
    "@type": "http://schema.org/EducationEvent",
    "startDate": "2013-06-07T13:00:00+00:00",
    "endDate": "2013-06-07T13:45:00+00:00",
    "capacity": 45,
    "additionalType": "http://linkedscience.org/teach/ns/#Lecture",
    "location": {
      "@type": "http://schema.org/Place",
      "name": "The ODI"
    },
    "offers": [
      {
        "@type": "http://schema.org/Offer",
        "name": "Guest",
        "price": 0.0,
        "priceCurrency": "GBP",
        "validThrough": "2013-06-07T12:00:00+00:00",
        "inventoryLevel": 42
      }
    ]
  }
}'
    lectures = JSON.parse(json)
    num = 0

    lecture_list = lectures.map do |url, data|
      tickets = get_tickets(data)
      num += 1
      {url: url, text: "#{data['name']} (#{Date.parse(data['startDate']).to_formatted_s(:short)})", tickets: tickets, capacity: data['capacity'], class: "class#{num}"}
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