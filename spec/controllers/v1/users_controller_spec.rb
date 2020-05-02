# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::UsersController, type: :controller do
  describe "GET #me" do
    context "without a authenticated user" do
      it "401 - Unauthorized" do
        get :me
        expect(response.status).to eq(401)
      end
    end

    context "with a authenticated user" do
      let(:user) { create(:user) }

      before do
        sign_in user
        get :me
      end

      it "200 - Ok" do
        expect(response.status).to eq(200)
      end

      it "responses current user" do
        expect(response.parsed_body["id"]).to match(user.id)
      end

      it "responses correct attributes" do
        data = user.slice(:id, :email, :first_name, :last_name)
        expect(response.parsed_body).to match(hash_including(data))
      end
    end
  end
end
