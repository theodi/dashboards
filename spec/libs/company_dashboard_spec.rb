require 'spec_helper'
require 'company_dashboard'

describe CompanyDashboard do

  it "should show correct progress for each quarter", :vcr do
    progress = CompanyDashboard.progress(2013)
    expect(progress[:q1]).to eq(97)
    expect(progress[:q2]).to eq(90.2)
    expect(progress[:q3]).to eq(93.4)
    expect(progress[:q4]).to eq(90.8)

    progress = CompanyDashboard.progress(2014)
    expect(progress[:q1]).to eq(91.8)
    expect(progress[:q2]).to eq(91.5)
    expect(progress[:q3]).to eq(84.1)
    expect(progress[:q4]).to eq(92.5)

    progress = CompanyDashboard.progress(2015)
    expect(progress[:q1]).to eq(68.9)
    expect(progress[:q2]).to eq(15.3)
    expect(progress[:q3]).to eq(0)
    expect(progress[:q4]).to eq(0)
  end

  it "should show the correct number of published Open Data Certificates", :vcr do
    expect(CompanyDashboard.odcs(2013)).to eq(599)
    expect(CompanyDashboard.odcs(2014)).to eq(10254)
    expect(CompanyDashboard.odcs(2015)).to eq(10518)
    expect(CompanyDashboard.odcs).to eq(10518)
  end

  it "should show the correct member count", :vcr do
    expect(CompanyDashboard.members(2013)).to eq(54)
    expect(CompanyDashboard.members(2014)).to eq(59)
    expect(CompanyDashboard.members).to eq(59)
  end

  it "should show the correct reach", :vcr do
    expect(CompanyDashboard.reach(2014)).to eq(541748)
    expect(CompanyDashboard.reach(2015)).to eq({
      "actual" => 383896,
      "annual_target" => 1000000,
      "ytd_target" => 470000
    })
    expect(CompanyDashboard.reach).to eq(1229040)
  end

  it "should show the correct unlocked value", :vcr do
    expect(CompanyDashboard.value(2013)).to eq(16924307)
    expect(CompanyDashboard.value(2014)).to eq(16569234)
    expect(CompanyDashboard.value(2015)).to eq(499511)
    expect(CompanyDashboard.value).to eq(32863121)
  end

  it "should show the correct burn rate", :vcr do
    expect(CompanyDashboard.burn(2014)).to eq(335128.44333333336)
    expect(CompanyDashboard.burn(2015)).to eq(182333.33333333334)
  end

  it "should show the correct cash reserves", :vcr do
    expect(CompanyDashboard.cash_reserves(2014)).to eq(839489.27)
    expect(CompanyDashboard.cash_reserves(2015)).to eq(1304880.05)
  end

  it "should show the correct kpi percentage", :vcr do
    expect(CompanyDashboard.kpis(2013)).to eq(100.0)
    expect(CompanyDashboard.kpis(2014)).to eq(1.0)
  end

  it "should show the correct grant funding", :vcr do
    expect(CompanyDashboard.grant_funding(2014)).to eq({
      "actual" => 0.0,
      "annual_target" => 3354617.6046176003,
      "ytd_target" => 373917.748917748
    })
  end

  it "should show the correct pipeline", :vcr do
    expect(CompanyDashboard.pipeline(2014)).to eq(228603)
  end

  it "should get the total costs", :vcr do
    expect(CompanyDashboard.total_costs(2014)).to eq({
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
    })

    expect(CompanyDashboard.total_costs(2015)).to eq({
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
    })
  end

  it "should get fixed cost breakdown", :vcr do
    expect(CompanyDashboard.cost_breakdown(2014, 'fixed')).to eq({
      "staff" => 1644713.0,
      "associates" => 472212.0,
      "office_and_operational" => 301261.87,
      "delivery" => 257644.72999999998,
      "communications" => 181889.0,
      "professional_fees" => 154921.9,
      "software" => 29239.88,
    })
  end

  it "should get cost breakdown", :vcr do
    expect(CompanyDashboard.cost_breakdown(2015)).to eq({
      "core" => 296000.0,
      "innovation" => 659000.0,
      "network" => 334000.0,
      "other" => 380000.0,
      "staff" => 648000.0,
    })
  end

  it "should get the headcount", :vcr do
    expect(CompanyDashboard.headcount(2014)).to eq({
      "actual" => 39.0,
      "annual_target" => 34.0,
      "ytd_target" => 34.0
    })

    expect(CompanyDashboard.headcount(2015)).to eq({
      "actual" => 55.0,
      "annual_target" => 52.0,
      "ytd_target" => 52.0
    })
  end

  it "should get EBITDA", :vcr do
    expect(CompanyDashboard.ebitda(2014)).to eq({
      "actual" => -1938527.1199999999,
      "annual_target" => -3003883.33333333,
      "latest" => -230153.0,
      "ytd_target" => -3003883.3333333326,
    })

    expect(CompanyDashboard.ebitda(2015)).to eq({
      "actual" => -1254000.0,
      "annual_target" => -3488000.0,
      "latest" => -300000.0,
      "ytd_target" => -1713000.0,
    })
  end

  it "should get number of articles published", :vcr do
    expect(CompanyDashboard.articles(2014)).to eq(0)
  end

  it "should get number of events hosted", :vcr do
    expect(CompanyDashboard.events_hosted(2014)).to eq(2)
  end

  it "should get number of people trained", :vcr do
    expect(CompanyDashboard.people_trained(2014)).to eq({
      'actual' => 702,
      'annual_target' => 396,
      'ytd_target' => 396
    })
    expect(CompanyDashboard.people_trained(2015)).to eq({
      'actual' => 657,
      'annual_target' => 1000,
      'ytd_target' => 480
    })
    expect(CompanyDashboard.people_trained).to eq(1593)
  end

  it "should get number of trainers trained", :vcr do
    expect(CompanyDashboard.trainers_trained(2015)).to eq({
      'actual' => 3,
      'annual_target' => 48,
      'ytd_target' => 23
    })
  end

  it "should get number of flagship stories", :vcr do
    expect(CompanyDashboard.flagship_stories(2015)).to eq({
      'actual' => 0,
      'annual_target' => 0,
      'ytd_target' => 0
    })
  end

  it "should get network size", :vcr do
    expect(CompanyDashboard.network_size(2014)).to eq({
      "actual" => 75,
      "annual_target" => 75,
      "ytd_target" => 75
    })

    expect(CompanyDashboard.network_size(2015)).to eq({
      "actual" => 157,
    })

    expect(CompanyDashboard.network_size).to eq(308)
  end

  it "should get network size for just one level", :vcr do
    expect(CompanyDashboard.network_size(2014, [:supporters])).to eq({
      "actual" => 17,
      "annual_target" => 34,
      "ytd_target" => 6
    })
    expect(CompanyDashboard.network_size).to eq(80)
  end

  it "should get network size for three levels", :vcr do
    expect(CompanyDashboard.network_size(2014, [:partners, :supporters, :sponsors])).to eq({
      "actual" => 19,
      "annual_target" => 49,
      "ytd_target" => 11
    })
    expect(CompanyDashboard.network_size).to eq(80)
  end

  it "should get income", :vcr do
    expect(CompanyDashboard.income(2014)).to eq({
      "actual" => 1588412.8499999999,
      "annual_target" => 2935183.33333333,
      "ytd_target" => 2935183.333333331
    })
    expect(CompanyDashboard.income(2015)).to eq({
      "actual" => 1064000.0,
      "annual_target" => 2862000.0,
      "ytd_target" => 1368000.0
    })
    expect(CompanyDashboard.income).to eq(7057000.0)
  end

  it "should get cumulative bookings value", :vcr do
    expect(CompanyDashboard.bookings).to eq(5405426)
  end

  it "should show the correct commercial bookings value", :vcr do
    expect(CompanyDashboard.commercial_bookings(2014)).to eq({
      'actual' => 14000.0,
      'annual_target' => 2952600.0,
      'ytd_target' => 158800
    })
  end

  it "should show the correct non-commercial bookings value", :vcr do
    expect(CompanyDashboard.noncommercial_bookings(2014)).to eq({
      "actual" => 0.0,
      "annual_target" => 1475980.0,
      "ytd_target" => 89780.0
    })
  end

  it "should show the correct 2015 bookings value", :vcr do
    expect(CompanyDashboard.bookings(2015)).to eq({
      "actual" => 335000,
      "annual_target" => 1044000,
      "ytd_target" => 420000
    })
  end

  it "should show the correct 2015 bookings by sector", :vcr do
    expect(CompanyDashboard.bookings_by_sector(2015)).to eq({
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
    })
  end

end
