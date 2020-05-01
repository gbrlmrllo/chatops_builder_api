# frozen_string_literal: true

class App < ApplicationRecord
  belongs_to :owner, class_name: "User", required: true
  has_one :credential, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :owner_id }

  before_create -> { build_credential }
end
