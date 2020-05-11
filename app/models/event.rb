# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :event_schema, optional: false

  validates :body, :raw_data, presence: true

  after_commit :valid_schema_event?

  def valid_schema_event?
    result = event_schema.validator.call(parsed_raw_data)
    return if result.success?

    update_column(:failure_reason, result.errors(full: true).sum{|x| "|#{x.text}|"})
  end

  private

  def parsed_raw_data
    JSON.parse(raw_data)
  end
end
