# frozen_string_literal: true

# Schemas::Validator validates (yes, it does) body passed
module Schemas
  class Validator
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
      structure.call(@body)
    end

    def attribute_types(key)
      key.splitted(".").map(&:to_sym)
    end

    # Build validation structure according to schema
    def structure
      schema = @schema
      Dry::Schema.Params do
        schema.each_pair do |key, value|
          if value.blank? # if key has no nested attributes
            required(key.to_sym)
            next
          end

          splitted = key.split(".").map(&:to_sym)
          req = required(splitted.first)

          if splitted.third
            req.array(splitted.third) do
              value.each { |field| required(field.to_sym) }
            end
          else
            req.hash do
              value.each { |field| required(field.to_sym) }
            end
          end
        end
      end
    end
  end
end
