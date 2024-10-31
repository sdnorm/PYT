require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get profile" do
    get profile_users_path
    assert_response :success
    assert_select "h1", text: @user.name
  end

  test "should get settings" do
    get settings_users_path
    assert_response :success
    assert_select "h1", text: "Account Settings"
  end

  test "should redirect to sign in if not authenticated" do
    sign_out @user
    get profile_users_path
    assert_redirected_to new_user_session_path
    
    get settings_users_path
    assert_redirected_to new_user_session_path
  end
end
