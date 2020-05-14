# frozen_string_literal: true

module Schemas
  class Parser
    attr_reader :schema

    def initialize(schema)
      @schema = schema.transform_keys(&:to_sym)
    end

    def build_template
      <<~RUBY_CODE
        #{name}
        #{data}
        #{recipients}
      RUBY_CODE
    end

    def name
      "required(:name).filled(:string)"
    end

    def data
      <<~RUBY_CODE
        required(:data).hash do
          #{attributes(schema[:data]).join("\n  ")}
        end
      RUBY_CODE
    end

    def recipients
      <<~RUBY_CODE
        required(:recipients).array(:hash) do
          #{attributes(schema[:recipients].first).join("\n  ")}
        end
      RUBY_CODE
    end

    def attributes(obj)
      obj.map do |key, _|
        "required(:#{key}).filled(:string)"
      end
    end
  end
end
