class Package < ApplicationRecord
  has_many :package_products
  has_many :products, through: :package_products
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :available, inclusion: { in: [true, false] }

  # added methods to easily add and remove products from a package or check the quantity of a product in a package
  def add_product(product, quantity = 1)
    package_product = package_products.find_or_initialize_by(product: product)
    package_product.quantity += quantity
    package_product.save
  end

  def remove_product(product, quantity = 1)
    package_product = package_products.find_by(product: product)
    return unless package_product

    package_product.quantity -= quantity
    if package_product.quantity <= 0
      package_product.destroy
    else
      package_product.save
    end
  end

  def product_quantity(product)
    package_products.find_by(product: product)&.quantity || 0
  end
end
