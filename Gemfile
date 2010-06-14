# Edit this Gemfile to bundle your application's dependencies.
source :gemcutter
 
gem "rails", :git => 'git://github.com/rails/rails.git', :branch => 'master'

# Views, css and javascript
gem "compass", "0.10.2"
gem "compass-jquery-plugin"
gem "show_for", :git => "http://github.com/plataformatec/show_for.git", :branch => 'master'

# Authentication
gem "devise", :git => 'git://github.com/plataformatec/devise.git', :branch => 'master'

# Authorization
#gem "declarative_authorization"

# Searching and tagging
gem "libxml-ruby"
gem "acts-as-taggable-on"
gem "tsearch", :require => 'texticle'
gem "pg_scope_by_soundex"

# Security
gem "ssl_requirement"

# Control version
gem "vestal_versions"

# Acts As something
gem "awesome_nested_set"

# Misc
gem "carrierwave", "0.4.4", :git => "git://github.com/jnicklas/carrierwave.git", :branch => 'master'
gem "rmagick"
gem "hpricot", "0.8.2"
gem "ruby_parser", "2.0.4"
gem "will_paginate", "3.0.pre", :git => "http://github.com/mislav/will_paginate.git", :branch => 'rails3'
gem "attribute_normalizer", :git => "http://github.com/mdeering/attribute_normalizer.git"

# gem "spreadsheet"
# gem "prawn"
gem "inherited_resources", "1.1.2"

# Application Auditing
# gem "rackamole"

group :production do
  gem "pg"
end

group :development do
  # DB performance tools
  gem "pg"
  gem "rails_indexes", "0.0.0", :git => "git://github.com/eladmeidar/rails_indexes.git", :branch => "master" # Gem to identify potential db indexes
  gem "slim_scrooge", "1.0.5" # Gem to heavily optimize your database interactions 
end

group :test do
  gem "sqlite3-ruby"
  gem "rspec-rails", "2.0.0.beta.7"  
  gem "factory_girl", "1.2.3", :git => 'git://github.com/thoughtbot/factory_girl.git', :branch => 'rails3'
  gem "forgery"
end
