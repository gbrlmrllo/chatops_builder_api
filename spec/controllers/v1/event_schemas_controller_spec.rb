# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::EventSchemasController, type: :controller do
  context "without a authenticated user" do
    describe "GET #index" do
      it "401 - Unauthorized" do
        get :index, params: { app_id: "id" }
        expect(response.status).to eq(401)
      end
    end

    describe "GET #show" do
      it "401 - Unauthorized" do
        get :show, params: { app_id: "id", id: "id" }
        expect(response.status).to eq(401)
      end
    end

    describe "POST #create " do
      it "401 - Unauthorized" do
        post :create, params: { app_id: "id" }
        expect(response.status).to eq(401)
      end
    end

    describe "PUT #update " do
      it "401 - Unauthorized" do
        put :update, params: { app_id: "id", id: "id" }
        expect(response.status).to eq(401)
      end
    end

    describe "DELETE #destroy" do
      it "401 - Unauthorized" do
        delete :destroy, params: { app_id: "id", id: "id" }
        expect(response.status).to eq(401)
      end
    end
  end

  context "with an authenticated user" do
    let(:valid_attributes) do
      {
        name: "An EventSchema",
        description: "A long description...",
        schema: {
          data: %w[order_id order_name order_price product_image],
          recipient: %w[email user_name]
        }
      }
    end
    let(:invalid_attributes) { { name: nil, creator_id: 1, script: "<script>" } }
    let(:user) { create(:user) }
    let(:app) { create(:app, owner: user) }
    let(:event_schema) { create(:event_schema, creator: user, app: app) }

    before { sign_in user }

    describe "GET #index" do
      before do
        event_schema
        get :index, params: { app_id: app.to_param }
      end

      it "200 - Ok" do
        expect(response.status).to eq(200)
      end

      it "responses correct attributes" do
        data = event_schema.slice(
          :id, :name, :description, :schema, :created_at
        ).keys
        expected = response.parsed_body.first.try(:keys)

        expect(expected).to match_array(data)
      end
    end

    describe "GET #show" do
      before { get :show, params: { app_id: app.to_param, id: event_schema.to_param } }

      it "200 - Ok" do
        expect(response.status).to eq(200)
      end

      it "responses correct attributes" do
        data = event_schema.slice(
          :id, :name, :description, :schema, :created_at
        ).keys
        expected = response.parsed_body.try(:keys)

        expect(expected).to match_array(data)
      end
    end

    describe "POST #create" do
      let(:event_schema) { EventSchema.take }

      before { post :create, params: { app_id: app.to_param, event_schema: attributes } }

      context "with valid params" do
        let(:attributes) { valid_attributes }

        it "204 - Created" do
          expect(response.status).to eq(201)
        end

        it "responses correct attributes" do
          data = event_schema.slice(
            :id, :name, :description, :schema, :created_at
          ).keys
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
        put :update, params: {
          app_id: app.to_param,
          id: event_schema.to_param,
          event_schema: attributes
        }
      end

      context "with valid params" do
        let(:attributes) { { name: "Tesla" } }

        it "200 - Ok" do
          expect(response.status).to eq(200)
        end

        it "responses a event_schema object" do
          attrs = event_schema.slice(
            :id, :name, :description, :schema, :created_at
          ).keys
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
      before { delete :destroy, params: { app_id: app.to_param, id: event_schema.to_param } }

      it "204 - No Content" do
        expect(response.status).to eq(204)
      end

      it "destroys the event_schema" do
        expect(EventSchema.count).to eq(0)
      end
    end
  end
end
