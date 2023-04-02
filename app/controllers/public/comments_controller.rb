module Public
  class CommentsController < ApplicationController
    before_action :set_comment, only: %i[show edit update soft_destroy]

    def index
      @post = Post.find(params[:post_id])
      @comments = @post.comments.where(is_deleted: 'false').order(created_at: :desc).page(params[:page]).per(5)
    end

    def show; end

    def edit; end

    def create
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      # @comment.post_id = @post.id
      if @comment.save
        flash[:notice] = 'コメントしました。'
        redirect_to post_path(@comment.post.id)
      else
        render post_path(@comment.post.id)
      end
    end

    def update
      if @comment.update(comment_params)
        redirect_to comment_path(@comment)
      else
        render :edit
      end
    end

    def soft_destroy
      if @comment.user_id == current_user.id
        @comment.update(is_deleted: true)
        flash[:alret] = 'コメントを削除しました。'
        redirect_to post_path(@comment.post_id)
      end
    end

    private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :comment_text)
    end
  end
end
