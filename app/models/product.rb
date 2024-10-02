class Product < ApplicationRecord
  has_one :item, as: :itemable, dependent: :destroy
  has_many :package_products
  has_many :packages, through: :package_products
  has_many :order_items
  has_many :orders, through: :order_items

  has_many_attached :photos

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :available, inclusion: { in: [true, false] }

  after_create :create_item

  private

  def create_item
    build_item.save
  end
end
