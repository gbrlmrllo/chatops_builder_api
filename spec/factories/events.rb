# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    body { { id: 1 } }
    raw_data do
      {
        "data" => {
          "order_price" => "$600"
        },
        "recipients" => [{ "email" => "admin1@email.com" }]
      }.to_json
    end
    failure_reason { nil }
    association :event_schema
  end
end
