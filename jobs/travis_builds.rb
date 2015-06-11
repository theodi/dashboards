schedule('30s') do
  send_event('travis-builds', TravisBuilds.update)
end

schedule('30s') do
  send_event('travis-build-image', TravisBuilds.build_images)
end
