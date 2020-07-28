# Edit this Gemfile to bundle your application"s dependencies.
source 'https://rubygems.org'

gem "rails", "~> 3.2.21"
gem "haml", "~> 4.0.3"
gem "show_for", "0.2.5"
gem "simple_form", "2.0.2"
gem "barista", "~> 1.3.0"
gem "blueprint-rails", "~> 0.1.2"
gem "rails-i18n", "~> 0.7.4"

# Authorization
gem "cancan", "1.6.7"

# Authentication
gem "devise", "~> 2.1.2"
gem "bcrypt", "~> 3.1.7"
gem "devise-encryptable", "~> 0.1.1"
gem "devise_ldap_authenticatable", "~> 0.6.1"
gem "devise-i18n", "~> 0.5.4"
gem "net-ldap", "0.2.2"
gem "iconv", "1.0.4"

# Searching and tagging
gem "tsearch", :require => "texticle"
gem "scope_by_fuzzy", :git => "git://github.com/monsterlabs/scope_by_fuzzy.git"

# Control version
gem "simple-navigation", "3.8.0"
gem "paper_trail", "~> 2.6.3"
gem "diff", "~> 0.3.6"

# Misc
gem "carrierwave", "0.6.2"
gem "rmagick", "2.13.2"
gem "kaminari", "~> 0.14.1"
gem "kaminari-i18n", "~> 0.1.3"
gem "attribute_normalizer", "~> 1.1.0"
gem "inherited_resources", "~> 1.3.1"
gem "pg", "0.14.0"
gem "meta_search", "~> 1.1.3"
gem "squeel", "~> 1.0.9"

#Graphs
gem "lazy_high_charts", "~> 1.5.5", :git => 'https://github.com/michelson/lazy_high_charts'

# Rails 3.1 - Asset Pipeline
gem "sass", "~> 3.2.1"
gem "json", "~> 2.3.1"
gem "coffee-script", "~> 2.2.0"
gem "uglifier", "~> 1.2.7"
gem "css_image_embedder", "~> 0.2.0"
gem "sass-rails", "~> 3.2.5"
gem "compass-rails31", "~> 0.12.0.alpha.0.91a748a"

gem "by_star", "~> 2.0.0.beta1"
gem "tzinfo", "0.3.33"

gem "SystemTimer", "1.2.3", :platforms => :ruby_18
gem "redis", "3.0.1"
gem "redis-namespace", "1.2.1"
gem "resque", "1.22.0"
gem "resque-status", "0.3.3", :require => "resque/status"
gem "resque_mailer", "2.1.0"

gem "prawn", "0.12.0"
gem "prawn_rails", "~> 0.0.10"
gem "spreadsheet", "0.7.3"
gem "barby", "0.5.0"
gem "RedCloth", "~> 4.2.9"
gem "rtf", "~> 0.3.3"
gem "rtf_rails", "0.0.1"
gem "jquery-rails", "~> 2.3.0"
gem "rest-client", "~> 1.6.7"
# gem "secure_headers", "~> 1.0.0"

# Rails Admin
gem "fastercsv", "~> 1.5.5", :platforms => :ruby_18
gem "rails_admin", "~> 0.4.9"
gem "activeadmin", "~> 0.6.2"

# Database seeds
gem "highline", "~> 1.6.19"

group :production do
  gem "rack-ssl-enforcer", "0.2.4", :require => "rack/ssl-enforcer"
  gem "rvm-capistrano", "~> 1.2.5"
  gem "capistrano", "~> 2.13.0"
  gem "execjs", "~> 1.4.0"
  gem "therubyracer", "~> 0.12.0"
  gem "exception_notification", "~> 2.6.1"
  gem "octopi", "~> 0.4.5"
  gem "dalli", "~> 2.1.0"
end

group :assets do
  gem "turbo-sprockets-rails3", "~> 0.3.2"
end

group :development do
  gem "rails3-generators", "0.17.4", :require => "rails/generators"
  gem "hpricot", "0.8.6"
  gem "ruby_parser", "2.3.1"
  gem "unicorn", "4.3.1"
  gem "pry-rails", "~> 0.2.1"
end

group :test do
  gem "rspec-rails", "~> 2.11.0"
  gem "machinist", ">= 2.0"
  gem "forgery", "~> 0.5.0"
  gem "remarkable", ">= 4.0.0.alpha4"
  gem "remarkable_activemodel", ">= 4.0.0.alpha4"
  gem "remarkable_activerecord", ">= 4.0.0.alpha4"
  gem "steak", "~> 2.0.0"
end

