require 'spec_helper'
require 'company_dashboard'

describe CompanyDashboard do

  it "should show correct progress for each quarter", :vcr do
    progress = CompanyDashboard.progress(2013)
    progress[:q1].should == 97
    progress[:q2].should == 90.2
    progress[:q3].should == 93.4
    progress[:q4].should == 90.8

    progress = CompanyDashboard.progress(2014)
    progress[:q1].should == 91.8
    progress[:q2].should == 91.5
    progress[:q3].should == 84.1
    progress[:q4].should == 92.5

    progress = CompanyDashboard.progress(2015)
    progress[:q1].should == 68.9
    progress[:q2].should == 15.3
    progress[:q3].should == 0
    progress[:q4].should == 0
  end

  it "should show the correct number of published Open Data Certificates", :vcr do
    CompanyDashboard.odcs(2013).should == 599
    CompanyDashboard.odcs(2014).should == 10254
    CompanyDashboard.odcs(2015).should == 10518
    CompanyDashboard.odcs.should == 10518
  end

  it "should show the correct member count", :vcr do
    CompanyDashboard.members(2013).should == 54
    CompanyDashboard.members(2014).should == 59
    CompanyDashboard.members.should == 59
  end

  it "should show the correct reach", :vcr do
    CompanyDashboard.reach(2014).should == 541748
    CompanyDashboard.reach(2015).should == {
      "actual" => 383896,
      "annual_target" => 1000000,
      "ytd_target" => 470000
    }
    CompanyDashboard.reach.should == 1229040
  end

  it "should show the correct unlocked value", :vcr do
    CompanyDashboard.value(2013).should == 16924307
    CompanyDashboard.value(2014).should == 16569234
    CompanyDashboard.value(2015).should == 499511
    CompanyDashboard.value.should == 32863121
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

  it "should get the total costs", :vcr do
    CompanyDashboard.total_costs(2014).should == {
      "actual" => 3526939.9699999997,
      "annual_target" => 5939066.66666667,
      "ytd_target" => 5939066.66666667,
      "breakdown" => {
        "variable" => {
          "research" => {
            "actual" => 61185.020000000004,
            "annual_target" => 447916.66666666704,
            "ytd_target" => 447916.66666666657
          },
          "training" => {
            "actual" => 43592.29,
            "annual_target" => 123560.0,
            "ytd_target" => 123559.99999999997
          },
          "projects" => {
            "actual" => 341327.33,
            "annual_target" => 397925.0,
            "ytd_target" => 397925.0000000004
          },
          "network" => {
            "actual" => 38952.950000000004,
            "annual_target" => 100695.0,
            "ytd_target" => 100695.00000000003
          }
        },
        "fixed" => {
          "staff" => {
            "actual" => 1644713.0,
            "annual_target" => 2113000.0,
            "ytd_target" => 2113000.0
          },
          "associates" => {
              "actual" => 472212.0,
            "annual_target" => 858000.0,
            "ytd_target" => 858000.0
          },
          "office_and_operational" => {
            "actual" => 301261.87,
            "annual_target" => 494000.0,
            "ytd_target" => 494000.0000000003
          },
          "delivery" => {
            "actual" => 257644.72999999998,
            "annual_target" => 778270.0,
            "ytd_target" => 778269.9999999992
          },
          "communications" => {
            "actual" => 181889.0,
            "annual_target" => 315000.0,
            "ytd_target" => 315000.0
          },
          "professional_fees" => {
            "actual" => 154921.9,
            "annual_target" => 200000.0,
            "ytd_target" => 200000.00000000035
          },
          "software" => {
            "actual" => 29239.88,
            "annual_target" => 110700.0,
            "ytd_target" => 110700.0
          }
        }
      }
    }

    CompanyDashboard.total_costs(2015).should == {
      "actual" => 2317000.0,
      "annual_target" => 6252000.0,
      "ytd_target" => 3029000.0,
      "breakdown" => {
        "network" => {
          "actual" => 334000.0,
          "annual_target" => 1195000.0,
          "ytd_target" => 585000.0,
        },
        "innovation" => {
          "actual" => 659000.0,
          "annual_target" => 1891000.0,
          "ytd_target" => 950000.0,
        },
        "core" => {
          "actual" => 296000.0,
          "annual_target" => 936000.0,
          "ytd_target" => 410000.0,
        },
        "staff" => {
          "actual" => 648000.0,
          "annual_target" => 1230000.0,
          "ytd_target" => 607000.0,
        },
        "other" => {
          "actual" => 380000.0,
          "annual_target" => 1000000.0,
          "ytd_target" => 477000.0,
        }
      }
    }
  end

  it "should get fixed cost breakdown", :vcr do
    CompanyDashboard.cost_breakdown(2014, 'fixed').should == {
      "staff" => 1644713.0,
      "associates" => 472212.0,
      "office_and_operational" => 301261.87,
      "delivery" => 257644.72999999998,
      "communications" => 181889.0,
      "professional_fees" => 154921.9,
      "software" => 29239.88,
    }
  end

  it "should get cost breakdown", :vcr do
    CompanyDashboard.cost_breakdown(2015).should == {
      "core" => 296000.0,
      "innovation" => 659000.0,
      "network" => 334000.0,
      "other" => 380000.0,
      "staff" => 648000.0,
    }
  end

  it "should get the headcount", :vcr do
    CompanyDashboard.headcount(2014).should == {
      "actual" => 39.0,
      "annual_target" => 34.0,
      "ytd_target" => 34.0
    }

    CompanyDashboard.headcount(2015).should == {
      "actual" => 55.0,
      "annual_target" => 52.0,
      "ytd_target" => 52.0
    }
  end

  it "should get EBITDA", :vcr do
    CompanyDashboard.ebitda(2014).should == {
      "actual" => -1938527.1199999999,
      "annual_target" => -3003883.33333333,
      "latest" => -230153.0,
      "ytd_target" => -3003883.3333333326,
    }

    CompanyDashboard.ebitda(2015).should == {
      "actual" => -1254000.0,
      "annual_target" => -3488000.0,
      "latest" => -300000.0,
      "ytd_target" => -1713000.0,
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
      'actual' => 702,
      'annual_target' => 396,
      'ytd_target' => 396
    }
    CompanyDashboard.people_trained(2015).should == {
      'actual' => 657,
      'annual_target' => 1000,
      'ytd_target' => 480
    }
    CompanyDashboard.people_trained.should == 1593
  end

  it "should get number of trainers trained", :vcr do
    CompanyDashboard.trainers_trained(2015).should == {
      'actual' => 3,
      'annual_target' => 48,
      'ytd_target' => 23
    }
  end

  it "should get number of flagship stories", :vcr do
    CompanyDashboard.flagship_stories(2015).should == {
      'actual' => 0,
      'annual_target' => 0,
      'ytd_target' => 0
    }
  end

  it "should get network size", :vcr do
    CompanyDashboard.network_size(2014).should == {
      "actual" => 75,
      "annual_target" => 75,
      "ytd_target" => 75
    }

    CompanyDashboard.network_size.should == 258
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
      "actual" => 1588412.8499999999,
      "annual_target" => 2935183.33333333,
      "ytd_target" => 2935183.333333331
    }
    CompanyDashboard.income(2015).should == {
      "actual" => 1064000.0,
      "annual_target" => 2862000.0,
      "ytd_target" => 1368000.0
    }
    CompanyDashboard.income.should == 7057000.0
  end

  it "should get cumulative bookings value", :vcr do
    CompanyDashboard.bookings.should == 5405426
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

  it "should show the correct 2015 bookings value", :vcr do
    CompanyDashboard.bookings(2015).should == {
      "actual" => 335000,
      "annual_target" => 1044000,
      "ytd_target" => 420000
    }
  end

  it "should show the correct 2015 bookings by sector", :vcr do
    CompanyDashboard.bookings_by_sector(2015).should == {
      "core" => {
        "actual" => 29000.0,
        "annual_target" => 191000.0,
        "ytd_target" => 20000.0
      },
      "innovation" => {
        "actual" => 589000.0,
        "annual_target" => 1419000.0,
        "ytd_target" => 791000.0
      },
      "network" => {
        "actual" => 467000.0,
        "annual_target" => 1252000.0,
        "ytd_target" => 558000.0
      },
    }
  end

end
