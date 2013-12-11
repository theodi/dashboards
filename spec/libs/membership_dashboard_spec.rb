require 'spec_helper'
require 'membership_dashboard'

describe MembershipDashboard do
  
  it "should show the count of total members", :vcr do
    count = MembershipDashboard.count
    
    count.should == 10
  end
  
end