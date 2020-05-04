# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.jsonb :body
      t.text :raw_data
      t.text :failure_reason
      t.references :event_schema, null: false, index: true

      t.timestamps
    end
  end
end
