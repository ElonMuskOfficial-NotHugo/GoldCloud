class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:confirm_order]
  before_action :authorize_admin, only: [:pending_orders]

  def confirm_order
    if @order.created? && @order.update(status: :pending)
      redirect_to checkout_path, notice: "Order confirmed!"
    else
      redirect_to checkout_path, alert: "Order not confirmed, try again."
    end
  end

  def pending_orders
    @orders = Order.pending
  end

  def update_status
    if @order.update(order_params)
      redirect_to pending_orders_orders_path, notice: 'Order status was successfully updated.'
    else
      render :pending_orders
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def authorize_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end

  def order_params
    params.require(:order).permit(:status)
  end
end
