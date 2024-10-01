class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :itemable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
