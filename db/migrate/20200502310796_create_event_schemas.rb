# frozen_string_literal: true

class CreateEventSchemas < ActiveRecord::Migration[6.0]
  def change
    create_table :event_schemas do |t|
      t.string :name
      t.text :description
      t.jsonb :schema
      t.references :creator, references: :users, null: false, foreign_key: { to_table: :users }
      t.references :app, null: false, foreign_key: true

      t.timestamps null: false
    end

    add_index(:event_schemas, %i[name creator_id], unique: true)
  end
end
