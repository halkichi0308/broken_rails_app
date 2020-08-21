require 'test_helper'

class ReviewControllerTest < ActionDispatch::IntegrationTest
  test 'should get list' do
    product = products(:one)
    get list_product_reviews_url(product.id)
    assert_response :redirect
  end

end
