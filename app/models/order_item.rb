class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :package
  belongs_to :order
end
