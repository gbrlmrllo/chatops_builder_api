# frozen_string_literal: true

module V1
  class EventsController < ApplicationController
    before_action :set_app
    before_action :set_event_schema

    #  POST /api/v1/consume-events
    def consume
      @event = @event_schema.events.create!(
        body: event_params,
        raw_data: request.raw_post
      )
      render status: :created
    end

    private

    def event_params
      params.require(:event)
    end

    def set_app
      app_token = request.headers[:AppToken]
      @app = App.joins(:credential).find_by!(
        credentials: { token: app_token }
      )
    end

    def set_event_schema
      @event_schema = @app.event_schemas.find_by!(name: event_params[:name])
    end
  end
end
