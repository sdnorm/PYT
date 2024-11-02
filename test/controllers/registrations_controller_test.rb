require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "should create user, account, and account_user with owner role -- Full New Registration" do
    assert_difference [ "User.count", "Account.count", "AccountUser.count", "UserRole.count" ], 1 do
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
    account_user = AccountUser.last
    user_role = UserRole.last

    assert_equal user, account_user.user
    assert_equal account, account_user.account
    assert_equal "owner", user_role.name
    assert_equal account, user_role.account
    assert_equal user, user_role.user
    assert account.owner?(user)

    assert_redirected_to home_path
    assert_equal "Welcome to Play Your Team!", flash[:notice]
  end

  # test "should not create user, account, or account_user with invalid parameters" do
  #   assert_no_difference [ "User.count", "Account.count", "AccountUser.count" ] do
  #     post registration_url, params: {
  #       user: {
  #         first_name: "John",
  #         last_name: "Doe",
  #         email_address: "invalid_email",
  #         password: "password123",
  #         password_confirmation: "different_password"
  #       }
  #     }
  #   end

  #   assert_response :unprocessable_entity
  #   assert_template :new
  # end
end
