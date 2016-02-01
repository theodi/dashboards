require 'spec_helper'
require 'event_list'

describe EventList do
  it "should load events from JSON and create list", :vcr do
    # Rewind to May 1
    Timecop.freeze(2013,5,1)
    # Run test
    event_data = EventList.update
    expect(event_data[:items].size).to eq(4)
    expect(event_data[:items].first[:text]).to eq(" ( 3 May)")
    expect(event_data[:items].first[:url]).to eq("http://www.eventbrite.com/event/6190416703")
    # Travel back to the future
    Timecop.return
  end
end