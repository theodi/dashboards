require 'spec_helper'
require 'tweets'

describe Tweets do
  
  it "should return the three latest tweets to @ukodi", :vcr do
    @tweets = Tweets.update
    expect(@tweets.first[:name]).to eq("ulrich atz")
    expect(@tweets.first[:body]).to eq("We now have #R tutorials from our overlords at Google. @UKODITech http://t.co/QZ0bZTac7m")
    expect(@tweets.first[:avatar]).to eq("https://si0.twimg.com/profile_images/3375341007/3f0ba19b59e1a224e52e1e03d2de2c9b_normal.jpeg")
  end
  
end