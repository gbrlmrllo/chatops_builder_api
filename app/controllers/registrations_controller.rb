# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  include ErrorsSerializer
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: resource, status: :created
    else
      render json: response_validation_errors(resource),
             status: :unprocessable_entity
    end
  end
end
