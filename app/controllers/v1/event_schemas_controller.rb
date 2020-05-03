# frozen_string_literal: true

module V1
  class EventSchemasController < V1::AppsController
    before_action :authenticate_user!
    before_action :set_app
    before_action :set_event_schema, only: %i[show update destroy]

    # GET api/v1/apps/1/event_schemas
    def index
      render json: V1::EventSchemaBlueprint.render(@app.event_schemas)
    end

    # GET api/v1/apps/1/event_schemas/1
    def show
      render json: V1::EventSchemaBlueprint.render(@event_schema)
    end

    # POST api/v1/apps/1/event_schemas
    def create
      event_schema = @app.event_schemas.new(
        event_schema_params.merge!(creator: current_user)
      )

      if event_schema.save
        render json: V1::EventSchemaBlueprint.render(event_schema), status: :created
      else
        render json: event_schema.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/v1/apps/1/event_schemas/1
    def update
      if @event_schema.update(event_schema_params)
        render json: V1::EventSchemaBlueprint.render(@event_schema)
      else
        render json: @event_schema.errors, status: :unprocessable_entity
      end
    end

    # DELETE api/v1/apps/1/event_schemas/1
    def destroy
      @event_schema.destroy

      head :no_content
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = current_user.apps.find(params[:app_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event_schema
      @event_schema = @app.event_schemas.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_schema_params
      params.require(:event_schema).permit(
        :name, :description, schema: EventSchema.schema_structure
      )
    end
  end
end
