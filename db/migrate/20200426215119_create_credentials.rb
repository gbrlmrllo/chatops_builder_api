# frozen_string_literal: true

class CreateCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :credentials do |t|
      t.text :token, null: false, default: ""
      t.references :app, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
