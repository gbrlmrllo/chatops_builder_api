# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :event_schema, optional: false

  validates :body, :raw_data, presence: true

  before_save :valid_body?

  delegate :schema, to: :event_schema

  def valid_body?
    if validator.valid?
      self.failure_reason = nil
      return true
    end

    self.failure_reason = validator.error_message
    false
  end

  private

  def validator
    Schemas::Validator.new(body, schema)
  end
end
