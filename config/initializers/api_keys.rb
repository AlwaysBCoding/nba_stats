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
