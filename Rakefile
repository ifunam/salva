# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

require 'rake'
require 'rake/testtask'
require 'rdoc/task'

if File.exist? File.join(Rails.root.to_s, 'config', 'resque.yml')
  require 'resque/tasks'
end

Salva::Application.load_tasks
