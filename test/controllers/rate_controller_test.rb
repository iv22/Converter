require 'test_helper'

class RateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rate_index_url
    assert_response :success
  end

  test "should get load" do
    get rate_load_url
    assert_response :success
  end

end
