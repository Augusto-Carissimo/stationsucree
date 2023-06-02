class CreateSupplierIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :supplier_ingredients do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
