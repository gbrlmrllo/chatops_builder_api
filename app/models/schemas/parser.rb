module Schemas
  class Parser
    attr_reader :schema

    def initialize(schema)
      @schema = schema.transform_keys(&:to_sym)
    end

    def build_template
      <<~END
        #{name}
        #{data}
        #{recipients}
      END
    end

    def name
      "required(:name).filled(:string)"
    end

    def data
      <<~END
        required(:data).hash do
          #{attributes(schema[:data]).join("\n  ")}
        end
      END
    end

    def recipients
      <<~END
        required(:recipients).array(:hash) do
          #{attributes(schema[:recipients].first).join("\n  ")}
        end
      END
    end

    def attributes(obj)
      obj.map do |key, _|
        "required(:#{key}).filled(:string)"
      end
    end
  end
end
