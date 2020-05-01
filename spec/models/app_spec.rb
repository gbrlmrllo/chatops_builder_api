# frozen_string_literal: true

require "rails_helper"

RSpec.describe App, type: :model do
  describe "associations" do
  	specify do
  		is_expected
  			.to belong_to(:owner)
  			.class_name("User")
  			.required
  	end

  	it { is_expected.to have_one(:credential).dependent(:destroy) }
  end

  describe "validations" do
  	subject { build(:app, owner: create(:user)) }

  	it { is_expected.to validate_presence_of(:name) }
  	it { is_expected.to validate_uniqueness_of(:name).scoped_to(:owner_id) }
  end
end
