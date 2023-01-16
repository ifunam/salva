# Be sure to restart your server when you modify this file.
if Rails.env.production?
  require 'action_dispatch/middleware/session/dalli_store'
   Rails.application.config.session_store :dalli_store, { :raise_errors => false },
     :memcache_server => ["127.0.0.1:11211"],
     :namespace => 'sessions', :key => '_salva_session',
     :expire_after => 30.minutes
else
  Rails.application.config.session_store :cookie_store, key: '_salva_session'
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Rails.application.config.session_store :active_record_store
