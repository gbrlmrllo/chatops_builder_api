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
      let(:event_schema) { build(:event_schema) }
      let(:event) { build(:event, event_schema: event_schema) }
      let(:body) { event.body }

      context "when valid" do
        before { event.save! }

        it "returns true" do
          expect(event.valid_schema_event?).to be(true)
        end

        it "assigns nil to failure_reason" do
          expect(event.failure_reason).to be_nil
        end
      end

      context "when no valid" do
        before do
          event.body = body.except!("recipients")
          event.save!
        end

        it "returns false" do
          expect(event.valid_schema_event?).to be(false)
        end

        it "assigns string to failure_reason" do
          expect(event.failure_reason).to eq("invalid-body")
        end
      end
    end
  end
end
