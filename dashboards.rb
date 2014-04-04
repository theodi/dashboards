require 'dashing'
require 'dotenv'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'sinatra/partial'

Dotenv.load

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'
  set :default_dashboard, 'company'

  set :partial_template_engine, :erb
  enable :partial_underscores

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end

    def page_title
      I18n.t params["splat"][0].gsub('/','_')
    end

    def navigation_tree
      $nav ||= YAML.load_file('navigation.yml')
    end

  end

  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
  I18n.backend.load_translations

end

before '/company' do
  redirect to '/company/2013'
end
