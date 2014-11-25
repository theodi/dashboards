require 'spec_helper'
require 'github_stats'

describe GithubDashboard do

  describe "issues" do

    before :all do
      VCR.use_cassette("GithubDashboard/issues") do
        @result = GithubDashboard.issues
      end
    end

    it "should return the correct number of issues", :vcr do
      @result[:open_issues].should == 280
    end

    it "should return the correct number of pull requests", :vcr do
      @result[:pull_requests].should == 16
    end

  end

  describe "externalpulls" do

    before :all do
      VCR.use_cassette("GithubDashboard/externalpulls") do
        @result = GithubDashboard.externalpulls
      end
    end

    # EXTERNAL PRS ARE DISABLED CURRENTLY. SEE #106

    it "should return the correct number of total external pull requests", :vcr do
      @result[:total_pulls].should == 0 #43
    end

    it "should return the correct number of merged external pull requests", :vcr do
      @result[:merged_pulls].should == 0 #24
    end

  end

  describe "milestone" do

    before :all do
      VCR.use_cassette("GithubDashboard/milestone") do
        Timecop.freeze(2014,11,15)
        @result = GithubDashboard.milestone
        Timecop.return
      end
    end

    it "should return correct information about the current milestone", :vcr do
      @result[:title].should == "Sprint #37"
      @result[:value].should == 10
    end

  end

end
