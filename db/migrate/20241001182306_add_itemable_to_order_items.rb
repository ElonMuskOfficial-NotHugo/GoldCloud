class AddItemableToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :order_items, :itemable, polymorphic: true
    # remove_reference :order_items, :product, foreign_key: true
    # remove_reference :order_items, :package, foreign_key: true
  end
end
