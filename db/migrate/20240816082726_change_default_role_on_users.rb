class ChangeDefaultRoleOnUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :role, 2
  end
end
