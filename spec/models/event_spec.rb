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
    describe "before save" do
      describe "#valid_schema_event?" do
        let(:event_schema) { create(:event_schema) }
        let(:event) { create(:event, event_schema: event_schema) }
        let(:raw_data) { event.raw_data }

        it "when raw body is valid" do
          expect(event.valid_schema_event?).to be(true)
        end

        it "when raw body is invalid" do
          raw_data.delete("recipients")
          puts raw_data
          expect(event.valid_schema_event?).to be(false)
        end
      end
    end
  end
end
