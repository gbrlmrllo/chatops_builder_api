# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def show
      render json: V1::UserBlueprint.render(@user)
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
