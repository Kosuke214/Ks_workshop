# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:status)
  end
end
