# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.6"

gem "blueprinter"
gem "bootsnap", ">= 1.4.2", require: false
gem "devise"
gem "devise-jwt"
gem "faraday"
gem "faraday_middleware"
gem "oj"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.3"
gem "rack-cors"
gem "rails", "~> 6.0.2", ">= 6.0.2.1"
gem "rails-healthcheck"
gem "rails_12factor", group: :production
gem "redis"
gem "redis-namespace"
gem "sidekiq"
gem "sidekiq-scheduler"
gem "webmock"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "ffaker"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.9"
  gem "rubocop",             require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails",       require: false
  gem "rubocop-rspec",       require: false
end

group :test do
  gem "capybara"
  gem "database_cleaner-active_record"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "simplecov-lcov", require: false
end

group :development do
  gem "bullet"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
end
