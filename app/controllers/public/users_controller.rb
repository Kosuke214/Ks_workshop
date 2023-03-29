module Public
  class UsersController < ApplicationController
    before_action :configure_active_user, only: %i[show posts]

    def show
      # where(is_deleted: 'false') 削除フラグ以外のレコードを取得
      @posts = @user.posts.where(is_deleted: 'false').order(created_at: :desc).page(params[:page]).per(3)
      @favorites = @user.favorite.order(created_at: :desc).page(params[:page]).per(3)
      @post_count = @user.posts.where(is_deleted: 'false').count
      @favorite_count = @user.favorite.count
    end

    def edit
      @user = User.find(params[:id])
      unless @user == current_user # URLベタ打ちによる他ユーザ情報編集防止
        redirect_to root_path
      end
      if @user.email == 'guest@example.com'
        flash[:alret] = 'ゲストユーザは情報を編集できません。'
        redirect_to  user_path(current_user)
      end
    end

    def update
      @user = User.find(params[:id])
      if @user == current_user
        @user.update(user_params)
        flash[:notice] = '更新しました。'
        redirect_to user_path(current_user)
      else
        flash[:alret] = '更新に失敗しました。'
        render :edit
      end
    end

    def posts
      @posts = @user.posts.where(is_deleted: 'false').order(created_at: :desc).page(params[:page]).per(5)
    end

    def unsubscribe; end

    def withdraw
      @user = current_user
      # ゲストの退会防止
      if @user.email == 'guest@example.com'
        reset_session
        redirect_to :root
      else
        @user.update(status: false)
        reset_session
        redirect_to root_path
      end
    end

    private

    def user_params
      params.require(:user).permit(:last_name, :first_name, :nickname, :email, :password, :diy_history, :introduction, :profile_image)
    end

    def configure_active_user
      @user = User.find(params[:id])
      if @user.status == false
        @user.nickname = '退会済みユーザ'
      end
    end
  end
end
