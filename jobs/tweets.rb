SCHEDULER.every '10m', :first_at => Time.now do
  send_event('twitter_mentions', comments: Tweets.update)
end