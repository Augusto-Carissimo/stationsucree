class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name_product
      t.integer :quantity_product, default: 0
      t.string :recipe

      t.timestamps
    end
  end
end
