require 'spec_helper'
require 'pingdom'

describe Pingdom do
  
  it "should return all the checks and their status", :vcr do
    @pingdom = Pingdom.perform
    @pingdom[:items].first[:label].should == "www.theodi.org"
    @pingdom[:items].first[:value].should == "up"
  end
  
end