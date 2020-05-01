# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::AppsController, type: :controller do
  context "without a authenticated user" do
    describe "GET #index" do
      it "401 - Unauthorized" do
        get :show, params: { id: "id" }
        expect(response.status).to eq(401)
      end
    end

    describe "GET #show" do
      it "401 - Unauthorized" do
        get :index
        expect(response.status).to eq(401)
      end
    end

    describe "POST #create " do
      it "401 - Unauthorized" do
        post :create
        expect(response.status).to eq(401)
      end
    end

    describe "PUT #update " do
      it "401 - Unauthorized" do
        put :update, params: { id: "id" }
        expect(response.status).to eq(401)
      end
    end

    describe "DELETE #destroy" do
      it "401 - Unauthorized" do
        delete :destroy, params: { id: "id" }
        expect(response.status).to eq(401)
      end
    end
  end

  context "with a authenticated user" do
    let(:valid_attributes) { { name: "Tesla" } }
    let(:invalid_attributes) { { name: nil, owner_id: 1, script: "<script>" } }
    let(:user) { create(:user) }
    let(:app) { create(:app, owner: user) }

    before { sign_in user }

    describe "GET #index" do
      before do
        app
        get :index, params: {}
      end

      it "200 - Ok" do
        expect(response.status).to eq(200)
      end

      it "responses correct attributes" do
        data = app.slice(:id, :name, :created_at).keys
        expected = response.parsed_body.first.keys

        expect(expected).to match_array(data)
      end
    end

    describe "GET #show" do
      before { get :show, params: { id: app.to_param } }

      it "200 - Ok" do
        expect(response.status).to eq(200)
      end

      it "responses correct attributes" do
        data = app.slice(:id, :name, :created_at).keys
        expected = response.parsed_body.keys

        expect(expected).to match_array(data)
      end
    end

    describe "POST #create" do
      let(:app) { App.take }

      before { post :create, params: { app: attributes } }

      context "with valid params" do
        let(:attributes) { valid_attributes }

        it "204 - Created" do
          expect(response.status).to eq(201)
        end

        it "responses correct attributes" do
          data = app.slice(:id, :name, :created_at).keys
          expect(response.parsed_body.keys).to match_array(data)
        end
      end

      context "with invalid params" do
        let(:attributes) { invalid_attributes }

        it "422 - Unprocessable Entity" do
          expect(response.status).to eq(422)
        end

        it "responses errors" do
          expect(response.parsed_body.keys).to eq(["name"])
        end
      end
    end

    describe "PUT #update" do
      before do
        put :update, params: { id: app.to_param, app: attributes }
      end

      context "with valid params" do
        let(:attributes) { { name: "Tesla" } }

        it "200 - Ok" do
          expect(response.status).to eq(200)
        end

        it "responses a app object" do
          attrs = app.slice(:id, :name, :created_at).keys
          expect(response.parsed_body.keys).to match_array(attrs)
        end
      end

      context "with invalid params" do
        let(:attributes) { { name: nil } }

        it "422 - Unprocessable Entity" do
          expect(response.status).to eq(422)
        end

        it "responses errors" do
          expect(response.parsed_body.keys).to eq(["name"])
        end
      end
    end

    describe "DELETE #destroy" do
      before { delete :destroy, params: { id: app.to_param } }

      it "204 - No Content" do
        expect(response.status).to eq(204)
      end

      it "destroys the app" do
        expect(App.count).to eq(0)
      end
    end
  end
end
