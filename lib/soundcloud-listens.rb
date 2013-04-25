require 'soundcloud'

class SoundcloudListens 
  
  def self.update
    
    client = Soundcloud.new(
      :client_id => ENV['SOUNDCLOUD_CLIENT_ID'],
      :client_secret => ENV['SOUNDCLOUD_SECRET'],
      :username => ENV['SOUNDCLOUD_USERNAME'],
      :password => ENV['SOUNDCLOUD_PASSWORD']
      )
    
    count = 0
    
    client.get('/me/tracks').each do |track|
      count += track['playback_count']
    end
    
    { current: count }
  end
  
end