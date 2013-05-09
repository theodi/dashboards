require 'spec_helper'
require 'event_list'

describe EventList do
  it "should load events from JSON and create list", :vcr do
    # Rewind to May 1
    Timecop.freeze(2013,5,1)
    # Run test
    event_data = EventList.update
    event_data[:items].size.should == 4
    event_data[:items].first[:text].should == " ( 3 May)"
    event_data[:items].first[:url].should == "http://www.eventbrite.com/event/6190416703"
    # Travel back to the future
    Timecop.return
  end
end