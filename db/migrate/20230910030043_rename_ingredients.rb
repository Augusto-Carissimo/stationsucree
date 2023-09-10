class RenameIngredients < ActiveRecord::Migration[7.0]
  def change
    rename_column :ingredients, :quantity_ingredients, :quantity_ingredient
  end
end
