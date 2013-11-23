TWILIO_ACCOUNT_ID   = ENV["NBA_TWILIO_ACCOUNT_ID"]
TWILIO_AUTH_TOKEN   = ENV["NBA_TWILIO_AUTH_TOKEN"]
TWILIO_PHONE_NUMBER = ENV["NBA_TWILIO_PHONE_NUMBER"]

PERSONAL_PHONE_NUMBER = ENV["PERSONAL_PHONE_NUMBER"]

Twitter.configure do |config|
  config.consumer_key        = ENV["NBA_TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["NBA_TWITTER_CONSUMER_SECRET"]
  config.oauth_token        = ENV["NBA_TWITTER_OAUTH_TOKEN"]
  config.oauth_token_secret = ENV["NBA_TWITTER_OAUTH_TOKEN_SECRET"]
end

# Instagram.configure do |config|
#   config.client_id    =
#   config.access_token =
# end
