class UserController < ApplicationController
  def profile
    @current_user = Current.user
  end
end
