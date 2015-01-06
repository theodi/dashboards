require 'spec_helper'
require 'commercial_dashboard'

describe CommercialDashboard do
  
  before :all do
    Timecop.freeze(2014,5,1)
  end
  
  it "should show the pipeline for the current year", :vcr do
    CommercialDashboard.pipeline.should == 470825
  end
  
  it "should show the weighted pipeline for the current year", :vcr do
    CommercialDashboard.weighted.should == 78026
  end  
  
  it "should show the pipeline for the next three years", :vcr do
    CommercialDashboard.three_year.should == 470825
  end
  
  it "should show the number of members", :vcr do
    CommercialDashboard.members.should == 52
  end
  
  it "should show the average age of opportunities", :vcr do
    CommercialDashboard.age.should == 156
  end
  
  it "should show a count of old opportunities", :vcr do
    CommercialDashboard.old_opportunities.should == 107
  end
  
  after :all do
    Timecop.return
  end
  
end