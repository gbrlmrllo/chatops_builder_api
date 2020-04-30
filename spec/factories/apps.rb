# frozen_string_literal: true

FactoryBot.define do
  factory :app do
    name { "SendGrid" }
    association :owner, factory: :user
  end
end
