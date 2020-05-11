# frozen_string_literal: true

FactoryBot.define do
  factory :event_schema do
    name { FFaker::Name.name }
    description { FFaker::Lorem.phrase }
    schema { EventSchema.schema_structure }
    association :creator, factory: :user
    association :app
  end
end
