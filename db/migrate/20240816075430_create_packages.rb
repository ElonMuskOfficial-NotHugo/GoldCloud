class CreatePackages < ActiveRecord::Migration[7.1]
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :price
      t.boolean :available

      t.timestamps
    end
  end
end
