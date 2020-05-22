# frozen_string_literal: true

require "rails_helper"

RSpec.describe Event, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:event_schema).required }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:raw_data) }
  end

  describe "callbacks" do
    describe "#valid_schema_event?" do
      let(:event_schema) { create(:event_schema) }
      let(:event) { create(:event, event_schema: event_schema) }
      let(:invalid_raw_data) { JSON.parse(event.raw_data) }

      context "when is valid" do
        it "returns true" do
          expect(event.valid_schema_event?).to be(true)
        end

        it "assigns nil to failure_reason" do
          expect(event.failure_reason).to be_nil
        end
      end

      context "when is not valid" do
        before do
          event.raw_data = invalid_raw_data.except!("recipients").to_json
          event.valid_schema_event?
        end

        it "returns false" do
          expect(event.valid_schema_event?).to be(false)
        end

        it "assigns string to failure_reason" do
          expect(event.failure_reason).to eql("Invalid raw body")
        end
      end
    end
  end
end
