# frozen_string_literal: true

FactoryBot.define do
  factory :integration do
    name { "MyString" }
    association :event_schema
    extra_data { "" }
  end
end
