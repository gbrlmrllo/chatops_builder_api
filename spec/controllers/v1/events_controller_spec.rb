# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::EventsController, type: :controller do
  describe "POST #consume" do
    let(:app) { create(:app, :with_event_schema) }
    let(:token) { app.credential.token }
    let(:params) { nil }

    before do
      request.headers["AppToken"] = token
      post :consume, params: params
    end

    context "with an invalid token" do
      let(:token) { "iNv4lidT0k3n" }

      it "404 - Not Found" do
        expect(response.status).to eq(404)
      end
    end

    context "with a valid token" do
      context "with an invalid event schema name" do
        let(:params) { { name: "Invalid" } }

        it "404 - Not Found" do
          expect(response.status).to eq(404)
        end
      end

      context "with blank fields" do
        it "404 - Not Found" do
          expect(response.status).to eq(404)
        end
      end

      context "with a valid event schema name" do
        let(:params) { { name: app.event_schemas.take.name } }

        it "201 - Created" do
          expect(response.status).to eq(201)
        end

        it "creates a event" do
          expect(app.event_schemas.first.events).to be_present
        end
      end
    end
  end
end
