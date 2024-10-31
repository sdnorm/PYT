require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    user = users(:one)
    sign_in_as(user)

    get user_profile_url
    assert_response :success
  end
end
