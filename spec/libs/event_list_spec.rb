require 'spec_helper'
require 'event_list'

describe EventList do
  it "should load events from JSON and create list", :vcr do
    event_data = EventList.update
    event_data[:items].size.should == 5
    event_data[:items].first[:text].should == " (26 Apr)"
    event_data[:items].first[:url].should == "http://www.eventbrite.com/event/6153638699"
  end
end