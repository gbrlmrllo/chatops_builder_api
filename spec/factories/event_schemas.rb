# frozen_string_literal: true

FactoryBot.define do
  factory :event_schema do
    name { FFaker::Name.name }
    description { FFaker::Lorem.phrase }
    schema do
      {
        "type" => "object",
        "additionalProperties" => false,
        "properties" => {
          "data" => {
            "type" => "object",
            "additionalProperties" => false,
            "properties" => {
              "order_price" => { "type" => "string" }
            }
          },
          "recipients" => {
            "type" => "array",
            "items" => {
              "type" => "object",
              "additionalProperties" => false,
              "properties" => {
                "email" => { "type" => "string" }
              }
            }
          }
        }
      }
    end
    association :creator, factory: :user
    association :app
  end
end
