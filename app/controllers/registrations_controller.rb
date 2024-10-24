class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    @account = Account.create!

    if @user.save
      AccountUser.create!(user: @user, account: @account)
      UserRole.create!(user: @user, role_type: :admin, account: @account)
      # @user.add_role(:admin, @account)
      sign_in(@user)
      redirect_to home_path, notice: "Welcome to Play Your Team!"
    else
      @account.destroy
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
