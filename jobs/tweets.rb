SCHEDULER.every '10m', :first_in => 0 do
  send_event('twitter_mentions', comments: Tweets.update)
end