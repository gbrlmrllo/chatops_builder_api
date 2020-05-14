# frozen_string_literal: true

require "rails_helper"

RSpec.describe Schemas::Parser do
  let(:schema) do
    {
      "data" => {
        "order_id" => "",
        "order_name" => ""
      },
      "recipients" => [{ "email" => "" }]
    }
  end

  let(:parser) { described_class.new(schema) }

  describe "#build_template" do
    let(:expected) do
      <<~RUBY_CODE
        required(:name).filled(:string)
        required(:data).hash do
          required(:order_id).filled(:string)
          required(:order_name).filled(:string)
        end

        required(:recipients).array(:hash) do
          required(:email).filled(:string)
        end

      RUBY_CODE
    end

    it { expect(parser.build_template).to eq(expected) }
  end
end
