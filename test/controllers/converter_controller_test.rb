require 'test_helper'

class ConverterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get converter_index_url
    assert_response :success
  end

  test "should get convert" do
    get converter_convert_url
    assert_response :success
  end

end
