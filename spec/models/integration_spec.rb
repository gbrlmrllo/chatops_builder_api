# frozen_string_literal: true

require "rails_helper"

RSpec.describe Integration, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:event_schema).required }
  end

  describe "validations" do
    subject { build(:integration) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:event_schema_id) }
  end
end
