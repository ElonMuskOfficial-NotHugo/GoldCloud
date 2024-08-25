
class AddQuantityToPackageProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :package_products, :quantity, :integer, null: false, default: 1
  end
end
