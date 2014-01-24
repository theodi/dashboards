SCHEDULER.every '10m', :first_at => $start_time do
  send_event('twitter_mentions', comments: Tweets.update)
end