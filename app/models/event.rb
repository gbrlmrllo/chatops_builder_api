# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :event_schema, optional: false

  validates :body, :raw_data, presence: true

  after_commit :valid_schema_event?

  delegate :schema, to: :event_schema

  def valid_schema_event?
    return true if validator.valid?

    update_column(:failure_reason, validator.error_messages)
  end

  private

  def validator
    Schemas::Validator.new(parsed_raw_data, schema)
  end

  def parsed_raw_data
    JSON.parse(raw_data)
  end
end
