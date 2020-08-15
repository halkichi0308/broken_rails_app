require 'test_helper'

class ReviewControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get review_list_url
    assert_response :success
  end

end
