require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "should create user, account, and account_user with valid parameters - new account sign up - first user" do
    assert_difference [ "User.count", "Account.count", "AccountUser.count" ], 1 do
      post registration_url, params: {
        user: {
          first_name: "John",
          last_name: "Doe",
          email_address: "john@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    user = User.last
    account = Account.last
    assert user.has_role?(:admin, account)
    assert_equal user, controller.current_user
    assert_redirected_to home_path
    assert_equal "Welcome to Play Your Team!", flash[:notice]
  end

  test "should not create user, account, or account_user with invalid parameters" do
    assert_no_difference [ "User.count", "Account.count", "AccountUser.count" ] do
      post registrations_url, params: {
        user: {
          first_name: "John",
          last_name: "Doe",
          email_address: "invalid_email",
          password: "password123",
          password_confirmation: "different_password"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_template :new
  end
end
