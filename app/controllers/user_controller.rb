class UserController < ApplicationController
  before_action :set_current_user

  def settings
    # Default to profile form for both full page and turbo frame requests
    if turbo_frame_request?
      # render "settings_profile"
      render turbo_stream: [
        turbo_stream.update("settings_content", partial: "user/forms/profile_form"),
        turbo_stream.update("settings_nav", partial: "user/settings_nav")
      ]
    else
      render "settings"
    end
  end

  def settings_profile
    if turbo_frame_request?
      # render "settings_profile"
      render turbo_stream: [
        turbo_stream.update("settings_content", partial: "user/forms/profile_form"),
        turbo_stream.update("settings_nav", partial: "user/settings_nav")
      ]
    else
      render "settings"
    end
  end

  def settings_security
    if turbo_frame_request?
      # render "settings_security"
      render turbo_stream: [
        turbo_stream.update("settings_content", partial: "user/forms/security_form"),
        turbo_stream.update("settings_nav", partial: "user/settings_nav")
      ]
    else
      render "settings"
    end
  end

  def settings_notifications
    if turbo_frame_request?
      # render "settings_notifications"
      render turbo_stream: [
        turbo_stream.update("settings_content", partial: "user/forms/notifications_form"),
        turbo_stream.update("settings_nav", partial: "user/settings_nav")
      ]
    else
      render "settings"
    end
  end

  def update_profile
    if @current_user.update(profile_params)
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.replace(
              "profile_form",
              partial: "user/forms/profile_form",
              locals: { user: @current_user }
            ),
            turbo_stream.update("flash", partial: "shared/notices",
              locals: { flash: { notice: "Profile updated successfully" } })
          ]
        }
      end
    else
      turbo_stream.update("flash", partial: "shared/notices",
        locals: { flash: { alert: "Something went wrong" } })
      render :settings_profile, status: :unprocessable_entity
    end
  end

  def update_notifications
    if @current_user.update(notification_params)
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.replace(
              "notifications_form",
              partial: "user/forms/notifications_form",
              locals: { user: @current_user }
            ),
            turbo_stream.update("flash", partial: "shared/notices",
              locals: { flash: { notice: "Notification preferences updated successfully" } })
          ]
        }
      end
    else
      turbo_stream.update("flash", partial: "shared/notices",
        locals: { flash: { alert: "Something went wrong" } })
      render :settings_notifications, status: :unprocessable_entity
    end
  end

  private

  def set_current_user
    @current_user = Current.user
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :email_address, :avatar, :title)
  end

  def notification_params
    params.require(:user).permit(:email_notifications)
  end
end
