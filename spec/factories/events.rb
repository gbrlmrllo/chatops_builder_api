# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    body { {} }
    raw_data { "{}" }
    failure_reason { nil }
    association :event_schema
  end
end