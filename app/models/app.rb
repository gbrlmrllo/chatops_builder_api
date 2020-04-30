# frozen_string_literal: true

class App < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_one :credential, dependent: :destroy

  before_create -> { build_credential }

  validates :name, presence: true
end
