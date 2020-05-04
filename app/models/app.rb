# frozen_string_literal: true

class App < ApplicationRecord
  belongs_to :owner, class_name: "User", optional: false
  has_one :credential, dependent: :destroy
  has_many :event_schemas, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :owner_id }

  before_create -> { build_credential }
end
