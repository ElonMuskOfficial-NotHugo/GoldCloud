class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true
  belongs_to :package, optional: true

  validates :order, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }


  validate :product_or_package_present

  private

  def product_or_package_present
    if product.nil? && package.nil?
      errors.add(:base, "Either product or package must be present")
    elsif product.present? && package.present?
      errors.add(:base, "Only one of product or package can be present")
    end
  end
end
