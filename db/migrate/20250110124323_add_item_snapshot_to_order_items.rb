class AddItemSnapshotToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :order_items, :item_snapshot, :jsonb
    add_index :order_items, :item_snapshot, using: :gin
  end
end
