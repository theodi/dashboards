SCHEDULER.every '10m', :first_in => Time.now + 10 do
  send_event('twitter_mentions', comments: Tweets.update)
end