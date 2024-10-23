class PagesController < ApplicationController
  def index
    @current_user = Current.user if authenticated?
  end

  def terms
  end

  def privacy
  end

  def pricing
  end
end
