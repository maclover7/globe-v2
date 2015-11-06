ENV["RACK_ENV"] = "test"

require "bundler"
require "dotenv"
Bundler.require(:default, :test)
Dotenv.load('.env.test')

require_relative "../lib/initializer"

# pull in test initializers
Pliny::Utils.require_glob("#{Config.root}/spec/support/**/*.rb")

RSpec.configure do |config|
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

  config.expect_with :minitest
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # the rack app to be tested with rack-test:
  def app
    @rack_app || fail("Missing @rack_app")
  end
end
