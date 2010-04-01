# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_LocalizeTeaPot_session',
  :secret      => 'fdd350a037f84be1f49270a232264d6ae5dfa381b065081620df04a3db60b00c8ba03403e0fab50b408b40cb9ffe35ddba0ccab1aaddad0690bb15a222b6ddf7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
