require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as(@user)
  end

  test "should get profile" do
    get user_profile_path
    assert_response :success
    assert_select "h1", text: @user.name
  end

  test "should get settings" do
    get user_settings_path
    assert_response :success
    assert_select "h1", text: "Account Settings"
  end

  test "should redirect to sign in if not authenticated" do
    sign_out(@user)
    get user_profile_path
    assert_redirected_to new_session_path

    get user_settings_path
    assert_redirected_to new_session_path
  end
end
