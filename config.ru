path = File.dirname(__FILE__)
require path + '/dashboards'

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application