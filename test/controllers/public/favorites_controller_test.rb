# frozen_string_literal: true

require 'test_helper'

module Public
  class FavoritesControllerTest < ActionDispatch::IntegrationTest
    test 'should get show' do
      get public_favorites_show_url
      assert_response :success
    end

    test 'should get create' do
      get public_favorites_create_url
      assert_response :success
    end

    test 'should get update' do
      get public_favorites_update_url
      assert_response :success
    end
  end
end
