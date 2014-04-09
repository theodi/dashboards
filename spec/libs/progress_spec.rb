require 'spec_helper'
require 'progress'

describe Progress do

  before(:all) do
    outstanding = {
      _id: "whevs",
      name: "2014-q1-outstanding-tasks",
      time: "2014-04-08T19:43:13+00:00",
      value: [
        {
          title: "One card",
          due: "2014-04-10T11:00:00Z",
          progress: 0.5,
          no_checklist: false
        },
        {
          title: "Two cards",
          due: nil,
          progress: 0.0,
          no_checklist: false
        },
        {
          title: "Another card",
          due: nil,
          progress: 0.5,
          no_checklist: false
        },
        {
          title: "No checklist!",
          due: nil,
          progress: 0,
          no_checklist: true
        }
      ]
    }.to_json

    completed = {
      _id: "whevs",
      name: "2014-q1-completed-tasks",
      time: "2014-04-08T19:43:13+00:00",
      value: [
        {
          title: "We've done this one",
          due: nil,
          progress: 1.0,
          no_checklist: false
        }
      ]
    }.to_json

    to_discuss = {
      _id: "whevs",
      name: "2014-q1-completed-tasks",
      time: "2014-04-08T19:43:13+00:00",
      value: [
        {
          title: "Let's have a chat about this one",
          due: nil,
          progress: 0.0,
          no_checklist: false
        }
      ]
    }.to_json

    FakeWeb.register_uri(:get, "https://metrics.theodi.org/metrics/2014-q1-outstanding-tasks", :body => outstanding)
    FakeWeb.register_uri(:get, "https://metrics.theodi.org/metrics/2014-q1-completed-tasks", :body => completed)
    FakeWeb.register_uri(:get, "https://metrics.theodi.org/metrics/2014-q1-tasks-to-discuss", :body => to_discuss)

    @progress = Progress.new("2014", "q1")
  end

  it "returns the correct progress for the current month" do
    Timecop.travel("2014-04-01")
    current = @progress.current_month
    current.count.should == 1
    current[0].should == {"title"=>"One card", "due"=>"2014-04-10T11:00:00Z", "progress"=>0.5, "no_checklist" => false}
    Timecop.return
  end

  it "returns the correct progress for the rest of the quarter" do
    Timecop.travel("2014-04-01")
    rest_of_quarter = @progress.rest_of_quarter
    rest_of_quarter.count.should == 3
    rest_of_quarter[0].should == {"title"=>"Two cards", "due"=> nil, "progress"=>0.0, "no_checklist" => false}
    rest_of_quarter[1].should == {"title"=>"Another card", "due"=> nil, "progress"=>0.5, "no_checklist" => false}
    rest_of_quarter[2].should == {"title"=>"No checklist!", "due"=> nil, "progress"=>0, "no_checklist" => true}
    Timecop.return
  end

  it "returns the correct to discuss cards", :vcr do
    to_discuss = @progress.to_discuss
    to_discuss.count.should == 1
    to_discuss[0].should == {"title" => "Let's have a chat about this one", "due" => nil, "progress" => 0.0, "no_checklist" => false}
  end

  it "returns the correct done cards", :vcr do
    done = @progress.done
    done.count.should == 1
    done[0].should == {"title" => "We've done this one", "due" => nil, "progress" => 1.0, "no_checklist" => false}
  end

end
