class Admin::PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update]

  def index
    @posts = Post.ransack(params[:q]).result.includes(:post_tags).order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @post_tags = @post.post_tags # 投稿に紐付くタグの表示
    @comments = @post.comments.where(is_deleted: 'false').order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit; end

  def update
    @post.update(post_params)
    redirect_to admin_post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:is_hidden)
  end
end
