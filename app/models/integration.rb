# frozen_string_literal: true

class Integration < ApplicationRecord
  belongs_to :event_schema, optional: false

  validates :name, presence: true, uniqueness: { scope: :event_schema_id }
end
