require 'spec_helper'
require 'company_dashboard'

describe CompanyDashboard do
  
  it "should show correct progress for each quarter", :vcr do
    progress = CompanyDashboard.progress
    
    progress[:q1].should == 97
    progress[:q2].should == 83.5
    progress[:q3].should == 54.7
  end
  
  it "should show the correct number of published Open Data Certificates", :vcr do
    CompanyDashboard.odcs.should == "20"
  end
  
  it "should show the correct member count", :vcr do
    CompanyDashboard.members.should == 9
  end
  
  it "should show the correct reach", :vcr do
    CompanyDashboard.reach.should == "117306"
  end
  
  it "should show the correct bookings value", :vcr do
    CompanyDashboard.bookings.should == "621400"
  end
  
  it "should show the correct unlocked value", :vcr do
    CompanyDashboard.value.should == "3310000"
  end
  
  it "should show the corrct kpi percentage", :vcr do
    CompanyDashboard.kpis.should == "95"
  end
  
end