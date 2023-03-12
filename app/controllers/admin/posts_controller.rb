class Admin::PostsController < ApplicationController
  # before_action :configure_active_user, only: [:show]
  # before_action :configure_hidden_post, only: [:show]
  # before_action :configure_hidden_comment, only: [:show]

  def index
    @posts = Post.ransack(params[:q]).result.includes(:post_tags).order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.post_tags # 投稿に紐付くタグの表示
    @comments = @post.comments.where(is_deleted: 'false').order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:is_hidden)
  end

  # 退会の判定メソッド
  # def configure_active_user
  #  @post = Post.find(params[:id])
  #  if @post.user.status == false
  #    @post.user.nickname = '退会済みユーザ'
  #  end
  # end

  # 投稿の非表示判定メソッド
  # def configure_hidden_post
  #  @post = Post.find(params[:id])
  #  if @post.is_hidden == true
  #    @post.title = '表示が規制されております。'
  #    @post.post_text = 'こちらの投稿は不適切な内容が含まれている可能性があるため、管理者により表示を規制されております。'
  #  end
  # end

  # コメントの非表示判定メソッド
  # def configure_hidden_comment
  #  @post = Post.find(params[:id])
  #  if @post.comments.is_hidden == true
  #    @post.comments.comment_text = 'こちらのコメントは不適切な内容が含まれている可能性があるため、管理者により表示を規制されております。'
  #  end
  # end
end
