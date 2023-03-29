# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_posts_path
    when User
      user_path(current_user)
    end

    # root_url  "admin_path"
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :user
      root_path
    end
  end

  protected

  def set_search
    @search = Post.ransack(params[:q])
    # @post_tags = PostTag.all
    # @posts = @search.result.includes(:post_tags)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[last_name first_name nickname diy_history introduction profile_image])
  end
end
