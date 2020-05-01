# frozen_string_literal: true

module V1
  class CredentialsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_app
    before_action :set_credential

    # GET api/v1/regenerate-token
    def regenerate_token
      @credential.regenerate_token!
      render json: V1::CredentialBlueprint.render(@credential)
    end

    private

    def set_app
      @app = current_user.apps.find(params[:app_id])
    end

    def set_credential
      @credential = @app.credential
    end
  end
end
