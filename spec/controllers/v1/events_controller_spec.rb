# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::EventsController, type: :controller do
  context "with an invalid token" do
    let(:token) { 'iNv4lidT0k3n' }
    let(:app) { App.joins(:credential).find_by!(credentials: { token: token }) }

    describe "GET #consume" do
      it "404 - Not Found" do
        get :consume
        expect(response.status).to eq(404)
      end
    end
  end

  context "with a valid token" do
    context "with an invalid event schema name" do
      let(:attributes) { { name: "iNv4lid", body: { name: "iNv4lid" } } }
      let(:user) { create(:user) }
      let(:credential) { create(:credential, app: app) }
      let(:token) { 'iNv4lidT0k3n' }
      let(:app) { App.joins(:credential).find_by!(credentials: { token: token }) }
      let(:event_schema) { app.event_schemas.find_by!(name: attributes[:name]) }
      
      describe "GET #consume" do
        it "404 - Not Found" do
          get :consume
          expect(response.status).to eq(404)
        end
      end
    end

    context "with blank fields" do
      let(:attributes) { { name: nil, body: {} } }
      let(:user) { create(:user) }
      let(:app) { create(:app, owner: user) }
      let(:credential) { create(:credential, app: app) }
      let(:event_schema) { app.event_schemas.find_by!(name: attributes[:name]) }

      describe "GET #consume" do
        it "404 - Not Found" do
          get :consume
          expect(response.status).to eq(404)
        end
      end
    end

    context "with a valid event schema name" do
      let(:user) { create(:user) }
      let(:new_app) { create(:app, owner: user) }
      let(:credential) { create(:credential, app: new_app) }
      let(:app) do
        App.joins(:credential).find_by!(
          credentials: { token: credential.token }
        )
      end
      let(:new_event_schema) do
        create(:event_schema, app: app, creator: user)
      end
      let(:event_schema) do
        app.event_schemas.find_by!(name: new_event_schema.name)
      end
      let(:attributes) do
        { name: event_schema.name, body: { name: event_schema.name } }
      end
      let(:event) do
        create(
          :event,
          body: attributes[:body],
          raw_data: attributes[:body].to_s,
          event_schema: event_schema
        )
      end

      describe "GET #consume" do
        before do
          event
          request.headers["AppToken"] = credential.token
          post :consume, params: attributes
        end

        it "201 - Created" do
          expect(response.status).to eq(201)
        end
      end
    end
  end
end
