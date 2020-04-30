# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { "n#.X5X^%" }
    password_confirmation { "n#.X5X^%" }
  end
end
