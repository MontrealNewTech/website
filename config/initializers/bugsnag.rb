Bugsnag.configure do |config|
  config.api_key = ENV.fetch('BUGSNAG_API_KEY', 'dev/test')
end
