require 'spec_helper'
require 'company_dashboard'

describe CompanyDashboard do
  
  it "should show correct progress for each quarter", :vcr do
    progress = CompanyDashboard.progress
    
    progress[:q1].should == 97
    progress[:q2].should == 90.2
    progress[:q3].should == 93.1
    progress[:q4].should == 87.2
  end
  
  it "should show the correct number of published Open Data Certificates", :vcr do
    CompanyDashboard.odcs.should == "628"
  end
  
  it "should show the correct member count", :vcr do
    CompanyDashboard.members.should == 57
  end
  
  it "should show the correct reach", :vcr do
    CompanyDashboard.reach.should == "303396"
  end
  
  it "should show the correct bookings value", :vcr do
    CompanyDashboard.bookings.to_i.should == 2191064
  end
  
  it "should show the correct unlocked value", :vcr do
    CompanyDashboard.value.to_i.should == 16924307
  end
  
  it "should show the correct kpi percentage", :vcr do
    CompanyDashboard.kpis.should == 100.0
  end
  
end