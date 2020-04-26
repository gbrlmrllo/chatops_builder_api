# frozen_string_literal: true

module V1
  class CredentialsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_app

    def regenerate_token
      render json: V1::AppBlueprint.render(@app)
    end

    private
      # Set app given by params
      def set_app
        @app = current_user.apps.find(params[:app_id])
      end
  end
end
