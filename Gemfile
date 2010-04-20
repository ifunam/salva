# Edit this Gemfile to bundle your application's dependencies.
source :gemcutter

gem "rails", "3.0.0.beta3"

# Views, css and javascript
# gem "minimal", :git => "git://github.com/svenfuchs/minimal.git", :branch => "master"
# gem "compass", "0.10.0.rc1", :git => "git://github.com/chriseppstein/compass.git", :branch => 'master'
gem "compass", "0.10.0.rc3", :git => "git://github.com/chriseppstein/compass.git", :branch => 'master'
gem "compass-jquery-plugin"
gem "jquery_helpers", "0.0.0", :git => 'git://github.com/alecz/jquery-helpers-for-rails3.git', :branch => 'master'

# Authentication
gem "authlogic", "2.1.3", :git => "git://github.com/binarylogic/authlogic.git", :branch => 'master'

# Authorization
# gem "declarative_authorization"

# Searching and tagging
gem "libxml-ruby"
gem "acts_as_sorl_reloaded", "0.0.0", :git => "git://github.com/dcrec1/acts_as_solr_reloaded.git", :branch => 'master'
gem "acts-as-taggable-on"

# Security
gem "ssl_requirement"

# Control version
gem "vestal_versions"

# Acts As something
gem "awesome_nested_set"

# Misc
gem "carrierwave", "0.4.4", :git => "git://github.com/ahaller/carrierwave.git", :branch => 'rails3'
gem "rmagick"
gem "hpricot", "0.8.2"
gem "ruby_parser", "2.0.4"
gem "will_paginate", "3.0.pre"
# gem "spreadsheet"
# gem "prawn"
gem "inherited_resources", "1.1.2"

# Application Auditing
# gem "rackamole"


# haml
# gem "haml", "2.2.23", :git => "git://github.com/nex3/haml.git", :branch => 'stable'
# gem "haml", "3.0.0.beta.3", :git => "git://github.com/nex3/haml.git", :branch => 'master'

group :production do
  gem "pg"
end

group :development do
  # DB performance tools
  gem "pg"
  gem "bullet" # Gem to identify N+1 queries and unused eager loading 
  gem "rails_indexes", "0.0.0", :git => "git://github.com/eladmeidar/rails_indexes.git", :branch => "master" # Gem to identify potential db indexes
  gem "slim_scrooge", "1.0.5" # Gem to heavily optimize your database interactions 
  # gem "rails_metrics"
end

group :test do
  gem "sqlite3-ruby"
  # gem "rspec", :git => "git://github.com/rspec/rspec.git", :branch => "master"
  gem "rspec-rails", ">= 2.0.0.beta.1"  
  # gem "factory_girl", :git => "git://github.com/thoughtbot/factory_girl.git", :branch => "rails3"
  # gem "capybara"
end
