class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  has_many :packages, through: :order_items
  # Order is created when items are added to cart,
  # pending when customer checks out (confirm order on checkout page)
  # confirmed when admin accepts order
  # shipped when handed over to delivery driver
  # delivered once customer has received the order
  # canceled if admin cancels for some reason at any stage
  enum status: { created: 0, pending: 1, confirmed: 2, shipped: 3, delivered: 4, canceled: 5 }


  validates :user, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true


  def self.status_options
    statuses.keys.map { |status| [status.titleize, status] }
  end

  def total_price
    order_items.sum do |item|
      if item.itemable&.respond_to?(:price)
        item.quantity * item.itemable.price
      elsif item.item_snapshot
        item.quantity * item.item_snapshot['price']
      else
        0 # Return 0 for items that are completely invalid
      end
    end
  end
end
