require 'test_helper'

class UploadControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get upload_index_url
    assert_response :success
  end

  test 'should get delete' do
    get delete_upload_index_url
    assert_response :success
  end

end
