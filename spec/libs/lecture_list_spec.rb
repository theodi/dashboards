require 'spec_helper'
require 'lecture_list'

describe LectureList do
  it "should load lectures from JSON and create list" do
    lecture_data = LectureList.update
    lecture_data[:items].size.should == 2
    lecture_data[:items].first[:text].should == "Friday lunchtime lectures: Something something data (31 May)"
    lecture_data[:items].first[:url].should == "http://www.eventbrite.com/event/6339143549"
    lecture_data[:items].first[:tickets].should == 40
    lecture_data[:items].first[:capacity].should == 45
  end
end