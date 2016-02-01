require 'spec_helper'
require 'soundcloud-listens'

describe SoundcloudListens do
  it "should load the total amount of listens from the Soundcloud API", :vcr do
    soundcloud_data = SoundcloudListens.update
    expect(soundcloud_data[:current]).to eq(210)
  end 
end