# frozen_string_literal: true

require 'test_helper'

module Admin
  class HomesControllerTest < ActionDispatch::IntegrationTest
    test 'should get top' do
      get admin_homes_top_url
      assert_response :success
    end
  end
end
