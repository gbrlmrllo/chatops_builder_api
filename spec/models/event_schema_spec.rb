# frozen_string_literal: true

require "rails_helper"

RSpec.describe EventSchema, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:creator).class_name("User").required }
    it { is_expected.to belong_to(:app).required }
    # it { is_expected.to have_many(:events).dependent(:destroy) } # TODO
    # it { is_expected.to have_many(:integrations).dependent(:destroy) } # TODO
  end

  describe "validations" do
    subject { build(:event_schema, creator: create(:user)) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:creator_id) }
  end
end
