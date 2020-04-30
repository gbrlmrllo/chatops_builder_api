# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::AppsController, type: :controller do
  fixtures :all
  let(:valid_content_type) { "application/json; charset=utf-8" }
  let(:valid_attributes) { { name: "Tesla" } }
  let(:invalid_attributes) { { name: nil, owner_id: 1, script: "<script>" } }
  let(:user) { create(:user) }
  let(:app) { create(:app, owner: user) }

  before { sign_in user }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    before do
      get :show, params: { id: app.to_param }
    end

    it "returns a success response" do
      expect(response).to be_successful
    end

    it "responses with corrent content type" do
      expect(response.content_type).to eq(valid_content_type)
    end
  end

  describe "POST #create" do
    before do
      post :create, params: { app: attributes }
    end

    context "with valid params" do
      let(:attributes) { valid_attributes }

      it "creates a new App" do
        expect(App.count).to eq(1)
      end

      it "renders a JSON response with the new app" do
        expect(response).to have_http_status(:ok)
      end

      it "responses with correct content type" do
        expect(response.content_type).to eq(valid_content_type)
      end
    end

    context "with invalid params" do
      let(:attributes) { invalid_attributes }

      it "renders a JSON response with errors for the new app" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "responses with correct content type" do
        expect(response.content_type).to eq(valid_content_type)
      end
    end
  end

  describe "PUT #update" do
    before do
      put :update, params: { id: app.to_param, app: attributes }
    end

    context "with valid params" do
      let(:attributes) { { name: "Tesla" } }

      it "updates the requested app" do
        app.reload
        expect(app.name).to eq("Tesla")
      end

      it "renders a JSON response with the app" do
        expect(response).to have_http_status(:ok)
      end

      it "responses with correct content type" do
        expect(response.content_type).to eq(valid_content_type)
      end
    end

    context "with invalid params" do
      let(:attributes) { { name: nil } }

      it "renders a JSON response with errors for the app" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "responses with correct content type" do
        expect(response.content_type).to eq(valid_content_type)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, params: { id: app.to_param }
    end

    it "destroys the requested app" do
      expect(App.count).to eq(0)
    end
  end
end
