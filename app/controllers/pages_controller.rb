class PagesController < ApplicationController
  include CurrentOrder

  skip_before_action :redirect_logged_in_user, only: [:home]
  before_action :authenticate_user!, except: [:home] # Ensures the user is logged in

  def home
    redirect_to items_path if user_signed_in?
  end

  def account
    @user = current_user
  end
end
