class CreatePackages < ActiveRecord::Migration[7.1]
  def change
    create_table :packages do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.boolean :available

      t.timestamps
    end
  end
end
