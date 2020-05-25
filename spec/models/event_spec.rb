# frozen_string_literal: true

require "rails_helper"

RSpec.describe Event, type: :model do
  let(:event_schema) { build(:event_schema) }
  let(:event) { build(:event, event_schema: event_schema) }

  describe "associations" do
    it { is_expected.to belong_to(:event_schema).required }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:raw_data) }
  end

  describe "callbacks" do
    describe "before save" do
      it "triggers :valid_body?" do
        allow(event).to receive(:valid_body?)
        event.save
        expect(event).to have_received(:valid_body?).once
      end
    end
  end

  describe "#valid_body?" do
    let(:body) { event.body }

    context "when valid" do
      before { event.save! }

      it "returns true" do
        expect(event.valid_body?).to be(true)
      end

      it "assigns nil to failure_reason" do
        expect(event.failure_reason).to be_nil
      end
    end

    context "when no valid" do
      before do
        event.body = { "hello" => "world" }
        event.save!
      end

      it "returns false" do
        expect(event.valid_body?).to be(false)
      end

      it "assigns string to failure_reason" do
        expect(event.failure_reason).to eq("[{\"missing_keys\"=>[\"data\", \"recipients\"]}]")
      end
    end
  end
end
