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
    # First, check if there's an order_id in the session
    if session[:order_id]
      order = Order.find_by(id: session[:order_id])
      return order if order && order.created?
    end

    # If no valid order in session, look for the user's last created order
    order = current_user.orders.created.last

    if order
      # If found, set the session order_id
      session[:order_id] = order.id
      return order
    end

    # If no existing order found, create a new one
    create_new_order
  end

  def create_new_order
    order = Order.create(user: current_user, status: :created)
    session[:order_id] = order.id
    order
  end
end
