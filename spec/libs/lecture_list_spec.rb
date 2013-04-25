require 'spec_helper'
require 'lecture_list'

describe LectureList do
  it "should load lectures from JSON and create list", :vcr do
    lecture_data = LectureList.update
    lecture_data[:items].size.should == 5
    lecture_data[:items].first[:text].should == "Friday Lunchtime Lectures: Big Data Week Special - Data as Culture"
    lecture_data[:items].first[:date].should == "26 Apr"
    lecture_data[:items].first[:url].should == "http://www.eventbrite.com/event/6153638699"
  end
end