# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "brucewayne@batmam.com" }
    password { "n#.X5X^%" }
    password_confirmation { "n#.X5X^%" }
  end
end
