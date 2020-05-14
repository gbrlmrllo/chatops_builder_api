# frozen_string_literal: true

# Schemas::Validator validates (yes, it does) body passed
module Schemas
  class Validator
    attr_reader :body, :schema

    def initialize(body, schema)
      @body = body
      @schema = schema
    end

    def valid?
      validates.success?
    end

    def errors
      validates.errors(full: true)
    end

    def error_messages
      errors.collect(&:text).join(", ")
    end

    private

    def validates
      structure(schema_parsed).call(body)
    end

    def schema_parsed
      Parser.new(schema).build_template
    end

    # Build validation structure according to schema
    def structure(schema_parsed)
      Dry::Schema.Params do
        eval(schema_parsed)
      end
    end
  end
end
