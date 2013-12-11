require 'spec_helper'
require 'membership_dashboard'

describe MembershipDashboard do
  
  it "should show the count of total members", :vcr do
    count = MembershipDashboard.count
    
    count.should == 10
  end
  
  it "should show the members by level", :vcr do
    members = MembershipDashboard.by_level
    
    members['member'].should == 3
    members['partner'].should == 1
    members['sponsor'].should == 2
    members['supporter'].should == 4
  end
  
end