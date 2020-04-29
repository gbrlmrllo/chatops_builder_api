# frozen_string_literal: true

module V1
  class AppBlueprint < Blueprinter::Base
    fields :id, :name, :created_at
  end
end
