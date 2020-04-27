# frozen_string_literal: true

module V1
  class CredentialsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_app
    before_action :set_credential

    def regenerate_token
      if @cred && @cred.update(token: secure_token)
        render json: V1::CredentialBlueprint.render(@cred)
      else
        render json: @cred.errors, status: :unprocessable_entity
      end
    end

    private
      # Set app given by params
      def set_app
        @app = current_user.apps.find(params[:app_id])
      end

      def set_credential
        @cred = @app&.credential
      end

      def secure_token
        SecureRandom.base64(30)
      end
  end
end
