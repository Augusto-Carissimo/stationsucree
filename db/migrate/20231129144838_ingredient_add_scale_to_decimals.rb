class IngredientAddScaleToDecimals < ActiveRecord::Migration[7.0]
  def change
    change_column :ingredients, :last_price, :decimal, precision: 8, scale: 3
  end
end
