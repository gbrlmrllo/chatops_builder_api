# frozen_string_literal: true

module V1
  class AppsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_app, only: %i[show update destroy]

    # GET api/v1/apps
    def index
      apps = current_user.apps

      render json: V1::AppBlueprint.render(apps)
    end

    # GET api/v1/apps/1
    def show
      render json: V1::AppBlueprint.render(@app)
    end

    # POST api/v1/apps
    def create
      app = current_user.apps.new(app_params)

      if app.save
        render json: V1::AppBlueprint.render(app), status: :created
      else
        render json: app.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/v1/apps/1
    def update
      if @app.update(app_params)
        render json: V1::AppBlueprint.render(@app)
      else
        render json: @app.errors, status: :unprocessable_entity
      end
    end

    # DELETE api/v1/apps/1
    def destroy
      @app.destroy

      head :no_content
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = current_user.apps.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def app_params
      params.require(:app).permit(:name)
    end
  end
end
