# frozen_string_literal: true

require "rails_helper"

RSpec.describe Schemas::Validator do
  let(:event_schema) { build(:event_schema) }
  let(:event) { build(:event, event_schema: event_schema) }
  let(:invalid_raw_data) { JSON.parse(event.raw_data) }

  let(:validator) { described_class.new(JSON.parse(event.raw_data), event_schema.schema) }

  context "with instance class" do
    it { expect(validator).to be_instance_of(described_class) }
  end

  describe "#valid?" do
    conte "valid raw_data" do
      expect(validator.valid?).to be(true)
    end

    it "unexpected key added" do
      event.raw_data = invalid_raw_data.merge({ "hello" => "world" }).to_json
      expect(validator.valid?).to be(false)
    end

    it "required key missing" do
      event.raw_data = invalid_raw_data.except!("recipients").to_json
      expect(validator.valid?).to be(false)
    end
  end
end
