require 'spec_helper'
require 'lecture_list'

describe LectureList do
  it "should load lectures from JSON and create list", :vcr do
    lecture_data = LectureList.update("Live")
    lecture_data[:items].size.should == 100
    lecture_data[:items].first[:text].should == "Friday lunchtime lectures: Will open data give citizens super powers?"
    lecture_data[:items].first[:date].should == "24 May"
    lecture_data[:items].first[:url].should == "http://www.eventbrite.com/event/6211220929"
  end
end