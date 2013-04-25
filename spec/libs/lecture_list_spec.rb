require 'spec_helper'
require 'lecture_list'

describe LectureList do
  it "should load lectures from JSON and create list", :vcr do
    lecture_data = LectureList.update
    lecture_data[:items].size.should == 5
    lecture_data[:items].first[:text].should == "Friday Lunchtime Lectures: Big Data Week Special - Data as Culture (26 Apr)"
    lecture_data[:items].first[:url].should == "http://www.eventbrite.com/event/6153638699"
    lecture_data[:items].first[:tickets].should == 1
    lecture_data[:items].first[:capacity].should == 100
  end
end