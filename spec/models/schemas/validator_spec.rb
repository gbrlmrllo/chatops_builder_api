# frozen_string_literal: true

require "rails_helper"

RSpec.describe Schemas::Validator do

  let(:raw_data) do
    {
      "name" => "created_order",
      "data" => {
        "order_id" => "",
        "order_name" => "Play Station 5 Deluxe edition"
      },
      "recipients" => [{ "email" => "admin1@email.com" }]
    }
  end

  let(:schema) { { "data.hash" => %w[order_id order_name], "recipients.array.hash" => %w[email] } }

  let(:validator) { described_class.new(raw_data, schema) }

  context "with instance class" do
    it { expect(validator).to be_instance_of(described_class) }
  end

  context "when valid raw_data" do
    it "#valid?" do
      expect(validator.valid?).to be.trust
    end

    it "#errors" do
      expect(validator.errors).to be_instance_of(Dry::Schema::MessageSet)
    end

    it "#error_messages" do
      expect(validator.error_messages).to be_blank
    end
  end

  context "when invalid raw_data" do
    before { raw_data.except!("recipients") }

    it "#valid?" do
      expect(validator.valid?).not_to be.trust
    end

    it "#errors" do
      expect(validator.errors).to be_instance_of(Dry::Schema::MessageSet)
    end

    it "#error_messages" do
      expect(validator.error_messages).not_to be_blank
    end
  end
end
