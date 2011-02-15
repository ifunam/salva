# Edit this Gemfile to bundle your application's dependencies.
source :gemcutter

gem "rails", "3.0.4"
# Views, css and javascript
gem "compass", "0.10.6"
gem "show_for", "0.2.4"
gem "simple_form", "1.3.1"

# Authorization
gem "cancan", "1.5.1"
# gem "roles_generic"
# gem "roles_active_record"
# gem "cream"

# Authentication
gem "devise", "1.1.5"
gem "devise_ldap_authenticatable"
gem "net-ldap", "0.1.1"

# Searching and tagging
gem "tsearch", :require => 'texticle'
gem "scope_by_fuzzy"

# Security
gem "ssl_requirement"

# Control version
gem "vestal_versions"
gem "simple-navigation", "3.0.2"

# Misc
gem "carrierwave", "0.5.1"
gem "rmagick", "2.13.1"
gem "will_paginate", "3.0.pre2"
gem "attribute_normalizer", '1.0.0.pre1'
gem "inherited_resources", "1.1.2"
gem "pg", "0.10.1"
gem "meta_search", :git => 'git://github.com/ernie/meta_search.git'
gem "meta_where", '0.9.9.2'
gem "move_associations", "0.0.0"
gem "by_star", "1.0.0"
gem "tzinfo", "0.3.24"
gem "jquery-rails", "0.2.7"

gem "SystemTimer", :platforms => :ruby_18
gem 'redis', '2.0.10'
gem "redis-namespace", '0.10.0'
gem "resque", "1.13.0"
gem 'resque-status', "0.2.2", :require => 'resque/status'
gem "resque_mailer", "1.0.1"

gem "prawn", "0.11.1.pre"
gem "spreadsheet", "0.6.5.2"
gem "barby", "0.4.2"

group :production do
  gem "rack-ssl-enforcer", "0.2.0", :require => 'rack/ssl-enforcer'
  gem "inploy", "1.9.0"
end

group :development do
  gem "rails3-generators", :require => "rails/generators"
  gem "hpricot"
  gem "ruby_parser"
  gem "unicorn"
  gem "jquery-rails", "0.2.7"
  gem "inploy", "1.9.0"
end

group :test do
  gem "rspec-rails", ">= 2.0.0.beta.19"
  gem 'machinist', ">= 2.0.0.beta2"
  gem "forgery"
  gem "remarkable", ">= 4.0.0.alpha4"
  gem "remarkable_activemodel"
  gem "remarkable_activerecord", ">= 4.0.0.alpha4"
  gem "remarkable_rails"
  gem 'steak', '>= 1.0.0.beta.1'
  gem 'capybara'
end
