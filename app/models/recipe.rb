# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :ingredient_recipes, dependent: :destroy
  has_many :subproduct_recipes, dependent: :destroy
  belongs_to :product

  validates :product_id, uniqueness: true

  def total_price
    @total_price ||= (price_ingredients + price_subproducts).round(3)
  end

  def price_ingredients
    total = 0
    ingredient_recipes.map { |ir| total += ir.price_ingredient }
    @price_ingredients ||= total.round(2)
  end

  def price_subproducts
    total = 0
    subproduct_recipes.select { |sr| sr.product.recipe }
                      .map { |sr| total += (sr.product.recipe.price_ingredients * sr.quantity_recipe) }
    @price_subproducts ||= total.round(3)
  end

  def total_amount
    @total_amount ||= amount_ingredient.merge(amount_subproduct) { |_, o, n| o + n }
  end

  def amount_ingredient
    total = {}
    ingredient_recipes.each do |ir|
      total[ir.ingredient.name_ingredient] = ir.quantity_recipe
    end
    @amount_ingredient ||= total
  end

  def amount_subproduct
    total = {}
    subproduct_recipes.map do |sr|
      total = total.merge(sr.product.recipe.amount_ingredient) { |_, o, n| o + n }
    end
    @amount_subproduct ||= total
  end
end
