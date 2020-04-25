# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    # DatabaseCleaner[:redis].strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    # Rollback transaction
    # DatabaseCleaner[:redis].db = Redis.current.redis
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
