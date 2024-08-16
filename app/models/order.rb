class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  enum status: { pending: 0, confirmed: 1, shipped: 2, delivered: 3, canceled: 4 }

  validates :user, presence: true
  validates :status, presence: true
end
