require 'test_helper'

class MypageControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index by authenticated user' do
    @user = users :testuser
    sign_in @user

    get mypage_index_url
    assert_response :success
  end

  test 'should get history by authenticated user' do
    @user = users :testuser
    sign_in @user

    get history_mypage_index_url
    assert_response :success
  end

  test 'should get redirect on mypage_index_url by non authenticated user' do
    get mypage_index_url
    assert_response :redirect
    assert_redirected_to new_user_session_path(redirect: mypage_index_url)
  end

  test 'should get redirect on history_mypage_index_url by non authenticated user' do
    get history_mypage_index_url
    assert_response :redirect
    assert_redirected_to new_user_session_path(redirect: history_mypage_index_url)
  end

end
