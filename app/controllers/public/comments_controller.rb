# frozen_string_literal: true

module Public
  class CommentsController < ApplicationController
    def index
      @post = Post.find(params[:post_id])
      @comments = @post.comments.where(is_deleted: 'false').order(created_at: :desc).page(params[:page]).per(5)
    end

    def show
      @comment = Comment.find(params[:id])
    end

    def edit
      @comment = Comment.find(params[:id])
    end

    def create
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      # @comment.post_id = @post.id
      if @comment.save
        redirect_to post_path(@comment.post.id)
      end
    end

    def update
      @comment = Comment.find(params[:id])
      @comment.update(comment_params)
      redirect_to comment_path(@comment)
    end

    def soft_destroy
      @comment = Comment.find(params[:id])
      if @comment.user_id == current_user.id
        @comment.update(is_deleted: true)
        redirect_to post_path(@comment.post_id)
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :comment_text)
    end
  end
end
