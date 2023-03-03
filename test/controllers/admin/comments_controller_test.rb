# frozen_string_literal: true

require 'test_helper'

module Admin
  class CommentsControllerTest < ActionDispatch::IntegrationTest
    test 'should get edit' do
      get admin_comments_edit_url
      assert_response :success
    end

    test 'should get update' do
      get admin_comments_update_url
      assert_response :success
    end
  end
end
