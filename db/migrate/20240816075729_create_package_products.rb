class CreatePackageProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :package_products do |t|
      t.references :package, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
