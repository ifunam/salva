# Edit this Gemfile to bundle your application"s dependencies.
source :rubygems

gem "rails", "3.1.1"
gem "haml", "3.1.3"
gem "show_for", "0.2.4"
gem "simple_form", "1.3.1"
gem "compass", "~> 0.11.5"
gem "barista", "~> 1.2.1"

# Authorization
gem "cancan", "1.6.7"

# Authentication
gem "devise", "1.1.5"
gem "devise_ldap_authenticatable"
gem "net-ldap", "0.1.1"

# Searching and tagging
gem "tsearch", :require => "texticle"
gem "scope_by_fuzzy"

# Control version
gem "vestal_versions", "1.0.2"
gem "simple-navigation", "3.2.0"

# Misc
gem "carrierwave", "0.5.3"
gem "rmagick", "2.13.1"
gem "will_paginate", "3.0.pre2"
gem "attribute_normalizer", "~> 1.0.0"
gem "inherited_resources", "~> 1.3.0"
gem "pg", "0.11.0"
gem "meta_search", "~> 1.1.1"
gem "squeel", "~> 0.9.3"

# Rails 3.1 - Asset Pipeline
gem "sass", "~> 3.1.10"
gem "json", "~> 1.6.1"
gem "coffee-script", "~> 2.2.0"
gem "uglifier", "~> 1.0.4"

gem "move_associations", "0.0.4"
gem "by_star", "1.0.1"
gem "tzinfo", "0.3.29"

#gem "SystemTimer", "1.2.3", :platforms => :ruby_18
gem "redis", "2.2.0"
gem "redis-namespace", "1.0.2"
gem "resque", "1.19.0"
gem "resque-status", "0.2.4", :require => "resque/status"
gem "resque_mailer", "2.0.2"

gem "prawn", "0.12.0"
gem "spreadsheet", "0.6.5.9"
gem "barby", "0.5.0"
gem "rest-client", "~> 1.6.7"

group :production do
  gem "rack-ssl-enforcer", "0.2.4", :require => "rack/ssl-enforcer"
  gem "inploy", "1.9.4"
end

group :development do
  gem "rails3-generators", "0.17.4", :require => "rails/generators"
  gem "hpricot", "0.8.4"
  gem "ruby_parser", "2.0.6"
  gem "unicorn", "3.6.0"
  gem "jquery-rails", "1.0.16"
  gem "inploy", "1.9.4"
end

group :test do
  gem "rspec-rails", ">= 2.0.5"
  gem "machinist", ">= 2.0.0.beta2"
  gem "forgery", "0.3.7"
  gem "remarkable", ">= 4.0.0.alpha4"
  gem "remarkable_activemodel", ">= 4.0.0.alpha4"
  gem "remarkable_activerecord", ">= 4.0.0.alpha4"
  gem "remarkable_rails"
  gem "steak", ">= 1.0.0.beta.1"
  gem "capybara", ">= 1.0.0.beta1"
end
