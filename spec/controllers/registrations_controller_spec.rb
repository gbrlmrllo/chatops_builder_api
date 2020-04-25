# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /signup", type: :request do
  let(:url) { "/signup" }
  let(:params) do
    {
      user: {
        email: "user@example.com",
        password: "password"
      }
    }
  end

  context "when user is unauthenticated" do
    before { post url, params: params }

    it "returns 201" do
      expect(response.status).to eq 201
    end

    it "returns a new user" do
      expect(response.body).to eq(User.take.to_json)
    end
  end

  context "when user already exists" do
    before do
      create(:user, email: params.dig(:user, :email))
      post url, params: params
    end

    it "returns 422" do
      expect(response.status).to eq 422
    end

    it "returns validation errors" do
      expect(match_json_error("email")).to eq(["has already been taken"])
    end
  end
end
