# frozen_string_literal: true

class AddQuantityIngredientRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredient_recipes, :quantity_recipe, :float, default: 0
  end
end
