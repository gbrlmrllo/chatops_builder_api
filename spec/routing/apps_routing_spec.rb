# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::AppsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/apps").to route_to("v1/apps#index")
    end

    it "routes to #show" do
      expect(get: "/v1/apps/1").to route_to("v1/apps#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/v1/apps").to route_to("v1/apps#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/apps/1").to route_to("v1/apps#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/apps/1").to route_to("v1/apps#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/apps/1").to route_to("v1/apps#destroy", id: "1")
    end
  end
end
