class IngredientRecipesQuantityTypeChange < ActiveRecord::Migration[7.0]
  def change
    change_column :ingredient_recipes, :quantity_recipe, :decimal
  end
end
