require 'spec_helper'
require 'membership_dashboard'

describe MembershipDashboard do
  
  it "should show the count of total members", :vcr do
    count = MembershipDashboard.count
    
    count.should == 10
  end
  
  it "should show the members by level", :vcr do
    members = MembershipDashboard.by_level
    
    members['member'].should == "30"
    members['partner'].should == "10"
    members['sponsor'].should == "20"
    members['supporter'].should == "40"
  end
  
  it "should show upcoming renewals", :vcr do
    renewals = MembershipDashboard.renewals
             
    renewals[0].should == {:title => "Next month", :items => [{:label=>"Supporters", :value=>0}, {:label=>"Sponsors", :value=>0}, {:label=>"Partners", :value=>0}, {:label=>"Members", :value=>0}]}
    renewals[1].should == {:title => "Next quarter", :items => [{:label=>"Supporters", :value=>3}, {:label=>"Sponsors", :value=>0}, {:label=>"Partners", :value=>0}, {:label=>"Members", :value=>0}]}
    renewals[2].should == {:title => "Next six months", :items => [{:label=>"Supporters", :value=>11}, {:label=>"Sponsors", :value=>0}, {:label=>"Partners", :value=>0}, {:label=>"Members", :value=>2}]}
  end
  
end