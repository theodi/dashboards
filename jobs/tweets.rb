schedule('10m') do
  send_event('twitter_mentions', comments: Tweets.update)
end
