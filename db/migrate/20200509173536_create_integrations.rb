# frozen_string_literal: true

class CreateIntegrations < ActiveRecord::Migration[6.0]
  def change
    create_table :integrations do |t|
      t.string :name, null: false
      t.string :type
      t.references :event_schema, null: false, foreign_key: true
      t.jsonb :extra_data, default: {}

      t.timestamps
    end

    add_index(:integrations, %i[name event_schema_id], unique: true)
  end
end
