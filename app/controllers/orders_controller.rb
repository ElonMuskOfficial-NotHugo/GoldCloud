class OrdersController < ApplicationController
  include CurrentOrder

  before_action :authenticate_user!
  before_action :set_order, only: [:confirm_order, :update]
  before_action :authorize_admin, only: [:index, :update]
  #
  def index
    # The status parameter is expected to come from the URL query string
    # e.g., /orders?status=pending
    @status = params[:status]

    @orders = if @status.present?
                Order.where(status: @status)
              else
                Order.all
              end

    @orders = @orders.order(created_at: :desc)
  end

  ## this confirm_order action is actually for the user to confirm their order
  ## it only changes the status of the order from created to pending
  def confirm_order
    if @order.created? && @order.update(status: :pending)
      redirect_to checkout_path, notice: "Order confirmed!"
    else
      redirect_to checkout_path, alert: "Order not confirmed, try again."
    end
  end

  def update
    if @order.update(order_params)
      redirect_to orders_path, notice: 'Order status was successfully updated.'
    else
      render :index
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
