# frozen_string_literal: true

# An EventSchema establish a default config for each event so that each
# external events will be processed based on the config.

# For more information, see https://github.com/gbrlmrllo/chatops_builder_api/issues/11
class EventSchema < ApplicationRecord
  belongs_to :creator, class_name: "User", optional: false
  belongs_to :app
  # has_many :events # TODO
  # has_many :integrations # TODO

  validates :name, presence: true, uniqueness: { scope: :creator_id }

  scope :schema_structure, -> { { data: [], recipient: [] } }
end
