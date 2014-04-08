require 'spec_helper'
require 'progress'

describe Progress do

  before(:all) do
    VCR.use_cassette('Progress/progress_spec') do
      @progress = Progress.new("B5MnBDfR")
    end
  end

  it "returns the correct progress for the current month", :vcr do
    Timecop.travel("2014-04-01")
    current = @progress.current_month
    current.count.should == 1
    current[0].should == {:title=>"One card", :progress=>0.5, :no_checklist => false}
    Timecop.return
  end

  it "returns the correct progress for the rest of the quarter", :vcr do
    Timecop.travel("2014-04-01")
    rest_of_quarter = @progress.rest_of_quarter
    rest_of_quarter.count.should == 3
    rest_of_quarter[0].should == {:title=>"Two cards", :progress=>0.0, :no_checklist => false}
    rest_of_quarter[1].should == {:title=>"Another card", :progress=>0.5, :no_checklist => false}
    rest_of_quarter[2].should == {:title=>"No checklist!", :progress=>0, :no_checklist => true}
    Timecop.return
  end

  it "returns the correct to discuss cards", :vcr do
    to_discuss = @progress.to_discuss
    to_discuss.count.should == 1
    to_discuss[0].should == {:title => "Let's have a chat about this one", :progress => 0.0, :no_checklist => false}
  end

  it "returns the correct done cards", :vcr do
    done = @progress.done
    done.count.should == 1
    done[0].should == {:title => "We've done this one", :progress => 1.0, :no_checklist => false}
  end

  it "returns the correct ID of the 'to discuss' list", :vcr do
    @progress.discuss_list.should == "5343be8b0876eb6e19c59baa"
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
    @progress.send(:get_progress, card).should == { title: "This is a card", progress: 0.5, :no_checklist => false }
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
    @progress.send(:get_progress, card).should == { title: "This is a card", progress: 0.75, :no_checklist => false }
  end

  it "returns a warning if there is no checklist" do
    card = double("Trello::Card", checklists: [], name: "This is a card")
    @progress.send(:get_progress, card).should == { title: "This is a card", progress: 0, :no_checklist => true }
  end

  it "returns true if the card is in the current month" do
    Timecop.travel("2014-04-01")
    card = double("Trello::Card", due: Date.new(2014, 4, 12))
    @progress.send(:current_month?, card).should be_true
    Timecop.return
  end

  it "returns false if the card is not in the current month" do
    Timecop.travel("2014-04-01")
    card = double("Trello::Card", due: Date.new(2014, 5, 12))
    @progress.send(:current_month?, card).should_not be_true
    Timecop.return
  end

  it "returns false if the due date is nil" do
    card = double("Trello::Card", due: nil)
    @progress.send(:current_month?, card).should_not be_true
  end

end
