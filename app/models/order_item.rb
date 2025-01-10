class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :itemable, polymorphic: true, optional: true

  validates :order, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  before_create :store_item_snapshot

  def store_item_snapshot
    return unless itemable

    self.item_snapshot = {
      type: itemable_type,
      id: itemable_id,
      name: itemable.name,
      price: itemable.price,
      description: itemable.description,
      deleted_at: nil
    }

    # Store additional package-specific data if it's a package
    if itemable_type == 'Package'
      self.item_snapshot['products'] = itemable.package_products.map do |pp|
        {
          id: pp.product_id,
          name: pp.product.name,
          quantity: pp.quantity
        }
      end
    end
  end

  def item_name
    if item_snapshot && item_snapshot['deleted_at']
      "#{item_snapshot['name']} (No longer available)"
    elsif itemable
      itemable.name
    else
      'Unavailable item'
    end
  end

  def item_price
    if itemable
      itemable.price
    elsif item_snapshot
      item_snapshot['price']
    else
      0
    end
  end

  def mark_as_deleted
    return unless item_snapshot

    self.item_snapshot = item_snapshot.merge('deleted_at' => Time.current)
    save!
  end
end
