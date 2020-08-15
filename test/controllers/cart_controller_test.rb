require 'test_helper'

class CartControllerTest < ActionDispatch::IntegrationTest
  test "should get purchase" do
    get cart_purchase_url
    assert_response :success
  end

end
