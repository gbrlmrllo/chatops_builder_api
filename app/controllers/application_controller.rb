# frozen_string_literal: true

class ApplicationController < ActionController::API
  BAD_REQUEST = lambda do
    head :bad_request
  end

  NOT_FOUND = lambda do
    head :not_found
  end

  FORBIDDEN = lambda do
    head :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound, &NOT_FOUND
  rescue_from ActionController::BadRequest, &BAD_REQUEST
  rescue_from ActionController::MethodNotAllowed, &FORBIDDEN
end
