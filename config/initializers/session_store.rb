# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_salva_session',
  :secret => '102469a9d5e7a9db8558f825c2784a4225513b75c61f0eb7f88cf3c3c6d4d9e2fd1f17045e388bed735a7ef8a5da051591a67e98ba9217cfa311785389e9c761'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
