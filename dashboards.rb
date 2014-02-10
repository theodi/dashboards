require 'dashing'
require 'dotenv'

Dotenv.load

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'
  set :default_dashboard, 'company'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

before '/company' do
  redirect to '/company/2013'
end