source "https://rubygems.org"
ruby "2.2.3"

gem "httparty"
gem "multi_json"
gem "oj"
gem "pg"
gem "pliny", "~> 0.13"
gem "pry"
gem "puma", "~> 2.10"
gem "rack-ssl"
gem "rake"
gem "rollbar", require: "rollbar/middleware/sinatra"
gem "sequel", "~> 4.16"
gem "sequel-paranoid"
gem "sequel_pg", "~> 1.6", require: "sequel"
gem "sinatra", "~> 1.4", require: "sinatra/base"
gem "sinatra-contrib", require: ["sinatra/namespace", "sinatra/reloader"]
gem "sinatra-router"
gem "sucker_punch"

group :development, :test do
  gem "pry-byebug"
end

group :test do
  gem "simplecov", require: false
  gem "database_cleaner"
  gem "dotenv"
  gem "factory_girl"
  gem "faker"
  gem "rack-test"
  gem "rspec"
  gem "webmock"
end
