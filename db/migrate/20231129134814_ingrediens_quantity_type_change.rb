class IngrediensQuantityTypeChange < ActiveRecord::Migration[7.0]
  def change
    change_column :ingredients, :quantity_ingredient, :decimal
  end
end
