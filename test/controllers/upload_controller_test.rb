require 'test_helper'

class UploadControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get upload_new_url
    assert_response :success
  end

  test "should get delete" do
    get upload_delete_url
    assert_response :success
  end

end
