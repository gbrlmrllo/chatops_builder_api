# frozen_string_literal: true

FactoryBot.define do
  factory :credential do
    association :app
  end
end
