require 'spec_helper'
require 'commercial_dashboard'

describe CommercialDashboard do
  
  before :all do
    Timecop.freeze(2014,5,1)
  end
  
  it "should show the pipeline for the current year", :vcr do
    expect(CommercialDashboard.pipeline).to eq(470825)
  end
  
  it "should show the weighted pipeline for the current year", :vcr do
    expect(CommercialDashboard.weighted).to eq(78026)
  end  
  
  it "should show the pipeline for the next three years", :vcr do
    expect(CommercialDashboard.three_year).to eq(470825)
  end
  
  it "should show the number of members", :vcr do
    expect(CommercialDashboard.members).to eq(52)
  end
  
  it "should show the average age of opportunities", :vcr do
    expect(CommercialDashboard.age).to eq(156)
  end
  
  it "should show a count of old opportunities", :vcr do
    expect(CommercialDashboard.old_opportunities).to eq(107)
  end
  
  after :all do
    Timecop.return
  end
  
end