# Edit this Gemfile to bundle your application's dependencies.
source :gemcutter
 
gem "rails", "3.0.0.rc2"

# Views, css and javascript
gem "compass", "0.10.4"
gem "show_for", ">= 0.2.3"
gem "simple_form"

# Authentication
gem "devise", '>=1.1.1'

# Authorization
gem "cancan"

# Searching and tagging
gem "libxml-ruby"
gem "acts-as-taggable-on"
gem "tsearch", :require => 'texticle'
gem "scope_by_fuzzy", :git => 'git://github.com/monsterlabs/scope_by_fuzzy.git'

# Security
gem "ssl_requirement"

# Control version
gem "vestal_versions"

# Acts As something
gem "awesome_nested_set"

# Misc
gem "carrierwave", "0.5.0.beta2"
gem "rmagick"
gem "will_paginate", "3.0.pre"
gem "attribute_normalizer", :git => "http://github.com/mdeering/attribute_normalizer.git"
gem "inherited_resources", "1.1.2"
gem "pg"
gem "meta_search"
gem "meta_where"
gem "by_star"
gem "tzinfo"
#gem "spreadsheet"
#gem "prawn"

group :production do
  gem "inploy"
  gem "rackamole"
end

group :development do
  gem "rails3-generators", :require => "rails/generators"
  gem "hpricot"
  gem "ruby_parser"
  gem "unicorn"
end

group :test do
  gem "rspec-rails", ">= 2.0.0.beta.19"
  gem 'machinist', ">= 2.0.0.beta2"
  gem "forgery"
  gem "remarkable", ">= 4.0.0.alpha4"
  gem "remarkable_activemodel"
  gem "remarkable_activerecord", ">= 4.0.0.alpha4"
  #gem "remarkable_rails"
end
