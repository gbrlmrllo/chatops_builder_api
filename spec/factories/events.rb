# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    transient do
      schema do
        {
          "data" => {
            "order_price" => "$600"
          },
          "recipients" => [{ "email" => "admin1@email.com" }]
        }
      end
    end
    body { schema }
    raw_data { schema.to_json }
    failure_reason { nil }
    association :event_schema
  end
end
