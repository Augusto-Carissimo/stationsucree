# frozen_string_literal: true

class IngredientRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :quantity_recipe, numericality: { greater_than_or_equal_to: 0 }

  def price_ingredient
    @price_ingredient ||= (ingredient.last_price * quantity_recipe).round(3)
  end
end
