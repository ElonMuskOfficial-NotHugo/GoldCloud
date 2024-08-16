class ChangeDefaultStatusOnOrders < ActiveRecord::Migration[7.1]
  def change
    change_column_default :orders, :status, 0
  end
end
