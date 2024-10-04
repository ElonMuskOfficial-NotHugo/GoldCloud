class OrderItemsController < ApplicationController
  include CurrentOrder

  def create # add to cart action
    @item = Item.find(params[:item_id])
    @order = current_order
    @order_item = @order.order_items.find_or_initialize_by(itemable: @item.itemable)
    @order_item.quantity ||= 0
    @order_item.quantity += 1

    if @order_item.save
      flash[:notice] = "#{@item.itemable_type} added! <a href='#{cart_path}' class='alert-link'>View Cart</a>".html_safe
      redirect_to @item
    else
      flash[:alert] = "Unable to add item to cart: #{order_item.errors.full_messages.join(', ')}"
      redirect_to @item
    end
  end

  def update # update quantity in cart action
    @order_item = OrderItem.find(params[:id])
    Rails.logger.info "Updating order item: #{params.inspect}"
    if @order_item.update(order_item_params)
      render json: { success: true, quantity: @order_item.quantity, total: @order_item.order.total_price }
    else
      Rails.logger.error "Failed to update order item: #{@order_item.errors.full_messages}"
      render json: { success: false, errors: @order_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy # remove from cart action
    @order_item = OrderItem.find(params[:id])

    if @order_item.destroy
      render json: { success: true, total: @order_item.order.total_price }
    else
      render json: { success: false, errors: @order_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end
end
