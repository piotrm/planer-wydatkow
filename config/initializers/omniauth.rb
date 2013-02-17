Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, TwitterConfig.key, TwitterConfig.secret, {:display => "popup"}
end