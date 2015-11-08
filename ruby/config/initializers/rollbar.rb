Rollbar.configure do |config|
  config.enabled = ENV.key?('ROLLBAR_ACCESS_TOKEN')
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  config.use_sucker_punch
end
