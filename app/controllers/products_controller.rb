class ProductsController < ApplicationController
  include CurrentOrder

  before_action :authenticate_user!

  def index
    @products = Product.order(created_at: :desc)
    # @packages = Package.order(created_at: :desc)
    # @products_and_packages = @products + @packages
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = 'Product deleted.'
    redirect_to root_path
  end

  def add_to_cart
    @product = Product.find(params[:id])
    order = current_order
    order_item = order.order_items.find_or_initialize_by(product: @product)
    order_item.quantity ||= 0
    order_item.quantity += 1
    order_item.save

    flash[:notice] = "Product added! <a href='#{cart_path}' class='alert-link'>View Cart</a>".html_safe
    redirect_to @product
  end

  def remove_from_cart
    @product = Product.find(params[:id])
    @order = current_order
    order_item = @order.order_items.find_by(product: @product)

    if order_item&.destroy
      render json: { success: true, total: @order.total_price }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :available, photos: [])
  end

  # def current_order
  #   if session[:order_id]
  #     Order.find(session[:order_id])
  #   else
  #     order = Order.create(status: :created, user: current_user)
  #     session[:order_id] = order.id
  #     order
  #   end
  # end
end
