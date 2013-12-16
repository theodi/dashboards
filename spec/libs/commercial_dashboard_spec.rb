require 'spec_helper'
require 'commercial_dashboard'

describe CommercialDashboard do
  
  it "should show the pipeline for the current year", :vcr do
    CommercialDashboard.pipeline.should == 2569025
  end
  
  it "should show the weighted pipeline for the current year", :vcr do
    CommercialDashboard.weighted.should == 735580
  end  
  
  it "should show the pipeline for the next three years", :vcr do
    CommercialDashboard.three_year.should == 2665145
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
  
end