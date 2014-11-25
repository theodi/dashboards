require 'twitter'

class Tweets
  
  def self.update
    tweets = connection.mentions_timeline(:count => 3)
    if tweets
      tweets.map! do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_uri_https.to_s }
      end
    end
  
    tweets
  rescue Twitter::Error::TooManyRequests
    puts "rate limited by twitter"
    []
  end
  
  def self.connection
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_UKODITECH_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_UKODITECH_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_UKODITECH_OAUTH_TOKEN']
      config.access_token_secret = ENV['TWITTER_UKODITECH_OAUTH_TOKEN_SECRET']
    end
  end
  
end