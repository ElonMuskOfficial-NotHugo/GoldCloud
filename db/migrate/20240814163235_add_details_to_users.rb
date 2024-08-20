class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :integer, default: 2, null: false
    add_column :users, :address, :string
    add_column :users, :username, :string, null: false, default: ''
    add_index :users, :username, unique: true
  end
end
