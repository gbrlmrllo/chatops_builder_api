# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Apps", type: :request do
  describe "GET /apps" do
    it "works! (now write some real specs)" do
      get apps_path
      expect(response).to have_http_status(:ok)
    end
  end
end
