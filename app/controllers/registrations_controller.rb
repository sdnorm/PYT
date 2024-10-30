class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    @account = Account.new(name: "My Team", owner: @user)

    if @user.save && @account.save
      account_user = AccountUser.create!(user: @user, account: @account)
      account_user.add_role(:owner)
      start_new_session_for(@user)
      redirect_to home_path, notice: "Welcome to Play Your Team!"
    else
      @account.destroy if @account.persisted?
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email_address,
      :password,
      :password_confirmation
    )
  end
end
