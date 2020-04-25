# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::UsersController, type: :controller do
  describe "GET #show" do
    let(:user) { create(:user) }

    before { sign_in user }

    context "with an existing user" do
      before { get :show, params: { id: user.id } }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "matches user object" do
        data = user.slice(:id, :email, :first_name, :last_name)
        expect(response.parsed_body).to match(hash_including(data))
      end
    end

    context "with a nonexistent user" do
      before { get :show, params: { id: "1" } }

      it "returns http not_found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
