class PackagesController < ApplicationController
  def new
    @package = Package.new
  end

  def create
    @package = Package.new(package_params)
    @package.available = true
    if @package.save
      if params[:package][:product_ids].present?
        params[:package][:product_ids].reject(&:blank?).each do |product_id|
          PackageProduct.create(package: @package, product_id: product_id)
        end
      end
      redirect_to item_path(@package.item), notice: 'Package was successfully created.'
    else
      Rails.logger.error("Package save failed: #{@package.errors.full_messages}")
      flash.now[:alert] = "Failed to create package: #{@package.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def update

  end

  private

  def package_params
    params.require(:package).permit(:name, :description, :price, photos: [], product_ids: [])
  end
end
