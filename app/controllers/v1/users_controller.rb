# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :authenticate_user!

    # GET api/v1/me
    def me
      render json: V1::UserBlueprint.render(current_user)
    end
  end
end
