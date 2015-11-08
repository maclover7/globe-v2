ENV['RACK_ENV'] = 'test'

require 'bundler'
require 'dotenv'
Bundler.require(:default, :test)
Dotenv.load('.env.test')

require_relative '../lib/initializer'
require_relative 'factories'

# pull in test initializers
Pliny::Utils.require_glob("#{Config.root}/spec/support/**/*.rb")

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before :suite do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.before :all do
    load('db/seeds.rb') if File.exist?('db/seeds.rb')
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  # the rack app to be tested with rack-test:
  def app
    @rack_app || fail('Missing @rack_app')
  end
end
