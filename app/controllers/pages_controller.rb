class PagesController < ApplicationController
  allow_unauthenticated_access
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
