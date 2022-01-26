# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find_by(username: params[:username])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
