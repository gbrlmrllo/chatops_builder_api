# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "assocation" do
    subject(:app) { described_class.new }

    it do
      expect(app)
        .to have_many(:apps)
        .with_foreign_key(:owner_id)
        .inverse_of(:owner)
        .dependent(:destroy)
    end
  end
end
