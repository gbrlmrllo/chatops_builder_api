# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
      render json: User.find(params[:id])
    end
  end
end
