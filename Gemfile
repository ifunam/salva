# Edit this Gemfile to bundle your application's dependencies.
source :gemcutter

gem "rails", "3.0.0.beta"

gem "pg"
gem "haml-edge", "2.3.155", :require => 'haml'
gem "compass", "0.10.0.pre8", :git => "git://github.com/chriseppstein/compass.git", :branch => 'master'
gem "authlogic", "2.1.3", :git => "git://github.com/binarylogic/authlogic.git", :branch => 'master'
gem "ssl_requirement"
gem "paperclip", "2.3.1.1", :git => "git://github.com/thoughtbot/paperclip.git", :branch => 'rails3'
gem "dom_id", "0.0.0", :git => "git://github.com/nazgum/domid_gum.git", :branch => "master", :require => 'domid_gum'
gem "will_paginate"
gem "jquery_helpers", "0.0.0", :git => 'git://github.com/CodeOfficer/jquery-helpers-for-rails3.git', :branch => 'master'
gem "rackamole"

group :development do
  # DB performance tools
  gem "bullet" # Gem to identify N+1 queries and unused eager loading 
  gem "rails_indexes", "0.0.0", :git => "git://github.com/eladmeidar/rails_indexes.git", :branch => "master" # Gem to identify potential db indexes
  gem "slim_scrooge", "1.0.5" # Gem to heavily optimize your database interactions 
end

group :test do
  gem "rspec"
  gem "rspec-rails", "2.0.0.a10", :git => "git://github.com/rspec/rspec-rails.git", :branch => "master", :require => 'spec/rails'
  gem "factory_girl", :git => "git://github.com/thoughtbot/factory_girl.git", :branch => "rails3"
  gem "webrat"
end
