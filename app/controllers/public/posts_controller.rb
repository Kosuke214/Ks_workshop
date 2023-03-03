# frozen_string_literal: true

module Public
  class PostsController < ApplicationController
    before_action :configure_active_user, only: [:show]
    def index
      # post_tags = PostTag.all
      @posts = Post.where(is_deleted: 'false').ransack(params[:q]).result.includes(:post_tags).order(created_at: :desc).page(params[:page]).per(5)
      # @posts = Post.ransack(title_or_post_text_cont: params[:q]).result(distinct: true)
      # @post_tags = PostTag.ransack(name_cont: params[:q]).result(distinct: true)
    end

    def show
      @post = Post.find(params[:id])
      @post_tags = @post.post_tags # 投稿に紐付くタグの表示
      @comment = Comment.new
      @comments = @post.comments.where(is_deleted: 'false').order(created_at: :desc).page(params[:page]).per(3)
      @count = @post.comments.where(is_deleted: 'false').count
    end

    def new
      @post = Post.new
    end

    def edit
      @post = Post.find(params[:id])
    end

    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      tag_list = params[:post][:name].split(/[[:blank:]]/)
      if @post.save
        @post.save_tag(tag_list)
        redirect_to posts_path
      else
        redirect_back(fallback_location: posts_path)
      end
      # @post.tag_list = params[:post][:tag_list]
      # @post.save
      # redirect_to posts_path
    end

    def update
      @post = Post.find(params[:id])
      tag_list = params[:post][:name].split(/[[:blank:]]/)
      if @post.update(post_params)
        @post.save_tag(tag_list)
        redirect_to posts_path
      else
        render :edit
      end

      # @post.tag_list = params[:post][:tag_list]
    end

    def soft_destroy
      @post = Post.find(params[:id])
      if @post.user_id == current_user.id
        @post.update(is_deleted: true)
        redirect_to user_posts_path(current_user.id)
      end
    end

    private

    def post_params
      params.require(:post).permit(:user_id, :title, :post_text, :post_tags_name) # , :tag_list
    end

    def configure_active_user
      @post = Post.find(params[:id])
      if @post.user.status == false
        @post.user.nickname = '退会済みユーザ'
      end
    end

    # def set_search
    #  @search = Post.ransack(params[:q])  #キーワード、タグ検索の引数
    # end
  end
end
