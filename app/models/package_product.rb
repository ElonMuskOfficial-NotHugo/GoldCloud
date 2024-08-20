class PackageProduct < ApplicationRecord
  belongs_to :package
  belongs_to :product

  validates :package, presence: true
  validates :product, presence: true
  validates :product_id, uniqueness: { scope: :package_id }
  validates :quantity, presence: true, numericality: { greater_than: 0, only_integer: true }
end
