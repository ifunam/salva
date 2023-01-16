# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

require 'rake'
require 'rake/testtask'
require 'rdoc/task'

if File.exist? File.join(Rails.root.to_s, 'config', 'resque.yml')
  require 'resque/tasks'
end

Rails.application.load_tasks

ENV['SKIP_RAILS_ADMIN_INITIALIZER'] = 'true'
