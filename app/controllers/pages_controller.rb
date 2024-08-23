class PagesController < ApplicationController
  skip_before_action :redirect_logged_in_user, only: [:home]

  def home
    redirect_to products_path if user_signed_in?
  end

  private

end
