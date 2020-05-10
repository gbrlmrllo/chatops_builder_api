# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::EventsController, type: :controller do
  context "with an invalid token" do
    describe "POST #consume" do
      it "404 - Not Found" do
        request.headers["AppToken"] = "iNv4lidT0k3n"
        post :consume, params: { }
        expect(response.status).to eq(404)
      end
    end
  end

  context "with a valid token" do
    context "with an invalid event schema name" do
      let(:params) { { name: "Invalid" } }
      let(:credential) { create(:credential) }

      describe "POST #consume" do
        it "404 - Not Found" do
          request.headers["AppToken"] = credential.token
          post :consume, params: params
          expect(response.status).to eq(404)
        end
      end
    end

    context "with blank fields" do
      let(:credential) { create(:credential) }

      describe "POST #consume" do
        it "404 - Not Found" do
          request.headers["AppToken"] = credential.token
          post :consume, params: { }
          expect(response.status).to eq(404)
        end
      end
    end

    context "with a valid event schema name" do
      let(:event_schema) { create(:event_schema) }
      let(:params) { { name: event_schema.name } }

      describe "POST #consume" do
        before do
          post :consume, params: params
        end

        it "201 - Created" do
          expect(response.status).to eq(201)
        end
      end
    end
  end
end
