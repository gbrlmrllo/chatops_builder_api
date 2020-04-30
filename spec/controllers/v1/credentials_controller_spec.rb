# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::CredentialsController, type: :controller do
  fixtures :all

  let(:user) { create(:user) }
  let(:app) { create(:app, owner: user) }

  before { sign_in user }

  describe "GET #generate_token" do
    before do
      get :regenerate_token, params: { app_id: app.to_param }
    end

    context "with valid params" do
      it "returns a success response" do
        expect(response).to be_successful
      end

      it "renders a JSON response with the new app" do
        expect(response).to have_http_status(:ok)
      end

      it "returns token in body response" do
        expect(JSON.parse(response.body)).to include("token")
      end

      it "regenerates credential token" do
        old_token = app.credential.token
        app.reload
        expect(app.credential.token).not_to eq(old_token)
      end
    end
  end
end
