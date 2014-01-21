$:.unshift File.join(File.dirname(__FILE__), "..", "..", "lib")

path = File.dirname(__FILE__)

require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails'

require 'dotenv'

require 'vcr'
require 'webmock/cucumber'
require 'cucumber/rspec/doubles'
require 'capybara'
require 'capybara/cucumber'
require path + '/../../dashboards'

VCR.configure do |c|
  # Automatically filter all secure details that are stored in the environment
  ignore_env = %w{SHLVL RUNLEVEL GUARD_NOTIFY DRB COLUMNS USER LOGNAME LINES}
  (ENV.keys-ignore_env).select { |x| x =~ /\A[A-Z_]*\Z/ }.each do |key|
    c.filter_sensitive_data("<#{key}>") { ENV[key] }
  end
  c.default_cassette_options = { :record => :once }
  c.cassette_library_dir     = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end

Capybara.app = Sinatra::Application

class DashingWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers

  def app
    Sinatra::Application
  end
end

World do
  DashingWorld.new
end