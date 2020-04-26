class CreateApps < ActiveRecord::Migration[6.0]
  def change
    create_table :apps do |t|
      t.string :name
      t.references :owner, references: :users, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
