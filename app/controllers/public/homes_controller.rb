module Public
  class HomesController < ApplicationController
    def top
      @posts = Post.where(is_deleted: 'false').order(created_at: :desc).page(params[:page]).per(3)
      @post_count = Post.where(is_deleted: 'false').count
    end
  end
end
