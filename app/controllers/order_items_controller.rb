class OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])
    Rails.logger.info "Updating order item: #{params.inspect}"
    if @order_item.update(order_item_params)
      render json: { success: true, quantity: @order_item.quantity, total: @order_item.order.total_price }
    else
      Rails.logger.error "Failed to update order item: #{@order_item.errors.full_messages}"
      render json: { success: false, errors: @order_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end
end
