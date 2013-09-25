require 'spec_helper'
require 'company_dashboard'

describe CompanyDashboard do
  
  it "should show correct progress for each quarter", :vcr do
    progress = CompanyDashboard.progress
    
    progress[:q1].should == 97
    progress[:q2].should == 83.5
    progress[:q3].should == 54.7
  end
  
end