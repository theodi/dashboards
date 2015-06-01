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

  it "should show the correct unlocked value", :vcr do
    CompanyDashboard.value(2013).should == 16924307
    CompanyDashboard.value(2014).should == 0
    CompanyDashboard.value.should == 16924307
  end

  it "should show the correct cash reserves", :vcr do
    CompanyDashboard.cash_reserves.should == 1015006.28
  end

  it "should show the correct kpi percentage", :vcr do
    CompanyDashboard.kpis(2013).should == 100.0
    CompanyDashboard.kpis(2014).should == 1.0
  end

  it "should show the correct grant funding", :vcr do
    CompanyDashboard.grant_funding(2014).should == {
      "actual" => 0.0,
      "annual_target" => 3354617.6046176003,
      "ytd_target" => 373917.748917748
    }
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

  it "should get number of events hosted", :vcr do
    CompanyDashboard.events_hosted(2014).should == 2
  end

  it "should get number of people trained", :vcr do
    CompanyDashboard.people_trained(2014).should == {
      'actual' => 497,
      'annual_target' => 396,
      'ytd_target' => 369
    }
    CompanyDashboard.people_trained.should == 731
  end

  it "should get network size", :vcr do
    CompanyDashboard.network_size(2014).should == {
      "actual" => 5,
      "annual_target" => 75,
      "ytd_target" => 13
    }
    CompanyDashboard.network_size.should == 80
  end

  it "should get network size for just one level", :vcr do
    CompanyDashboard.network_size(2014, [:supporters]).should == {
      "actual" => 17,
      "annual_target" => 34,
      "ytd_target" => 6
    }
    CompanyDashboard.network_size.should == 80
  end

  it "should get network size for three levels", :vcr do
    CompanyDashboard.network_size(2014, [:partners, :supporters, :sponsors]).should == {
      "actual" => 19,
      "annual_target" => 49,
      "ytd_target" => 11
    }
    CompanyDashboard.network_size.should == 80
  end

  it "should get income", :vcr do
    CompanyDashboard.income(2014).should == {
      "actual" => 88468.0,
      "annual_target" => 2935183.33333333,
      "ytd_target" => 280543.3333333333
    }
    CompanyDashboard.income.should == 91123
  end

  it "should get cumulative bookings value", :vcr do
    CompanyDashboard.bookings.should == 686000
  end

  it "should show the correct commercial bookings value", :vcr do
    CompanyDashboard.commercial_bookings(2014).should == {
      'actual' => 14000.0,
      'annual_target' => 2952600.0,
      'ytd_target' => 158800
    }
  end

  it "should show the correct non-commercial bookings value", :vcr do
    CompanyDashboard.noncommercial_bookings(2014).should == {
      "actual" => 0.0,
      "annual_target" => 1475980.0,
      "ytd_target" => 89780.0
    }
  end

end
