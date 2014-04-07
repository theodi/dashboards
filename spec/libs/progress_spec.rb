require 'spec_helper'
require 'progress'

describe Progress do

  it "returns the correct progress for the current month", :vcr do
    Timecop.travel("2014-04-01")
    current = Progress.current_month("sFETRDq0")
    current.count.should == 6
    current[0].should == {:title=>"Organise, plan & deliver ODI startup pitch morning", :progress=>0.0}
    current[1].should == {:title=>"Linked Data on the Web workshop at WWW2014", :progress=>0.0}
    current[2].should == {:title=>"H2020 Bids complete and submitted", :progress=>0.0}
    current[3].should == {:title=>"Complete First Period of DaPaaS Reporting", :progress=>0.0}
    current[4].should == {:title=>"Deliver 12 month comms plan [and deliver Q-2 related items]", :progress=>0.2}
    current[5].should == {:title=>"Create plan for proactive events & conferences", :progress=>0.25}
    Timecop.return
  end

  it "returns the correct progress for a card" do
    checklist = double("Trello::Checklist", check_items: [
        {
          "name" => "Do this thing",
          "state" => "complete"
        },
        {
          "name" => "Do that thing",
          "state" => "Incomplete"
        }
      ])

    card = double("Trello::Card", checklists: [checklist], name: "This is a card")
    Progress.get_progress(card).should == { title: "This is a card", progress: 0.5 }
  end

  it "returns the correct progress for a card with multiple checklists" do
    checklists = [
        double("Trello::Checklist", check_items: [
          {
            "name" => "Do this thing",
            "state" => "complete"
          },
          {
            "name" => "Do that thing",
            "state" => "Incomplete"
          }
        ]),
        double("Trello::Checklist", check_items: [
          {
            "name" => "Do this thing",
            "state" => "complete"
          },
          {
            "name" => "Do that thing",
            "state" => "complete"
          }
        ])
      ]

    card = double("Trello::Card", checklists: checklists, name: "This is a card")
    Progress.get_progress(card).should == { title: "This is a card", progress: 0.75 }
  end

  it "returns true if the card is in the current month" do
    Timecop.travel("2014-04-01")
    card = double("Trello::Card", due: Date.new(2014, 4, 12))
    Progress.current_month?(card).should be_true
    Timecop.return
  end

  it "returns false if the card is not in the current month" do
    Timecop.travel("2014-04-01")
    card = double("Trello::Card", due: Date.new(2014, 5, 12))
    Progress.current_month?(card).should_not be_true
    Timecop.return
  end

  it "returns false if the due date is nil" do
    card = double("Trello::Card", due: nil)
    Progress.current_month?(card).should_not be_true
  end

end
