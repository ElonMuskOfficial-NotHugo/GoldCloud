class ItemsController < ApplicationController
  include CurrentOrder

  before_action :authenticate_user!

  def index
    @items = Item.all
    @items = Item.search(params[:query]) if params[:query].present?
    @items = @items.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def add_to_cart
    @item = Item.find(params[:id])
    order = current_order

    if @item.itemable_type == 'Product'
      add_product_to_cart(order, @item.itemable)
    elsif @item.itemable_type == 'Package'
      add_package_to_cart(order, @item.itemable)
    end

    flash[:notice] = "#{@item.itemable_type} added! <a href='#{cart_path}' class='alert-link'>View Cart</a>".html_safe
    redirect_to @item
  end

  def remove_from_cart
    @item = Item.find(params[:id])
    @order = current_order

    if @item.itemable_type == 'Product'
      success = remove_product_from_cart(@order, @item.itemable)
    elsif @item.itemable_type == 'Package'
      success = remove_package_from_cart(@order, @item.itemable)
    end

    if success
      render json: { success: true, total: @order.total_price }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  private

  def add_product_to_cart(order, product)
    order_item = order.order_items.find_or_initialize_by(product: product)
    order_item.quantity ||= 0
    order_item.quantity += 1
    order_item.save
  end

  def add_package_to_cart(order, package)
    order_item = order.order_items.find_or_initialize_by(package: package)
    order_item.quantity ||= 0
    order_item.quantity += 1
    order_item.save
  end

  def remove_product_from_cart(order, product)
    order_item = order.order_items.find_by(product: product)
    order_item&.destroy
  end

  def remove_package_from_cart(order, package)
    order_item = order.order_items.find_by(package: package)
    order_item&.destroy
  end
end
