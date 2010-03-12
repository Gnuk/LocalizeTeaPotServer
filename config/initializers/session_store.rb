# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_LocalizeTeaPot_session',
  :secret      => 'a186b34870a9ef5cdccccec457bc872e2115d690b6b17a7a6800541549b5c0daa927179a64f02b2c1709db0db7472f54f4b496dd9bf480e002b611b1fb726f27'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
