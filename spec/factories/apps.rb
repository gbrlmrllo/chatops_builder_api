# frozen_string_literal: true

FactoryBot.define do
  factory :app do
    name { "SendGrid" }
    owner factory: :user
    association :credential
  end
end
