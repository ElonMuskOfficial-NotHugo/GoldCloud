class PagesController < ApplicationController
  def home
    @user = current_user
    @products = Product.all
  end
end
