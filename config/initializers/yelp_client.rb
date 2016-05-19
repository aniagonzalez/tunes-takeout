require 'yelp'

Yelp.client.configure do |config|
  config.consumer_key = ENV["YOUR_CONSUMER_KEY"]
  config.consumer_secret = ENV["YOUR_CONSUMER_SECRET"]
  config.token = ENV["YOUR_TOKEN"]
  config.token_secret = ENV["YOUR_TOKEN_SECRET"]
end

# To use the Business API after you have a client you just need to call #business with a business id#
# client.business('yelp-san-francisco')
