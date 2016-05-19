# Set up OmniAuth to use Client ID and Secret

# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"]  # Do not put IDs here directly, 
  #because when you commit people will be able to see it
end
