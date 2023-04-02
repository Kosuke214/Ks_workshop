class Admin::CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update]

  def edit; end

  def update
    @comment.update(comment_params)
    redirect_to admin_post_path(@comment.post_id)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:is_hidden)
  end
end
