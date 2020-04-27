# frozen_string_literal: true

require "rails_helper"

RSpec.describe AppsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/apps").to route_to("apps#index")
    end

    it "routes to #show" do
      expect(get: "/apps/1").to route_to("apps#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/apps").to route_to("apps#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/apps/1").to route_to("apps#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/apps/1").to route_to("apps#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/apps/1").to route_to("apps#destroy", id: "1")
    end
  end
end
