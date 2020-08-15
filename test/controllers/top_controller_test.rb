require 'test_helper'

class TopControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get top_index_url
    assert_response :success
    assert_select "title", "RailsBuildDocker"
  end

end
