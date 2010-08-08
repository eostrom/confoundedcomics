# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_comics_session',
  :secret      => '90455a103815e375f0888c005dfb43936b0f4b87930f2b11f820d6540458d0c25fd075064ca991d9e66c2b431d7f5b0c707e0494d6f7650e7fe0d0eb6d0bc417'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
