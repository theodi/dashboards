require 'spec_helper'
require 'tweets'

describe Tweets do
  
  it "should return the three latest tweets to @ukodi", :vcr do
    @tweets = Tweets.update
    @tweets.first[:name].should == "ulrich atz"
    @tweets.first[:body].should == "We now have #R tutorials from our overlords at Google. @UKODITech http://t.co/QZ0bZTac7m"
    @tweets.first[:avatar].should == "https://si0.twimg.com/profile_images/3375341007/3f0ba19b59e1a224e52e1e03d2de2c9b_normal.jpeg"
  end
  
end