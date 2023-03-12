class Admin::CommentsController < ApplicationController
  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to admin_post_path(@comment.post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:is_hidden)
  end
end
