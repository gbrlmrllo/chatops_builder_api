# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::CredentialsController, type: :controller do
  context "without an authenticated user" do
    describe "GET #generate_token" do
      it "401 - Unauthorized" do
        get :regenerate_token, params: { app_id: "id" }
        expect(response.status).to eq(401)
      end
    end
  end

  context "with an authenticated user" do
    let(:user) { create(:user) }
    let(:app) { create(:app, owner: user) }

    before { sign_in user }

    describe "GET #generate_token" do
      before do
        get :regenerate_token, params: { app_id: app.to_param }
      end

      it "200 - Ok" do
        expect(response.status).to eq(200)
      end

      it "responses correct attributes" do
        expect(response.parsed_body).to include("token")
      end
    end
  end
end
