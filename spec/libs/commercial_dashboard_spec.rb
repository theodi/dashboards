require 'spec_helper'
require 'commercial_dashboard'

describe CommercialDashboard do
  
  it "should show the number of members", :vcr do
    CommercialDashboard.members.should == 52
  end
  
  it "should show the average age of opportunities", :vcr do
    CommercialDashboard.age.should == 156
  end
  
end