# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  # def set_search
  #  @search = Post.ransack(params[:q])
  #  @search_posts = @search.result.order(created_at: :desc).page(params[:page]).per(5)
  #  if params[:q].present? #paramsのnil対策
  #    @search_posts_result = Post.by_any_texts(params[:q][:title_or_post_text_cont]) #投稿本文、タイトル、タグを検索対象
  #  end
  # end

  protected

  def set_search
    @search = Post.ransack(params[:q])
    # @post_tags = PostTag.all
    # @posts = @search.result.includes(:post_tags)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[last_name first_name nickname diy_history introduction])
  end
end
