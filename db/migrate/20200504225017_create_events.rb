# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.jsonb :body, default: {}, null: false
      t.text :raw_data, null: false
      t.text :failure_reason
      t.references :event_schema, null: false, index: true

      t.timestamps
    end
  end
end
