# frozen_string_literal: true

require 'test_helper'

module Admin
  class PostsControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get admin_posts_index_url
      assert_response :success
    end

    test 'should get show' do
      get admin_posts_show_url
      assert_response :success
    end

    test 'should get edit' do
      get admin_posts_edit_url
      assert_response :success
    end

    test 'should get update' do
      get admin_posts_update_url
      assert_response :success
    end
  end
end
