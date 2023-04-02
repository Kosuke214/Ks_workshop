class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:status)
  end
end
