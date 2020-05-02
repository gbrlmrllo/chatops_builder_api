# frozen_string_literal: true

class AddNameAppIdIndexToApps < ActiveRecord::Migration[6.0]
  def change
    add_index(:apps, %i[name owner_id], unique: true)
  end
end
