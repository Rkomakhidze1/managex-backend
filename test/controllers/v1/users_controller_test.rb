require 'test_helper'

class V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get v1_users_signup_url
    assert_response :success
  end

  test "should get login" do
    get v1_users_login_url
    assert_response :success
  end

  test "should get logout" do
    get v1_users_logout_url
    assert_response :success
  end

end
