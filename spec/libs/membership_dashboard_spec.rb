require 'spec_helper'
require 'membership_dashboard'

describe MembershipDashboard do
  
  it "should show the count of total members", :vcr do
    count = MembershipDashboard.count
    
    expect(count).to eq(10)
  end
  
  it "should show the members by level", :vcr do
    members = MembershipDashboard.by_level
    
    expect(members['member']).to eq("30")
    expect(members['partner']).to eq("10")
    expect(members['sponsor']).to eq("20")
    expect(members['supporter']).to eq("40")
  end
  
  it "should show upcoming renewals", :vcr do
    renewals = MembershipDashboard.renewals
             
    expect(renewals[0]).to eq({:title => "Next month", :items => [{:label=>"Supporters", :value=>0}, {:label=>"Sponsors", :value=>0}, {:label=>"Partners", :value=>0}, {:label=>"Members", :value=>0}]})
    expect(renewals[1]).to eq({:title => "Next quarter", :items => [{:label=>"Supporters", :value=>3}, {:label=>"Sponsors", :value=>0}, {:label=>"Partners", :value=>0}, {:label=>"Members", :value=>0}]})
    expect(renewals[2]).to eq({:title => "Next six months", :items => [{:label=>"Supporters", :value=>11}, {:label=>"Sponsors", :value=>0}, {:label=>"Partners", :value=>0}, {:label=>"Members", :value=>2}]})
  end
  
end