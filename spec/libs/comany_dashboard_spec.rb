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
end