# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :event_schema, optional: false

  validates :body, :raw_data, presence: true
end
