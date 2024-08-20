class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  has_many :packages, through: :order_items
  enum status: { pending: 0, confirmed: 1, shipped: 2, delivered: 3, canceled: 4 }


  validates :user, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  def self.status_options
    statuses.keys.map { |status| [status.titleize, status] }
  end
end
