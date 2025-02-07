class Package < ApplicationRecord
  has_one :item, as: :itemable, dependent: :destroy
  has_many :package_products, dependent: :destroy
  accepts_nested_attributes_for :package_products
  has_many :products, through: :package_products
  has_many :order_items, as: :itemable
  has_many :orders, through: :order_items

  has_many_attached :photos

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :available, inclusion: { in: [true, false] }

  after_create :create_item

  after_destroy :handle_order_items

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

  def primary_photo_url
    if photos.attached?
      photos.first
    else
      'default_package_image.jpg' # Make sure this file exists in your assets
    end
  end

  private

  def create_item
    build_item.save
  end

  def handle_order_items
    order_items.each(&:mark_as_deleted)
  end
end
