# frozen_string_literal: true

FactoryBot.define do
  factory :app do
    name { FFaker::Name.name }
    association :owner, factory: :user
  end
end
