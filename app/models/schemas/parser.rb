# frozen_string_literal: true

module Schemas
  class Parser
    def self.define_attributes(attrs)
      Dry::Schema.Params do
        attrs.each do |key, _|
          required(key.to_sym).filled(:string)
        end
      end
    end
  end
end
