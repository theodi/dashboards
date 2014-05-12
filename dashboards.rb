require 'dashing'
require 'dotenv'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'sinatra/partial'
require 'airbrake'
require 'rack-google-analytics'

Dotenv.load

if ENV['DASHBOARDS_ANALYTICS_KEY']
  use Rack::GoogleAnalytics, tracker: ENV['DASHBOARDS_ANALYTICS_KEY']
end

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

    def get_navigation(item)
      title = I18n.t item.gsub('/','.')
      if title.class == Hash
        I18n.t item.gsub('/','.') + ".main"
      else
        title
      end
    end

    def page_title
      I18n.t params["splat"][0].gsub('/','.')
    end

    def navigation_tree
      $nav ||= YAML.load_file('navigation.yml')
    end

  end

  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
  I18n.backend.load_translations

end

def current_quarter
  "q#{((Time.now.month - 1) / 3) + 1}"
end

before '/company' do
  redirect to '/company/2014'
end

before '/progress' do
  redirect to "/progress/#{Time.now.year}/#{current_quarter}"
end

before '/progress/*' do
  p = params["splat"].first.split("/")
  if p.count == 1
    if p.first == Time.now.year.to_s
      redirect to "/progress/#{p.first}/#{current_quarter}"
    else
      redirect to "/progress/#{p.first}/q1"
    end
  else
    @year = p[0]
    @quarter = p[1]
    if @quarter == current_quarter && @year == Time.now.year.to_s
      @dashboard = "current_progress"
    else
      @dashboard = "progress"
    end
  end
end

if ENV['DASHBOARDS_AIRBRAKE_KEY']
  configure :production do
    Airbrake.configure do |config|
      config.api_key = ENV['DASHBOARDS_AIRBRAKE_KEY']
    end
    use Airbrake::Sinatra

    def SCHEDULER.on_error(job, error)
      Airbrake.notify(error)
    end
  end
end
