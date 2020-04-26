class CreateCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :credentials do |t|
      t.text :token, null: false, default: ""
      t.references :app, null: false, foreign_key: true
    end
  end
end
