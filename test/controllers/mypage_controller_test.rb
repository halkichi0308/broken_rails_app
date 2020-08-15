require 'test_helper'

class MypageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mypage_index_url
    assert_response :success
  end

  test "should get cart" do
    get mypage_cart_url
    assert_response :success
  end

  test "should get history" do
    get mypage_history_url
    assert_response :success
  end

end
