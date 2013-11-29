require 'test_helper'

class SpControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get get" do
    get :get
    assert_response :success
  end

end
