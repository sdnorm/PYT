class PasswordsController < ApplicationController
  allow_unauthenticated_access except: %i[ signed_in_edit signed_in_update ]

  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_url, notice: "Password reset instructions sent (if user with that email address exists)."
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_url, notice: "Password has been reset."
    else
      redirect_to edit_password_url(params[:token]), alert: "Passwords did not match."
    end
  end

  def signed_in_edit
    @current_user = Current.user
  end

  def signed_in_update
    @current_user = Current.user
    puts "GOT TO HERE"
    if @current_user.authenticate(params[:current_password])
      puts "AUTHENTICATED"
      if @current_user.update(password_params)
        puts "UPDATED"
        redirect_to user_profile_path, notice: "Password successfully updated."
      else
        render :signed_in_edit_password, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Current password is incorrect"
      render :signed_in_edit_password, status: :unprocessable_entity
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_url, alert: "Password reset link is invalid or has expired."
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
