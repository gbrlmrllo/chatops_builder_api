# frozen_string_literal: true

# Schemas::Validator validates (yes, it does) body passed
class Schemas::Validator
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
    errors.collect(&:text).join(', ')
  end

  private

  def validates
    structure.call(@body)
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

        required(key.to_sym).hash do
          value.each do |field|
            required(field.to_sym)
          end
        end
      end
    end
  end
end
