# frozen_string_literal: true

require "rails_helper"

RSpec.describe Schemas::Validator do
  # let(:event_schema) { build(:event_schema) }
  # let(:event) { build(:event, event_schema: event_schema) }
  let(:schema) do
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
      },
      "required": %w[data recipients]
    }
  end
  let(:body) do
    {
      "data" => {
        "order_price" => "$600"
      },
      "recipients" => [{ "email" => "admin1@email.com" }]
    }
  end
  let(:validator) { described_class.new(body, schema) }

  describe "#valid?" do
    context "when is valid" do
      it "returns true" do
        expect(validator.valid?).to be(true)
      end
    end

    context "when is not valid" do
      before { body.except!("recipients") }

      it "returns false" do
        expect(validator.valid?).to be(false)
      end
    end
  end
end
