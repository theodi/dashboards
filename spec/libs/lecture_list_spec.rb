require 'spec_helper'
require 'lecture_list'

describe LectureList do
  it "should load lectures from JSON and create list", :vcr do
    lecture_data = LectureList.update("Live")
    expect(lecture_data[:items].size).to eq(5)
    expect(lecture_data[:items].first[:text]).to eq("Friday lunchtime lectures: Will open data give citizens super powers?")
    expect(lecture_data[:items].first[:date]).to eq("24 May")
    expect(lecture_data[:items].first[:url]).to eq("http://www.eventbrite.com/event/6211220929")
  end
end