# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :request do
  let(:user) { create(:user) }
  let(:url) { "/login" }

  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context "with user sign in" do
    context "when params are correct" do
      # before { post url, params: params }

      skip "returns 200" do
        expect(response.status).to eq 200
      end

      skip "returns JTW token in authorization header" do
        expect(response.headers["Authorization"]).to be_present
      end

      skip "returns valid JWT token" do
        expect(decode_token(response).first["sub"]).to be_present
      end
    end

    context "when login params are incorrect" do
      before { post url }

      it "returns unathorized status" do
        expect(response.status).to eq 401
      end
    end
  end

  context "with use sign out" do
    let(:url) { "/logout" }

    it "returns 204, no content" do
      delete url
      expect(response).to have_http_status(:no_content)
    end
  end
end

def decode_token(response)
  token = response.headers["Authorization"].split(" ").last
  JWT.decode(token, ENV["JWT_SECRET_KEY"], true)
end
