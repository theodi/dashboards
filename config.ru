path = File.dirname(__FILE__)
require path + '/dashboards'

Dotenv.load
if ENV['DASHBOARDS_AUTH_TOKEN']
  set :auth_token, ENV['DASHBOARDS_AUTH_TOKEN']
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
