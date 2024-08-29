class PagesController < ApplicationController
  skip_before_action :redirect_logged_in_user, only: [:home]
  before_action :authenticate_user!  # Ensures the user is logged in

  def home
    redirect_to products_path if user_signed_in?
  end

  def cart
    @order = current_order
  end

  def account
    @user = current_user
  end

  def checkout
    @order = current_order
  end

  private

  def current_order
    if session[:order_id]
      Order.find_by(id: session[:order_id]) || create_new_order
    else
      create_new_order
    end
  end

  def create_new_order
    order = Order.create(user: current_user, status: :created)
    session[:order_id] = order.id
    order
  end

  # def delete_unconfirmed_order
  #   if session[:order_id]
  #     order = Order.find_by(id: session[:order_id])
  #     order.destroy if order && !order.confirmed
  #   end
  # end
end
