# frozen_string_literal: true

# Schemas::Validator validates (yes, it does) body passed
module Schemas
  class Validator
    attr_reader :body, :schema

    delegate :success?, to: :dry_schema
    delegate :errors, to: :dry_schema

    def initialize(body, schema)
      @body = body
      @schema = schema.transform_keys(&:to_sym)
    end

    def error_messages
      errors(full: true).messages.collect(&:text).join(", ")
    end

    private

    def dry_schema
      dry_schema_structure(schema).call(body)
    end

    # Build validation structure according to schema
    def dry_schema_structure(schema)
      Dry::Schema.Params do
        required(:name).filled(:string)
        optional(:token).filled(:string)
        required(:data).hash(Parser.define_attributes(schema[:data]))
        required(:recipients).array(Parser.define_attributes(schema[:recipients].first))
      end
    end
  end
end
