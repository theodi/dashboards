require 'rspec/core/rake_task'
require 'cucumber/rake/task'
require 'coveralls/rake/task'

RSpec::Core::RakeTask.new(:spec)

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "features --format pretty"
end

Coveralls::RakeTask.new

task :default => [:spec, :cucumber, 'coveralls:push']