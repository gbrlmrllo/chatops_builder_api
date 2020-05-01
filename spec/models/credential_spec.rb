# frozen_string_literal: true

require "rails_helper"

RSpec.describe Credential, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:app).required }
  end

  describe "callbacks" do
    describe "before create" do
      subject { build(:credential, app: create(:app)) }

      before { subject.save! }

      describe "#regenerate_token" do
        it "adds a token" do
          expect(subject.token).to be_present
        end
      end
    end
  end

  describe "#regenerate_token" do
    subject { build(:credential) }

    before { subject.regenerate_token }

    it "assigns a new token" do
      expect(subject.token_changed?).to eq(true)
    end

    it "doesnt' persist change" do
      expect(subject.saved_changes).to eq({})
    end
  end

  describe "#regenerate_token!" do
    subject { create(:credential, app: create(:app)) }

    before { subject.regenerate_token! }

    it "updates token" do
      expect(subject.saved_changes.keys).to eq(["token", "updated_at"])
    end
  end
end
