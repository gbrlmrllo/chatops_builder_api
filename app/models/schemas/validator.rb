# frozen_string_literal: true

# Schemas::Validator validates (yes, it does) body passed
module Schemas
  class Validator
    attr_reader :body, :schema

    def initialize(body, schema)
      @body = body
      @schema = schema.transform_keys(&:to_s)
    end

    def valid?
      schemer.valid?(body)
    end

    def error_message
      schemer.validate(body).to_a
             .collect { |err| err["details"] }
             .compact
    end

    private

    def schemer
      JSONSchemer.schema(schema)
    end
  end
end
