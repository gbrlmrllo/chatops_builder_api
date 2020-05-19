# frozen_string_literal: true

require "rails_helper"

RSpec.describe Schemas::Validator do

  let(:event) { build(:event) }
  let(:schema) { build(:event_schema).schema }
  let(:raw_data) { JSON.parse(event.raw_data) }


  let(:validator) { described_class.new(raw_data, schema) }

  context "with instance class" do
    it { expect(validator).to be_instance_of(described_class) }
  end

  context "when valid raw_data" do
    it "#valid?" do
      puts raw_data
      expect(validator.valid?).to be(true)
    end
  end

  context "when invalid raw_data" do
    before { raw_data.except!("recipients") }

    it "#valid?" do
      puts raw_data
      expect(validator.valid?).to be(false)
    end
  end
end
