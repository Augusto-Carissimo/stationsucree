class IngredientRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :quantity_recipe, numericality: { greater_than_or_equal_to: 0 }
end
