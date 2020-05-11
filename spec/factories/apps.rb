# frozen_string_literal: true

FactoryBot.define do
  factory :app do
    name { FFaker::Name.name }
    association :owner, factory: :user
    trait :with_event_schema do
      after(:create) do |app|
        create(:event_schema, app: app)
      end
    end
  end
end
