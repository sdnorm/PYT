ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module AuthenticationHelper
  def sign_in_as(user)
    session = user.sessions.create!(
      user_agent: "Rails Testing",
      ip_address: "0.0.0.0"
    )

    # For test environment, we can set the encrypted cookie directly
    encrypted_cookie_value = Rails.application.message_verifier("signed cookie").generate(session.id)
    cookies[:session_id] = encrypted_cookie_value

    Current.session = session
  end

  def sign_out(user)
    user.sessions.destroy_all
    cookies.delete(:session_id)
    Current.session = nil
  end
end

class ActionDispatch::IntegrationTest
  include AuthenticationHelper
end
