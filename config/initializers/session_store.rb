# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_backchannel_session',
  :secret      => 'c3d8be203e1021b7aa84647a3d7c7b4219d3cb00188c8321f68d56510065beec28bd084e0b568a92979739dad7042bc7b1265057908ae19afe3a9fd4f73dbb7b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
