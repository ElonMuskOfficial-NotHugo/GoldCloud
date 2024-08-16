class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.boolean :available

      t.timestamps
    end
  end
end
