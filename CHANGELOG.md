# Changelog

All notable changes to this project will be documented in this file.

## Gem updates

'->' denotes an update from the version on the left to the version on the right.

If available, comments and/or further actions for a specific gem can be found under the gem update headline.

### ruby '2.1.2' -> '2.7.2'

### gem 'rails' '3.2.21' -> '~> 6.1.0'

### gem 'sqlite3'
If you want to freeze the version use

``gem 'sqlite3', '~> 1.6.0``

### gem 'puma' added '~> 5.0'

### gem 'sass-rails' '~> 3.2.5' -> '>= 6'

### gem 'webpacker' added '~> 5.0'

### gem 'turbolinks' added '~> 5'

### gem 'jbuilder' added '~> 2.7'

### gem 'redis' '3.0.1' -> '~> 5.0', '>= 5.0.5'

### gem 'bootsnap' added '>= 1.4.4', require: false

### gem 'haml' "4.0.3" -> '~> 6.1', '>= 6.1.1'
### gem 'show_for' '0.4.0' -> '~> 0.8.0'
### gem 'simple_form' '4.0.0' -> '~> 5.1'
### gem "blueprint-rails" removed

Cannot be readded, only for rails 3. Consequently, all css ``@extend``s that extend part of the blueprint-rails gem's CSS have been set to ``!optional ``. Another gem, such as [bootstrap](https://github.com/twbs/bootstrap-rubygem) can be used to replace ``blueprint-rails``.

### gem 'rails-i18n' "0.7.4" -> '~> 7.0', '>= 7.0.6'

### gem 'cancan' '1.6.7' -> '~> 1.6', '>= 1.6.10'

### gem 'bcrypt', '3.1.7' -> '~> 3.1', '>= 3.1.18'
### gem 'devise-encryptable' "0.1.1" -> '~> 0.2.0'
### gem 'devise_ldap_authenticatable' "~> 0.6.1" -> '~> 0.8.7'
### gem 'devise-i18n' "~> 0.5.4" -> '~> 1.10', '>= 1.10.2'
### gem 'net-ldap', "0.2.2" -> '~> 0.17.1'
### gem 'iconv', '1.0.4' -> '~> 1.0', '>= 1.0.8'

### gem "scope_by_fuzzy"

Please check if this is the gem you need. Looks like it has been renamed to [scope_by_soundex](https://github.com/monsterlabs/scope_by_fuzzy), but uses the same repo.

### gem 'simple-navigation' "3.8.0" -> '~> 4.4'

### gem 'paper_trail' '10.3', '>= 10.3.1' -> '~> 14.0'

### gem "diff" removed "~> 0.3.6"

Clashes with RSpec testing

### gem 'carrierwave', "0.6.2" -> '~> 2.2', '>= 2.2.3'
### gem 'rmagick' "2.13.2" -> '~> 5.1'
### gem 'kaminari' (0.14.1) -> '1.2.2'
### gem 'attribute_normalizer', '~> 1.1'

not updated to 1.2 as some app-breaking configuration is disabled in 1.2

### gem 'inherited_resources', '1.9' -> '~> 1.13', '>= 1.13.1'
### gem 'pg', '~> 1.4', "0.14.0" -> '>= 1.4.5'
### gem "meta_search", "~> 1.1.3"
Cannot be added, depends on actionpack ~> 3.1 activerecord ~> 3.1 activesupport ~> 3.1
Refer to the [search_methods](#search_methods) section below.

### gem 'squeel', '~> 1.2', '>= 1.2.3'
cannot be added, depends on polyamorous which has been deprecated after Rails 4

### gem 'lazy_high_charts' '1.5.8' -> '~> 1.6', '>= 1.6.1'

### gem "sass" removed
Not needed. If you feel this is not true, feel free to uncomment and run ``bundle`` to install it again.
### gem 'json' "1.7.5" -> '~> 2.6', '>= 2.6.3'
### gem 'coffee-script' "~> 2.2.0" -> '~> 2.4', '>= 2.4.1'

CoffeeScript still works with Rails 6, even though there have been [discussions](https://github.com/rails/rails/pull/37529) about removing it completely. The standard now is working with JavaScript. Please refer to the latest Rails guides, such as [this](https://guides.rubyonrails.org/working_with_javascript_in_rails.html) one.

### gem 'uglifier' "1.2.7" -> '~> 4.2'
### gem 'css_image_embedder' " 0.2.0" -> '~> 0.3.0'
### gem 'by_star' "2.0.0.beta1" -> '~> 4.0'
### gem 'tzinfo' '1.1' -> '~> 2.0', '>= 2.0.5'

### gem 'SystemTimer' removed
SystemTimer is only a patch for ruby 1.8's threading system. Not needed for ruby > 1.9.3

### gem 'redis' "3.0.1" -> '~> 5.0', '>= 5.0.5'
### gem 'redis-namespace' "1.2.1" -> '~> 1.10'
### gem 'resque' "1.22.0" -> '~> 1.19'
Not updated because of resque-status. Latest is 2.4. Please check the next gem. 
### gem "resque-status", "0.3.3", :require => "resque/status"
Needs resque ~>1.19, if not needed resque can be updated to 2.4

### gem 'resque_mailer', "2.1.0" -> '~> 2.4', '>= 2.4.3'

### gem 'prawn', "0.12.0" -> '~> 2.4'
### gem 'prawn_rails' "0.0.10" -> '~> 0.0.12'
### gem 'spreadsheet' "0.7.3" -> '~> 1.3'
### gem 'barby', "0.5.0" ->'~> 0.6.8'
### gem 'RedCloth'  "4.2.9" -> '~> 4.3', '>= 4.3.2'
### gem 'jquery-rails' '2.3.0' -> '~> 4.5', '>= 4.5.1'
### gem 'jquery-ui-rails'
Added since it is no longer included in jquery-rails

### gem 'rest-client' (1.6.7) -> '~> 2.1'
### gem 'secure_headers', removed
Config is required but is not used. check config/initializers/secure_headers.rb

### gem 'turbo-sprockets-rails3'
For Rails 3 only.

### gem 'protected_attributes'
Cannot be used with rails 6, depends on activemodel < 5.0, >= 4.0.1

### gem 'activeresource' (3.2.21) -> 6.0.0

### gem 'rails-observers'
Cannot be readded. Up to activemodel 4.0. Instead use [ActiveRecord callbacks](https://guides.rubyonrails.org/active_record_callbacks.html). I have added the following to the User model ``after_create :request_id_card``,  ``after_update :user_updates``,  ``before_destroy: destroy_connected_users``. The function names are just placeholders, feel free to change them as you like.

### gem "net-http" added
Fixes the followin warnings:

.../ruby/2.7.0/net/protocol.rb:66: warning: already initialized constant Net::ProtocRetryError

.../gems/net-protocol-0.2.1/lib/net/protocol.rb:68: warning: previous definition of ProtocRetryError was here

.../ruby/2.7.0/net/protocol.rb:206: warning: already initialized constant Net::BufferedIO::BUFSIZE

.../gems/net-protocol-0.2.1/lib/net/protocol.rb:214: warning: previous definition of BUFSIZE was here

.../ruby/2.7.0/net/protocol.rb:503: warning: already initialized constant Net::NetPrivate::Socket

.../gems/net-protocol-0.2.1/lib/net/protocol.rb:541: warning: previous definition of Socket was here


### gem 'rails_admin' (0.4.9) -> '~> 3.1', '>= 3.1.1'
### gem 'activeadmin' (0.6.6) -> '~> 2.13', '>= 2.13.1'

### gem 'highline' (1.6.21) -> '~> 2.1'

### gem "rails3-generators", "0.17.4", :require => "rails/generators"
Unsure in what capacity this is being used. Does not present any dependency issues with Rails 6 but might not be functional. Feel free to remove if this is the rails 3 counterpart of the new [generators](https://guides.rubyonrails.org/generators.html).

### gem 'ruby_parser' (2.3.1) -> '~> 3.19', '>= 3.19.2'
### gem 'unicorn' (4.3.1) -> '~> 6.1'
### gem 'pry-rails' (0.2.2) -> '~> 0.3.9'

### gem 'capybara' (2.4.4) -> '>= 3.26'
### gem 'rspec-rails' (2.11.0) -> '~> 6.0', '>= 6.0.1'
### gem 'shoulda-matchers', '~> 5.0'
Addded for ``should`` syntax in RSpec tests.
### gem 'machinist', '~> 2.0'
Not changed. Please refer to the [Machinist](#machinist) section below.
### gem 'forgery' (0.5.0) -> '~> 0.8.1'

### gem "rack-ssl-enforcer" removed
Instead use ``config.force_ssl = true`` in the environment setup, e.g. ``config/environments/production.rb``

### gem 'capistrano' (2.13.5) -> '~> 3.17', '>= 3.17.1'
### gem 'execjs' (1.4.1) -> '~> 2.8', '>= 2.8.1'
### gem 'therubyracer' (0.12.2) -> '~> 0.12.3'
### gem 'exception_notification' (2.6.1) -> '~> 4.5'
### gem 'dalli' (2.1.0) -> '~> 3.2', '>= 3.2.3'

## Testing
Tests can now be run by executing the ``rspec`` command. Rake task is no longer needed - feel free to remove.

### Machinist
The Machinist gem is quite outdated now. There are 7 tests that depend on the ``make!`` function that were not working because of a ``NoMethodError`` referring to ``make!`` and/or because of ``Model.blueprint`` ``NoMethodError``. Those tests have not been commented out as action is required and it is encouraged for them to fail. I strongly suggest using something like [FactoryBot](https://github.com/thoughtbot/factory_bot) to replace the Machinist gem and the blueprints under ``spec/blueprints``.

### Other
``spec/models/jobposition_spec.rb`` lines 19-22 tests commented out as they refer to a column that has been removed in a migration. Refer to migration ``RemoveStartMonthAndStartYearAndEndMonthAndEndYearFromJobpositions < ActiveRecord::Migration`` and rework tests as needed.

## General

## attr_accessor in models
``attr_accessor``s for all models attributes have ben removed as this is no longer needed. It also clashes with any attribute assignment, e.g. in database seeding.
If this is used as part of the ``protected_attributes`` gem, consider replacing it with [protected_attributes_continued](https://github.com/westonganger/protected_attributes_continued). I am unsure if this new gem will present the aforementioned issue.

### first_or_create in seeds

``first_or_create``'s usage is strongly discouraged as it may lead to race conditions. Should not be an issue on a single-thread application, but I strongly doubt that is the case. ``create_or_find_by`` is the standard now, but ``create`` already does the same thing, thus the method can be changed to just ``create`` or ``create!`` if you want to raise an error on unsuccessful creation.

### search_methods
**All ``search_methods`` have been commented out.**
``search_methods`` is method from the meta_search gem, ActiveAdmin after 1.x **does not** work with this gem anymore. Take a look at the [ransack](https://github.com/activerecord-hackery/ransack) gem and move your code to it. 

### Other changes applied
``attr_accessible`` has been renamed to ``attr_accessor``

``scope``s expect a Proc since Rails 4.

Some class names changed to fix Zeitwerk issues and of course adhere to the Rails convention.

``Salva::MetaDateExtension::ClassMethods#inherited`` changed to rescue an error about ``internal_metadata`` not existing.

``require File.dirname(__FILE__) +`` has been changed to ``require_relative`` in some places. If you find any other ``requires`` not using ``require_relative`` feel free to change them.

``spec_helper.rb`` has been renamed to ``test_helper.rb`` in latest Rails.

Please check ``stylesheet_link_tag``s in the ``.html.haml`` files, such as
``= stylesheet_link_tag 'jquery.ui/themes/start/jquery-ui-1.8.14.custom'`` in ``app/views/layouts/academic_secretary.html.haml``. I have not made any changes here as I am unsure where the imports come from, but this surely needs changed as the version will not match the latest gem's version.


## Miscellaneous

I strongly suggest the usage of a Linter, such as [Rubocop](https://rubocop.org) to make sure the application adheres to the community-driven [Ruby Style Guide](https://rubystyle.guide)

Please take a look at the deprecation warning on server startup:
``DEPRECATION WARNING: Initialization autoloaded the constant Salva::SiteConfig.``
Actions to fix the deprecation are suggested by the system.
