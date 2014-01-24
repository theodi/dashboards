require 'dashing'
require 'dotenv'

Dotenv.load

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'
  set :default_dashboard, 'company_2013'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end


