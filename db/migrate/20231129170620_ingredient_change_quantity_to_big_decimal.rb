class IngredientChangeQuantityToBigDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :ingredients, :quantity_ingredient, :decimal, precision: 8, scale: 3
  end
end
