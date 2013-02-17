class TwitterConfig
  @config = YAML.load(File.read(File.join(File.expand_path(Rails.root), 'config', 'twitter.yml')))[Rails.env].symbolize_keys rescue {}

  def self.key
    @config[:key] || ENV["TWITTER_KEY"]
  end

  def self.secret
    @config[:secret] || ENV["TWITTER_SECRET"]
  end

  def self.access_token
    @config[:access_token] || ENV["TWITTER_ACCESS"]
  end

  def self.access_token_secret
    @config[:access_token_secret] || ENV["TWITTER_ACCESS_SECRET"]
  end
end

Twitter.configure do |config|
  config.consumer_key = TwitterConfig.key
  config.consumer_secret = TwitterConfig.secret
  config.oauth_token = TwitterConfig.access_token
  config.oauth_token_secret = TwitterConfig.access_token_secret
end
