# frozen_string_literal: true

module V1
  class CredentialsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_app
    before_action :set_credential

    def regenerate_token
      @credential.regenerate_token

      if @credential.save
        render json: V1::CredentialBlueprint.render(@credential)
      else
        render json: @credential.errors, status: :unprocessable_entity
      end
    end

    private

    # Set app given by params
    def set_app
      @app = current_user.apps.find(params[:app_id])
    end

    def set_credential
      @credential = @app.credential
    end
  end
end
