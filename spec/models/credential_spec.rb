# frozen_string_literal: true

require "rails_helper"

RSpec.describe Credential, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:app).required }
  end

  describe "callbacks" do
    describe "before create" do
      let(:credential) { build(:credential, app: create(:app)) }

      before { credential.save! }

      describe "#regenerate_token" do
        it "adds a token" do
          expect(credential.token).to be_present
        end
      end
    end
  end

  describe "#regenerate_token" do
    let(:credential) { build(:credential) }

    before { credential.regenerate_token }

    it "assigns a new token" do
      expect(credential.token_changed?).to eq(true)
    end

    it "doesnt' persist change" do
      expect(credential.saved_changes).to eq({})
    end
  end

  describe "#regenerate_token!" do
    let(:credential) { create(:credential, app: create(:app)) }

    before { credential.regenerate_token! }

    it "updates token" do
      expect(credential.saved_changes.keys).to eq(%w[token updated_at])
    end
  end
end
