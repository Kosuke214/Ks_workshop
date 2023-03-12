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
      @user = current_user
    end

    def update; end

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

    def configure_active_user
      @user = User.find(params[:id])
      if @user.status == false
        @user.nickname = '退会済みユーザ'
      end
    end
  end
end
