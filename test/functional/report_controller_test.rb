require 'test_helper'

class ReportControllerTest < ActionController::TestCase
  test "should get mo" do
    get :mo
    assert_response :success
  end

  test "should get mt" do
    get :mt
    assert_response :success
  end

  test "should get ivr" do
    get :ivr
    assert_response :success
  end

  test "should get alert" do
    get :alert
    assert_response :success
  end

end
