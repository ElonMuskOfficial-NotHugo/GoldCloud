class ProductsController < ApplicationController
  include CurrentOrder

  before_action :authenticate_user!

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to item_path(@product.item)
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
      redirect_to item_path(@product.item)
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

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :available, photos: [])
  end
end
