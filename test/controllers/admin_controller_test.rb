require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get products" do
    get admin_products_url
    assert_response :success
  end

  test "should get users" do
    get admin_users_url
    assert_response :success
  end

end
