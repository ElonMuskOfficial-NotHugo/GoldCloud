class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: true, foreign_key: true
      t.references :package, null: true, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
