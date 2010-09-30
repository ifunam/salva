require 'resque'
require 'resque/server'
require 'resque/job_with_status'
Salva::Application.configure do
   config.after_initialize do
     resque_config = YAML.load_file(File.dirname(__FILE__) + '/../../config/resque.yml')
     Resque.redis = resque_config[Rails.env.to_s]
     Resque::Status.expire_in = (24 * 60 * 60) # 24hrs in seconds
   end
end
