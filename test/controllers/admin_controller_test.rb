require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get products' do
    @admin = users(:testadmin)
    sign_in @admin

    get admin_products_url
    assert_response :success
  end

  test 'should get users' do
    @admin = users(:testadmin)
    sign_in @admin

    get admin_users_url
    assert_response :success
  end

  test 'should get redirects by non authenticated user' do
    get admin_users_url
    assert_response :redirect
    assert_redirected_to new_user_session_path(redirect: admin_users_url)
  end

  test 'should get redirects by non admin user' do
    @user = users(:testuser)
    sign_in @user

    get admin_users_url
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

end
