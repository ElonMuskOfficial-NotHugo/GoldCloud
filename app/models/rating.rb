class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  # validates :user_id, uniqueness: { scope: :item_id, message: "You can only rate an item once" }
  validate :user_has_ordered_item

  private

  def user_has_ordered_item
    unless user.orders.delivered.joins(:order_items)
      .where(order_items: { itemable: item.itemable }).exists?
      errors.add(:base, "You can only rate items you've ordered")
    end
  end
end
