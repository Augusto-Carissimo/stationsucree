class IngredientPriceTypeChange < ActiveRecord::Migration[7.0]
  def change
    change_column :ingredients, :last_price, :decimal
  end
end
