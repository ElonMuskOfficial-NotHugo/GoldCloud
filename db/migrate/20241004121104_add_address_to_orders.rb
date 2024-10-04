class AddAddressToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :address, :text
  end
end
