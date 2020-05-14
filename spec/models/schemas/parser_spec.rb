# frozen_string_literal: true

require "rails_helper"

RSpec.describe Schemas::Parser do
  let(:schema) do 
    { 
      "data" => {
        "order_id" => "",
        "order_name" => ""
      },
      "recipients" => [{ "email" => ""}]
    }
  end

  subject { described_class.new(schema) }

  describe "#build_template" do
    it do
      expect(subject.build_template).to eq(
        <<~END
          required(:name).filled(:string)
          required(:data).hash do
            required(:order_id).filled(:string)
            required(:order_name).filled(:string)
          end

          required(:recipients).array(:hash) do
            required(:email).filled(:string)
          end
          
        END
      )
    end
  end
end
