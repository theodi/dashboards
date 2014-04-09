require 'spec_helper'
require 'news_articles_dashboard'

describe NewsArticlesDashboard, :vcr do

  it "should list spokespeople" do
    NewsArticlesDashboard.spokespeople(2014).should == [
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

  it "should list sectors" do
    NewsArticlesDashboard.sectors(2014).should == [
      {label: "Technology", value: 332},
      {label: "Government", value: 328},
      {label: "Corporate", value: 136},
      {label: "Cultural", value: 53},
      {label: "Financial", value: 14},
      {label: "Retail", value: 5},
    ]
  end

  it "should list geographies" do
    NewsArticlesDashboard.geographies(2014).should == [
      {label: "UK", value: 522},
      {label: "Unspecified", value: 88},
      {label: "USA", value: 53},
      {label: "Canada", value: 31},
      {label: "Germany", value: 9},
      {label: "Italy", value: 9},
      {label: "Australia", value: 6},
      {label: "Singapore", value: 4},
      {label: "Belgium", value: 3},
      {label: "India", value: 3},
      {label: "France", value: 2},
      {label: "Africa", value: 2},
      {label: "Denmark", value: 2},
      {label: "Europe", value: 1},
      {label: "Brazil", value: 1},
      {label: "Austria", value: 1},
      {label: "Columbia", value: 1},
      {label: "Taiwan", value: 1},
      {label: "Nigeria", value: 1},
      {label: "Malaysia", value: 1},
      {label: "Malta", value: 1},
    ]
  end

  it "should list sentiment" do
    NewsArticlesDashboard.sentiment(2014).should == [
      {label: "positive", value: 412},
      {label: "neutral", value: 15},
      {label: "balanced", value: 14},
      {label: "negative", value: 1},
    ]
  end

  it "should get total volume for a term" do
    NewsArticlesDashboard.volume(2014, "ODI").should == 440
    NewsArticlesDashboard.volume(2014, "OpenData").should == 72
  end

  it "should get total value for a term" do
    NewsArticlesDashboard.value(2014, "ODI").should == 1495674
    NewsArticlesDashboard.value(2014, "OpenData").should == 417652
  end

  it "should get total reach for a term" do
    NewsArticlesDashboard.reach(2014, "ODI").should == 57628683
    NewsArticlesDashboard.reach(2014, "OpenData").should == 23181210
  end

end
