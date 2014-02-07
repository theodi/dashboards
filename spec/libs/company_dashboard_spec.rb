require 'spec_helper'
require 'company_dashboard'

describe CompanyDashboard do

  it "should show correct progress for each quarter", :vcr do
    progress = CompanyDashboard.progress(2013)
    progress[:q1].should == 97
    progress[:q2].should == 90.2
    progress[:q3].should == 93.1
    progress[:q4].should == 89.8

    progress = CompanyDashboard.progress(2014)
    progress[:q1].should == 9.8
    progress[:q2].should == 0
    progress[:q3].should == 0
    progress[:q4].should == 0
  end

  it "should show the correct number of published Open Data Certificates", :vcr do
    CompanyDashboard.odcs(2013).should == 599
    CompanyDashboard.odcs(2014).should == 641
    CompanyDashboard.odcs.should == 641
  end

  it "should show the correct member count", :vcr do
    CompanyDashboard.members(2013).should == 54
    CompanyDashboard.members(2014).should == 59
    CompanyDashboard.members.should == 59
  end

  it "should show the correct reach", :vcr do
    CompanyDashboard.reach(2014).should == 0
    CompanyDashboard.reach.should == 303396
  end

  it "should show the correct bookings value", :vcr do
    CompanyDashboard.bookings(2013).should == 2191064
    CompanyDashboard.bookings(2014).should == 0
    CompanyDashboard.bookings.should == 2191064
  end

  it "should show the correct non-commercial bookings value", :vcr do
    CompanyDashboard.noncommercial_bookings(2014).should == { "actual" => 0.0, "target" => 45.2 }
  end

  it "should show the correct unlocked value", :vcr do
    CompanyDashboard.value(2013).should == 16924307
    CompanyDashboard.value(2014).should == 0
    CompanyDashboard.value.should == 16924307
  end

  it "should show the correct kpi percentage", :vcr do
    CompanyDashboard.kpis(2013).should == 100.0
    CompanyDashboard.kpis(2014).should == 1.0
  end

  it "should show the correct grant funding", :vcr do
    CompanyDashboard.grant_funding(2014).should == { "actual" => 0.0, "target" => 3354.6176046176 }
  end

  it "should show the correct pipeline", :vcr do
    CompanyDashboard.pipeline(2014).should == 228603
  end
  
  it "should get fixed costs", :vcr do
    CompanyDashboard.fixed_cost_breakdown(2014).should == {
      "staff" => 0,
      "associates" => 0,
      "office_and_operational" => 0,
      "delivery" => 0,
      "communications" => 0,
      "professional_fees" => 0,
      "software" => 0,
    }
  end
  
  it "should get number of articles published", :vcr do
    CompanyDashboard.articles(2014).should == 0
  end
  
  it "should get number of people trained", :vcr do
    CompanyDashboard.people_trained(2014).should == {
      'actual' => 0,
      'annual_target' => 396,
      'ytd_target' => 51
    }
  end

end