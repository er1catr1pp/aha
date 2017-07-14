require './lib/oauth2/aha_strategy'
require './lib/oauth2/aha'

client_id = ENV['AHA_API_CLIENT_ID']
client_secret = ENV['AHA_API_CLIENT_SECRET']
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :aha_strategy, client_id, client_secret
end