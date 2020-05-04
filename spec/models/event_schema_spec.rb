# frozen_string_literal: true

require "rails_helper"

RSpec.describe EventSchema, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:creator).class_name("User").required }
    it { is_expected.to belong_to(:app).required }
    # it { is_expected.to have_many(:events).dependent(:destroy) } # TODO
    # it { is_expected.to have_many(:integrations).dependent(:destroy) } # TODO
  end

  describe "validations" do
    subject { build(:event_schema, creator: create(:user)) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:creator_id) }
  end

  describe ".schema_structure" do
    let(:schema_structure) { described_class.schema_structure }

    it "returns a Hash" do
      expect(schema_structure.class).to eq(Hash)
    end

    it "keys are :data and :recipient" do
      expect(schema_structure.try(:keys)).to eq(%i[data recipient])
    end

    it ":data value is an Array" do
      expect(schema_structure.dig(:data).class).to eq(Array)
    end

    it ":recipient value is an Array" do
      expect(schema_structure.dig(:recipient).class).to eq(Array)
    end
  end
end
