class PackagesController < ApplicationController
  def new

  end

  def create

  end

  def update

  end

  private

  def package_params
    params.require(:package).permit(:name, :price, :available, photos: [])
  end
end
