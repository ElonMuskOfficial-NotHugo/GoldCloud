class OrdersController < ApplicationController
  include CurrentOrder

  before_action :authenticate_user!
  before_action :set_order, only: [:confirm_order, :update, :order_confirmation]
  before_action :authorize_admin, only: [:update]

  def cart
    @order = current_order
    @order_items = @order.order_items.includes(:itemable)
  end

  def checkout
    @order = current_order
    if @order.order_items.empty?
      redirect_to items_path
    end
  end

  def show
    @order = Order.find(params[:id])
    unless current_user.admin? || @order.user == current_user
      redirect_to root_path, alert: 'Access denied.'
    end
  end

  def index
    @orders = if current_user.admin?
      @status = params[:status]
      orders = @status.present? ? Order.where(status: @status) : Order.all
      orders.order(created_at: :desc)
    else
      current_user.orders.order(created_at: :desc)
    end
  end

  ## this confirm_order action is actually for the user to confirm their order
  ## it only changes the status of the order from created to pending
  def confirm_order
    if @order.created? && @order.update(order_params.merge(status: :pending))
      redirect_to order_confirmation_order_path(@order), notice: "Order confirmed!"
    else
      redirect_to checkout_path, alert: "Order not confirmed. Enter delivery address."
    end
  end

  def update
    if @order.update(order_params)
      redirect_to orders_path, notice: 'Order status was successfully updated.'
    else
      render :index
    end
  end

  def order_confirmation
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def authorize_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end

  def order_params
    params.require(:order).permit(:status, :address)
  end
end
