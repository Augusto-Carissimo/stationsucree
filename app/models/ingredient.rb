# frozen_string_literal: true

class Ingredient < ApplicationRecord
  validates :name_ingredient, presence:, uniqueness: true
  validates :last_price, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity_ingredient, numericality: { greater_than_or_equal_to: 0 }

  has_many :ingredient_recipes, dependent: :destroy
  has_many :price_histories, dependent: :destroy
end
