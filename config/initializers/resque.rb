require 'resque'
require 'resque/server'
require 'resque/job_with_status'
Rails.application.configure do
   config.after_initialize do
     conf_path =  File.join(Rails.root.to_s, 'config', 'resque.yml')
     if File.exist? conf_path
       resque_config = YAML.load_file(conf_path)
       Resque.redis = resque_config[Rails.env.to_s]
      end
   end
end
