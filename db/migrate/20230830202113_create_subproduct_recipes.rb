class CreateSubproductRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :subproduct_recipes do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.float :quantity_recipe, default: 0

      t.timestamps
    end
  end
end
