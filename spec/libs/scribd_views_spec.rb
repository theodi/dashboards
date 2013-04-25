require 'spec_helper'
require 'scribd_views'

describe ScribdViews do
  it "should load the total amount of views from the Scribd API", :vcr do
    scribd_data = ScribdViews.update
    scribd_data[:current].should == 21820
  end 
end