# frozen_string_literal: true

# Schemas::Validator validates (yes, it does) body passed
module Schemas
  class Validator
    attr_reader :body, :schema

    delegate :success?, to: :dry_schema
    delegate :errors, to: :dry_schema

    def initialize(body, schema)
      @body = body
      @schema = schema
    end

    def error_messages
      errors(full: true).messages.collect(&:text).join(", ")
    end

    private

    def dry_schema
      dry_schema_structure(schema_parsed).call(body)
    end

    def schema_parsed
      Parser.new(schema).build_template
    end

    # Build validation structure according to schema
    def dry_schema_structure(schema_parsed)
      Dry::Schema.Params do
        eval(schema_parsed)
      end
    end
  end
end
