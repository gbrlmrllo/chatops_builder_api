# frozen_string_literal: true

module V1
  class EventSchemaBlueprint < Blueprinter::Base
    fields :id, :name, :description, :schema, :created_at
  end
end
