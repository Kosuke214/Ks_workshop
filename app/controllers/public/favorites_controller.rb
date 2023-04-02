module Public
  class FavoritesController < ApplicationController
    before_action :set_post, only: %i[create destroy]

    def create
      favorite = current_user.favorite.new(post_id: @post.id)
      if current_user.email == 'guest@example.com'
        flash[:alret] = 'ゲストユーザはいいねできません。'
      else
        favorite.save
      end
      redirect_to post_path(@post)
    end

    def destroy
      favorite = current_user.favorite.find_by(post_id: @post.id)
      favorite.destroy
      redirect_to post_path(@post)
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end
  end
end
