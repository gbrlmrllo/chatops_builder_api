# frozen_string_literal: true

require "rails_helper"

RSpec.describe Schemas::Validator do
  let(:event_schema) { build(:event_schema) }
  let(:event) { build(:event, event_schema: event_schema) }
  let(:body) { event.body }
  let(:validator) { described_class.new(body, event_schema.schema) }

  describe "#valid?" do
    context "when is valid" do
      it "returns true" do
        expect(validator.valid?).to be(true)
      end
    end

    context "when is not valid" do
      let(:body) { event.body.except!("recipients") }

      it "returns false" do
        expect(validator.valid?).to be(false)
      end
    end
  end
end
