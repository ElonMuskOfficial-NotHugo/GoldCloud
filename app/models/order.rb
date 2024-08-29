class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  has_many :packages, through: :order_items
  enum status: { created: 0, pending: 1, confirmed: 2, shipped: 3, delivered: 4, canceled: 5 }


  validates :user, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  def self.status_options
    statuses.keys.map { |status| [status.titleize, status] }
  end

  def total_price
    order_items.sum do |item|
      if item.product
        item.quantity * item.product.price
      elsif item.package
        item.quantity * item.package.price
      else
        0 # or raise an error if every item should have either a product or a package
      end
    end
  end
end
