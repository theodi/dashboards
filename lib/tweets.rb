require 'twitter'

class Tweets
  
  def self.update
    tweets = connection.mentions_timeline(:count => 3)
    if tweets
      tweets.map! do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
    end
  
    tweets
  end
  
  def self.connection
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_UKODITECH_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_UKODITECH_CONSUMER_SECRET']
      config.oauth_token = ENV['TWITTER_UKODITECH_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_UKODITECH_OAUTH_TOKEN_SECRET']
    end
  end
  
end