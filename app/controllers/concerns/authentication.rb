module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :load_session
    before_action :require_authentication
    helper_method :authenticated?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def load_session
      if cookies.signed[:session_id]
        if session_record = Session.find_by(id: cookies.signed[:session_id])
          Current.session = session_record
        end
      end
    end

    def authenticated?
      Current.session&.user.present?
    end

    def require_authentication
      authenticated? || request_authentication
    end

    def request_authentication
      session[:return_to_after_authenticating] = request.url
      redirect_to new_session_url
    end

    def after_authentication_url
      session.delete(:return_to_after_authenticating) || root_url
    end

    def start_new_session_for(user)
      # First, clean up any existing session
      if Current.session
        Current.session.destroy
      end

      user.sessions.create!(
        user_agent: request.user_agent,
        ip_address: request.remote_ip
      ).tap do |session|
        Current.session = session
        cookies.signed.permanent[:session_id] = {
          value: session.id,
          httponly: true,
          same_site: :lax,
          secure: Rails.env.production?
        }
      end
    end

    def terminate_session
      Current.session.destroy
      cookies.delete(:session_id)
    end
end
