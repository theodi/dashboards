require 'spec_helper'
require 'comms_dashboard'

describe CommsDashboard, :vcr do

  it "should list spokespeople" do
    CommsDashboard.spokespeople(2014).should == [
      {label: "Tim Berners-Lee", value: 18},
      {label: "Nigel Shadbolt", value: 16},
      {label: "Gavin Starks", value: 15},
      {label: "Jeni Tennison", value: 11},
      {label: "Kathryn Corrick", value: 6},
      {label: "Emma Thwaites", value: 4},
      {label: "Ulrich Atz", value: 3},
      {label: "Richard Stirling", value: 3},
      {label: "Waldo Jaquith", value: 3},
    ]
  end

end
