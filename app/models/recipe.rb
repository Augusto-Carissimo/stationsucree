class Recipe < ApplicationRecord
  has_many :ingredient_recipes, dependent: :destroy
  has_many :subproduct_recipes, dependent: :destroy
  belongs_to :product

  validates_uniqueness_of :product_id

  def total_price
    @total_price ||= price_ingredients + price_subproducts
  end

  def price_ingredients
    total = 0
    ingredient_recipes.each do |ir|
      total += (ir.ingredient.last_price * ir.quantity_recipe)
    end
    @price_ingredients ||= total.round(2)
  end

  def price_subproducts
    total = 0
    subproduct_recipes.each do |sr|
      if sr.product.recipe
        total += sr.product.recipe.price_ingredients
      end
    end
    @price_subproducts ||= total.round(2)
  end
end
