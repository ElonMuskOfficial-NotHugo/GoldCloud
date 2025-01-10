class Product < ApplicationRecord
  has_one :item, as: :itemable, dependent: :destroy
  has_many :package_products
  has_many :packages, through: :package_products
  has_many :order_items, as: :itemable
  has_many :orders, through: :order_items

  after_destroy :handle_order_items

  has_many_attached :photos

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :available, inclusion: { in: [true, false] }

  after_create :create_item

  def primary_photo_url
    if photos.attached?
      photos.first
    else
      'default_product_image.jpg' # Make sure this file exists in assets
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
