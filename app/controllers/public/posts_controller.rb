module Public
  class PostsController < ApplicationController
    before_action :set_post, only: %i[show edit update soft_destroy]

    def index
      @posts = Post.where(is_deleted: 'false').ransack(params[:q]).result.includes(:post_tags).order(created_at: :desc).page(params[:page]).per(5)
    end

    def favorites
      @user = User.find(params[:id])
      favorite = Favorite.order(created_at: :desc).where(user_id: @user.id).pluck(:post_id)
      @posts = Post.find(favorite)
      @favorite_posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5) # 配列に対するページネーション
    end

    def show
      @post_tags = @post.post_tags # 投稿に紐付くタグの表示
      @comment = Comment.new
      @comments = @post.comments.where(is_deleted: 'false').order(created_at: :desc).page(params[:page]).per(3)
      @count = @post.comments.where(is_deleted: 'false').count
    end

    def new
      @user = current_user
      @post = Post.new
      @post_tags = @post.post_tags.pluck(:name).join(' ')
      if @user.email == 'guest@example.com'
        flash[:alret] = 'ゲストユーザは投稿できません。'
        redirect_to user_path(current_user)
      end
    end

    def edit
      @post_tags = @post.post_tags.pluck(:name).join(' ')
    end

    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      tag_list = params[:post][:name].split(/[[:blank:]]/)
      if @post.save
        @post.save_tag(tag_list)
        flash[:notice] = '投稿しました。'
        redirect_to posts_path
      else
        redirect_back(fallback_location: posts_path)
      end
    end

    def update
      tag_list = params[:post][:name].split(/[[:blank:]]/)
      if @post.update(post_params)
        @post.save_tag(tag_list)
        flash[:notice] = '投稿を更新しました。'
        redirect_to posts_path
      else
        flash[:alret] = '更新に失敗しました。'
        render :edit
      end
    end

    def soft_destroy
      if @post.user_id == current_user.id
        @post.update(is_deleted: true)
        flash[:alret] = '投稿が削除されました。'
        redirect_to user_posts_path(current_user.id)
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:user_id, :title, :post_text, :post_tags_name, :post_image)
    end
  end
end
