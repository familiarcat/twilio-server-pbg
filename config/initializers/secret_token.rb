# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
TwilioServer::Application.config.secret_key_base = 'cf321e5f29294c36f848af9a07d0a940afdae4292ad9b7446b2c1134dc08ba7d2f8a37d5b9260626a3c198bb345707dd027371f210b9f87deca5648f508783e8'
