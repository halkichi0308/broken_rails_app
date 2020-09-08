require 'test_helper'

class CartControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    @user = users :testuser
    sign_in @user

    get cart_url
    assert_response :success
  end

  test 'should get cart' do
    @user = users :testuser
    sign_in @user

    product = products :one

    get "/cart/#{product.id}"
    assert_response :redirect
    assert_redirected_to cart_path

  end

  test 'should get confirm' do
    @user = users :testuser
    sign_in @user

    product = products :one
    get "/cart/#{product.id}"

    get cart_confirm_url
    assert_response :redirect
    assert_redirected_to mypage_index_path
  end
end
