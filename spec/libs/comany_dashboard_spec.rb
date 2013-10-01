require 'spec_helper'
require 'company_dashboard'

describe CompanyDashboard do
  
  it "should show correct progress for each quarter", :vcr do
    progress = CompanyDashboard.progress
    
    progress[:q1].should == 97
    progress[:q2].should == 83.8
    progress[:q3].should == 66.6
    progress[:q4].should == 0.6
  end
  
  it "should show the correct number of published Open Data Certificates", :vcr do
    CompanyDashboard.odcs.should == "511"
  end
  
  it "should show the correct member count", :vcr do
    CompanyDashboard.members.should == 9
  end
  
  it "should show the correct reach", :vcr do
    CompanyDashboard.reach.should == "117306"
  end
  
  it "should show the correct bookings value", :vcr do
    CompanyDashboard.bookings.should == "621000"
  end
  
  it "should show the correct unlocked value", :vcr do
    CompanyDashboard.value.should == "19027000"
  end
  
  it "should show the corrct kpi percentage", :vcr do
    CompanyDashboard.kpis.should == 95
  end
  
end