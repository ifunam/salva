source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.0', '>= 5.0.5'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# OLD
gem 'haml', '~> 6.1', '>= 6.1.1'
gem 'show_for', '~> 0.8.0'
gem 'simple_form', '~> 5.1'
gem 'barista', '~> 1.3'
# gem "blueprint-rails", "~> 0.1.2" # cannot be readded, only for rails 3
gem 'rails-i18n', '~> 7.0', '>= 7.0.6'

# Authorization
gem 'cancan', '~> 1.6', '>= 1.6.10' # maybe remove

# Authentication
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'bcrypt', '~> 3.1', '>= 3.1.18'
gem 'devise-encryptable', '~> 0.2.0'
gem 'devise_ldap_authenticatable', '~> 0.8.7'
gem 'devise-i18n', '~> 1.10', '>= 1.10.2'
gem 'net-ldap', '~> 0.17.1' # maybe remove?
gem 'iconv', '~> 1.0', '>= 1.0.8'

# Searching and tagging
gem "tsearch", :require => "texticle"
gem "scope_by_fuzzy"

# Control version
gem 'simple-navigation', '~> 4.4'
gem 'paper_trail', '~> 14.0'
# gem "diff", "~> 0.3.6" # clashes with RSpec testing

# Misc
gem 'carrierwave', '~> 2.2', '>= 2.2.3'
gem 'rmagick', '~> 5.1'
gem 'kaminari'
gem 'kaminari-i18n', '~> 0.5.0'
gem 'attribute_normalizer', '~> 1.1' # some configuration disabled in 1.2
gem 'inherited_resources', '~> 1.13', '>= 1.13.1'
gem 'pg', '~> 1.4', '>= 1.4.5'
# gem "meta_search", "~> 1.1.3" # cannot be added, depends on actionpack ~> 3.1 activerecord ~> 3.1 activesupport ~> 3.1
# gem 'squeel', '~> 1.2', '>= 1.2.3' # cannot be added, depends on polyamorous which has been deprecated after Rails 4

#Graphs
gem 'lazy_high_charts', '~> 1.6', '>= 1.6.1'

# Rails 3.1 - Asset Pipeline
# gem "sass", "~> 3.2.1" # not needed
gem 'json', '~> 2.6', '>= 2.6.3'
gem 'coffee-script', '~> 2.4', '>= 2.4.1'
gem 'uglifier', '~> 4.2'
gem 'css_image_embedder', '~> 0.3.0' # most likely needs removed
gem "compass-rails31", "~> 0.12.0.alpha.0.91a748a" # most likely needs removed

gem 'by_star', '~> 4.0'
gem 'tzinfo', '~> 2.0', '>= 2.0.5'

# gem 'SystemTimer', '~> 1.2', '>= 1.2.3' # SystemTimer is only a patch for ruby 1.8's threading system. Not needed for ruby > 1.9.3
gem 'redis-namespace', '~> 1.10'
gem 'resque', '~> 1.19' # latest is 2.4
gem "resque-status", "0.3.3", :require => "resque/status" # needs resque ~>1.19, if not needed resque can be updated to 1.19
gem 'resque_mailer', '~> 2.4', '>= 2.4.3'

gem 'prawn', '~> 2.4'
gem 'prawn_rails', '~> 0.0.12'
gem 'spreadsheet', '~> 1.3'
gem 'barby', '~> 0.6.8'
gem 'RedCloth', '~> 4.3', '>= 4.3.2'
gem 'rtf', '~> 0.3.3'
gem 'rtf_rails', '~> 0.0.1'
gem 'jquery-rails', '~> 4.5', '>= 4.5.1'
gem 'jquery-ui-rails' # added since it is no longer included in jquery-rails
gem 'rest-client', '~> 2.1'
# gem 'secure_headers', '~> 6.5' # config is required but is not used. check config/initializers/secure_headers.rb

# Added by me

# moved from group :assets

# gem 'turbo-sprockets-rails4' # removed


# 3.2 to 4.0

# gem 'protected_attributes' # cannot be used with rails 6, depends on activemodel < 5.0, >= 4.0.1

gem 'activeresource'

# gem 'rails-observers' # cannot be readded up to activemodel 4.0

gem "net-http" # Fixes warnings
# /home/debian/.rvm/rubies/ruby-2.7.2/lib/ruby/2.7.0/net/protocol.rb:66: warning: already initialized constant Net::ProtocRetryError
# /home/debian/.rvm/gems/ruby-2.7.2/gems/net-protocol-0.2.1/lib/net/protocol.rb:68: warning: previous definition of ProtocRetryError was here
# /home/debian/.rvm/rubies/ruby-2.7.2/lib/ruby/2.7.0/net/protocol.rb:206: warning: already initialized constant Net::BufferedIO::BUFSIZE
# /home/debian/.rvm/gems/ruby-2.7.2/gems/net-protocol-0.2.1/lib/net/protocol.rb:214: warning: previous definition of BUFSIZE was here
# /home/debian/.rvm/rubies/ruby-2.7.2/lib/ruby/2.7.0/net/protocol.rb:503: warning: already initialized constant Net::NetPrivate::Socket
# /home/debian/.rvm/gems/ruby-2.7.2/gems/net-protocol-0.2.1/lib/net/protocol.rb:541: warning: previous definition of Socket was here



# Rails Admin
gem 'fastercsv', '~> 1.5', '>= 1.5.5'
gem 'rails_admin', '~> 3.1', '>= 3.1.1'
gem 'activeadmin', '~> 2.13', '>= 2.13.1' #inherited_resources ~> 1.7 jquery-rails ~> 4.2 kaminari ~> 1.0, >= 1.2.1

# Database seeds
gem 'highline', '~> 2.1'

#end old

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring

  #OLD
  gem 'spring'
  gem "rails3-generators", "0.17.4", :require => "rails/generators"
  gem 'hpricot', '~> 0.8.6'
  gem 'ruby_parser', '~> 3.19', '>= 3.19.2'
  gem 'unicorn', '~> 6.1'
  gem 'pry-rails', '~> 0.3.9'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  # OLD
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'machinist', '~> 2.0'
  gem 'forgery', '~> 0.8.1'
  gem "remarkable", ">= 4.0.0.alpha4"
  gem "remarkable_activemodel", ">= 4.0.0.alpha4"
  gem "remarkable_activerecord", ">= 4.0.0.alpha4"
  gem 'steak', '~> 2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  # gem "rack-ssl-enforcer", "0.2.4", :require => "rack/ssl-enforcer" # not needed
  gem 'capistrano-rvm', '~> 0.1.2' # capistrano ~> 3.0
  gem 'capistrano', '~> 3.17', '>= 3.17.1'
  gem 'execjs', '~> 2.8', '>= 2.8.1'
  gem 'therubyracer', '~> 0.12.3'
  gem 'exception_notification', '~> 4.5'
  gem 'octopi', '~> 0.4.5'
  gem 'dalli', '~> 3.2', '>= 3.2.3'
end


