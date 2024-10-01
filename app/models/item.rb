class Item < ApplicationRecord
  belongs_to :itemable, polymorphic: true

  # package instance methods
  delegate :add_product, :remove_product, :product_quantity, to: :itemable, allow_nil: true

  scope :products, -> { where(itemable_type: 'Product') }
  scope :packages, -> { where(itemable_type: 'Package') }

  def self.search(query)
    where("name ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
  end
end
